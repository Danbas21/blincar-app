import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._(); // Constructor privado para métodos custom

  const factory User({
    required String id,
    required String email,
    required String phoneNumber,
    required String fullName,
    // final UserRole role,
    // final UserStatus status,
    String? photoURL,
    @Default(false) bool phoneVerified,
    @Default(false) bool emailVerified,
    String? emergencyContactName,
    String? emergencyContactPhone,
    required DateTime createdAt,
    // final DateTime updatedAt,
  }) = _User;

  // JSON serialization estándar (generado por Freezed)
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Factory adicional para conversión desde API personalizada
  /// Convierte desde formato de API externa (snake_case)
  factory User.fromApiJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone'] as String,
      fullName: json['first_name'] as String,
      photoURL: json['profile_image'] as String?,
      phoneVerified: json['phone_verified'] as bool? ?? false,
      emailVerified: json['email_verified'] as bool? ?? false,
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // Método custom para toJson con formato de API (snake_case)
  /// Convierte a formato de API externa
  Map<String, dynamic> toApiJson() {
    return {
      'id': id,
      'email': email,
      'phone': phoneNumber,
      'full_name': fullName,
      'profile_image': photoURL,
      'phone_verified': phoneVerified,
      'email_verified': emailVerified,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_phone': emergencyContactPhone,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

enum UserRole {
  passenger,
  driver,
  admin,
}

enum UserStatus {
  active,
  inactive,
  suspended,
}
