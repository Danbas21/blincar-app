// lib/presentation/pages/driver/driver_login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/theme/app_theme.dart';
import 'driver_home_page.dart';

class DriverLoginPage extends StatefulWidget {
  const DriverLoginPage({super.key});

  @override
  State<DriverLoginPage> createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Verificar si ya hay sesión activa
    _checkExistingSession();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingSession() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Buscar datos del conductor por email
      await _loginWithUser(user);
    }
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Ingresa email y contraseña');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      _log('Intentando login con: $email');

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _loginWithUser(credential.user!);
      }
    } on FirebaseAuthException catch (e) {
      _log('Error FirebaseAuth: ${e.code}');
      setState(() {
        _isLoading = false;
        _errorMessage = _getErrorMessage(e.code);
      });
    } catch (e) {
      _log('Error general: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: $e';
      });
    }
  }

  Future<void> _loginWithUser(User user) async {
    _log('Usuario autenticado: ${user.email}');

    // Buscar conductor por email en Firebase Database
    final driversSnapshot = await _database.child('blincar/drivers').once();
    final driversData = driversSnapshot.snapshot.value as Map?;

    if (driversData == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'No hay conductores registrados';
      });
      return;
    }

    // Buscar conductor por email
    Map<String, dynamic>? driverData;
    String? driverId;

    for (final entry in driversData.entries) {
      final data = entry.value as Map;
      if (data['email'] == user.email) {
        driverId = entry.key as String;
        driverData = Map<String, dynamic>.from(data);
        break;
      }
    }

    if (driverData == null || driverId == null) {
      _log('No se encontró conductor con email: ${user.email}');
      setState(() {
        _isLoading = false;
        _errorMessage = 'No tienes perfil de conductor registrado';
      });
      return;
    }

    _log('Conductor encontrado: ${driverData['fullName']}');

    if (!mounted) return;

    // Navegar al home del conductor
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DriverHomePage(
          driverId: driverId!,
          driverName: driverData!['fullName'] ?? 'Conductor',
        ),
      ),
    );
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'invalid-email':
        return 'Email inválido';
      case 'invalid-credential':
        return 'Credenciales inválidas';
      default:
        return 'Error de autenticación: $code';
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[DriverLogin] $message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.successColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.local_taxi,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // Título
              const Text(
                'Blincar Driver',
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'App del Conductor',
                style: TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 48),

              // Email field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: AppTheme.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Password field
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: AppTheme.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
              ),

              // Error message
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.errorColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: AppTheme.errorColor, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: AppTheme.errorColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 32),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.successColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.successColor.withValues(alpha: 0.3),
                  ),
                ),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: AppTheme.successColor),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Usa el email de tu perfil de conductor',
                            style: TextStyle(
                              color: AppTheme.successColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ejemplo: juan.perez@blincar.com',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
