// lib/data/repositories/firebase_auth_repository.dart

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementación de AuthRepository usando Firebase Authentication
///
/// Esta clase maneja autenticación y gestión de perfil con Firebase.
///
/// Principios SOLID aplicados:
/// - Single Responsibility: Solo maneja autenticación y perfil de usuario
/// - Dependency Inversion: Implementa la interfaz AuthRepository del dominio
class FirebaseAuthRepository implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;
  final FirebaseDatabase _firebaseDatabase;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseStorage? firebaseStorage,
    FirebaseDatabase? firebaseDatabase,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
        _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Referencia a la colección de usuarios en Realtime Database
  DatabaseReference get _usersRef => _firebaseDatabase.ref('blincar/users');

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return Left(AuthenticationFailure('No se pudo iniciar sesión'));
      }

      final user = await _getUserWithDatabaseData(credential.user!);
      return Right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String fullName,
    required String emergencyContactName,
    required String emergencyContactPhone,
    String? phoneNumber,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return Left(AuthenticationFailure('No se pudo crear la cuenta'));
      }

      // Actualizar perfil con el nombre
      await credential.user!.updateDisplayName(fullName);

      // Guardar datos adicionales en Realtime Database
      await _usersRef.child(credential.user!.uid).set({
        'id': credential.user!.uid,
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber ?? '',
        'emergencyContactName': emergencyContactName,
        'emergencyContactPhone': emergencyContactPhone,
        'photoURL': null,
        'phoneVerified': false,
        'emailVerified': false,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      final user = await _getUserWithDatabaseData(credential.user!);
      return Right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al cerrar sesión: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Left(AuthenticationFailure('No hay usuario autenticado'));
      }

      final user = await _getUserWithDatabaseData(firebaseUser);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('Error al obtener usuario: ${e.toString()}'));
    }
  }

  // ========================================
  // MÉTODOS DE EDICIÓN DE PERFIL
  // ========================================

  @override
  Future<Either<Failure, User>> updateProfile({
    required String fullName,
    String? phoneNumber,
    String? emergencyContactName,
    String? emergencyContactPhone,
  }) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Left(AuthenticationFailure('No hay usuario autenticado'));
      }

      // Actualizar displayName en Firebase Auth
      await firebaseUser.updateDisplayName(fullName);

      // Actualizar datos en Realtime Database
      final updates = <String, dynamic>{
        'fullName': fullName,
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (phoneNumber != null) {
        updates['phoneNumber'] = phoneNumber;
      }
      if (emergencyContactName != null) {
        updates['emergencyContactName'] = emergencyContactName;
      }
      if (emergencyContactPhone != null) {
        updates['emergencyContactPhone'] = emergencyContactPhone;
      }

      await _usersRef.child(firebaseUser.uid).update(updates);

      // Recargar usuario y retornar datos actualizados
      await firebaseUser.reload();
      final updatedUser = await _getUserWithDatabaseData(
        _firebaseAuth.currentUser!,
      );

      return Right(updatedUser);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(ServerFailure('Error al actualizar perfil: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> updateEmail({
    required String newEmail,
    required String currentPassword,
  }) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Left(AuthenticationFailure('No hay usuario autenticado'));
      }

      // Re-autenticar usuario antes de cambiar email
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: firebaseUser.email!,
        password: currentPassword,
      );

      await firebaseUser.reauthenticateWithCredential(credential);

      // Actualizar email en Firebase Auth
      await firebaseUser.verifyBeforeUpdateEmail(newEmail);

      // Actualizar email en Realtime Database
      await _usersRef.child(firebaseUser.uid).update({
        'email': newEmail,
        'emailVerified': false,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      // Recargar usuario
      await firebaseUser.reload();
      final updatedUser = await _getUserWithDatabaseData(
        _firebaseAuth.currentUser!,
      );

      return Right(updatedUser);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(ServerFailure('Error al actualizar email: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Left(AuthenticationFailure('No hay usuario autenticado'));
      }

      // Re-autenticar usuario antes de cambiar contraseña
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: firebaseUser.email!,
        password: currentPassword,
      );

      await firebaseUser.reauthenticateWithCredential(credential);

      // Actualizar contraseña
      await firebaseUser.updatePassword(newPassword);

      // Actualizar timestamp en Realtime Database
      await _usersRef.child(firebaseUser.uid).update({
        'updatedAt': DateTime.now().toIso8601String(),
      });

      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(
        ServerFailure('Error al actualizar contraseña: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePhoto({
    required File imageFile,
  }) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Left(AuthenticationFailure('No hay usuario autenticado'));
      }

      // Crear referencia única para la imagen
      final fileName =
          'profile_${firebaseUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef =
          _firebaseStorage.ref().child('profile_photos').child(fileName);

      // Subir archivo
      final uploadTask = await storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Obtener URL de descarga
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return Right(downloadUrl);
    } on FirebaseException catch (e) {
      return Left(ServerFailure('Error al subir imagen: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Error al subir imagen: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfilePhotoUrl({
    required String photoUrl,
  }) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return Left(AuthenticationFailure('No hay usuario autenticado'));
      }

      // Actualizar photoURL en Firebase Auth
      await firebaseUser.updatePhotoURL(photoUrl);

      // Actualizar en Realtime Database
      await _usersRef.child(firebaseUser.uid).update({
        'photoURL': photoUrl,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      // Recargar usuario
      await firebaseUser.reload();
      final updatedUser = await _getUserWithDatabaseData(
        _firebaseAuth.currentUser!,
      );

      return Right(updatedUser);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(
        ServerFailure('Error al actualizar foto de perfil: ${e.toString()}'),
      );
    }
  }

  // ========================================
  // AUTENTICACIÓN SOCIAL
  // ========================================

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      // Iniciar flujo de autenticación con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return Left(AuthenticationFailure('Inicio de sesión cancelado'));
      }

      // Obtener credenciales de autenticación
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crear credencial de Firebase
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión en Firebase
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        return Left(AuthenticationFailure('No se pudo iniciar sesión'));
      }

      // Verificar si es usuario nuevo para crear datos en la base de datos
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        await _createUserInDatabase(userCredential.user!);
      }

      final user = await _getUserWithDatabaseData(userCredential.user!);
      return Right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(
          ServerFailure('Error al iniciar sesión con Google: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithApple() async {
    try {
      // Generar nonce para seguridad
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Solicitar credenciales de Apple
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Crear credencial de Firebase
      final oauthCredential =
          firebase_auth.OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Iniciar sesión en Firebase
      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      if (userCredential.user == null) {
        return Left(AuthenticationFailure('No se pudo iniciar sesión'));
      }

      // Verificar si es usuario nuevo para crear datos en la base de datos
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        // Apple solo devuelve el nombre en el primer inicio de sesión
        String? fullName;
        if (appleCredential.givenName != null ||
            appleCredential.familyName != null) {
          fullName =
              '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
                  .trim();
        }
        await _createUserInDatabase(
          userCredential.user!,
          fullName: fullName!.isNotEmpty ? fullName : null,
        );
      }

      final user = await _getUserWithDatabaseData(userCredential.user!);
      return Right(user);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return Left(AuthenticationFailure('Inicio de sesión cancelado'));
      }
      return Left(AuthenticationFailure('Error de Apple: ${e.message}'));
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(
          ServerFailure('Error al iniciar sesión con Apple: ${e.toString()}'));
    }
  }

  /// Crea el usuario en la base de datos para autenticación social
  Future<void> _createUserInDatabase(
    firebase_auth.User firebaseUser, {
    String? fullName,
  }) async {
    await _usersRef.child(firebaseUser.uid).set({
      'id': firebaseUser.uid,
      'email': firebaseUser.email ?? '',
      'fullName': fullName ?? firebaseUser.displayName ?? 'Usuario',
      'phoneNumber': firebaseUser.phoneNumber ?? '',
      'emergencyContactName': '',
      'emergencyContactPhone': '',
      'photoURL': firebaseUser.photoURL,
      'phoneVerified': false,
      'emailVerified': firebaseUser.emailVerified,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  /// Genera un nonce aleatorio para Apple Sign In
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Genera el hash SHA256 de un string
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // ========================================
  // HELPERS
  // ========================================

  /// Stream de cambios de autenticación
  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return await _getUserWithDatabaseData(firebaseUser);
    });
  }

  /// Obtiene usuario combinando datos de Firebase Auth y Realtime Database
  ///
  /// Incluye timeout de 5 segundos para evitar que la app se quede colgada
  /// si Firebase Database niega permiso o tiene problemas de conexion
  Future<User> _getUserWithDatabaseData(
    firebase_auth.User firebaseUser,
  ) async {
    try {
      // Intentar obtener datos adicionales de la base de datos
      // Con timeout de 5 segundos para evitar que se quede colgada
      final snapshot = await _usersRef
          .child(firebaseUser.uid)
          .get()
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw TimeoutException('Database timeout'),
          );

      if (snapshot.exists && snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return User(
          id: firebaseUser.uid,
          email: data['email'] ?? firebaseUser.email ?? '',
          fullName: data['fullName'] ?? firebaseUser.displayName ?? 'Usuario',
          phoneNumber: data['phoneNumber'] ?? firebaseUser.phoneNumber ?? '',
          photoURL: data['photoURL'] ?? firebaseUser.photoURL,
          phoneVerified: data['phoneVerified'] ?? false,
          emailVerified: data['emailVerified'] ?? firebaseUser.emailVerified,
          emergencyContactName: data['emergencyContactName'],
          emergencyContactPhone: data['emergencyContactPhone'],
          createdAt: data['createdAt'] != null
              ? DateTime.parse(data['createdAt'])
              : firebaseUser.metadata.creationTime ?? DateTime.now(),
        );
      }

      // Si no hay datos en la base de datos, usar solo datos de Firebase Auth
      return _mapFirebaseUserToUser(firebaseUser);
    } catch (e) {
      // En caso de error (permission denied, timeout, etc), usar solo datos de Firebase Auth
      return _mapFirebaseUserToUser(firebaseUser);
    }
  }

  /// Mapea un FirebaseUser a nuestra entidad User del dominio (fallback)
  User _mapFirebaseUserToUser(firebase_auth.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      fullName: firebaseUser.displayName ?? 'Usuario',
      phoneNumber: firebaseUser.phoneNumber ?? '',
      photoURL: firebaseUser.photoURL,
      emailVerified: firebaseUser.emailVerified,
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
    );
  }

  /// Mapea excepciones de Firebase a nuestros Failures del dominio
  Failure _mapFirebaseAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthenticationFailure('Usuario no encontrado');
      case 'wrong-password':
        return AuthenticationFailure('Contraseña incorrecta');
      case 'email-already-in-use':
        return AuthenticationFailure('El correo ya está registrado');
      case 'weak-password':
        return AuthenticationFailure('La contraseña es muy débil');
      case 'invalid-email':
        return ValidationFailure('Correo electrónico inválido');
      case 'user-disabled':
        return AuthenticationFailure('Esta cuenta ha sido deshabilitada');
      case 'too-many-requests':
        return AuthenticationFailure('Demasiados intentos. Intenta más tarde');
      case 'network-request-failed':
        return NetworkFailure('Sin conexión a internet');
      case 'requires-recent-login':
        return AuthenticationFailure(
          'Por seguridad, debes iniciar sesión nuevamente',
        );
      case 'invalid-credential':
        return AuthenticationFailure('Credenciales inválidas');
      default:
        return ServerFailure('Error de autenticación: ${e.message}');
    }
  }
}
