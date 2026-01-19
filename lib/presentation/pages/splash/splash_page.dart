import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../core/theme/app_theme.dart';
import '../auth/login_page.dart';
import '../home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // Animación del logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Iniciar animación
    _controller.forward();

    // Despues de 2 segundos, verificar autenticacion
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<AuthBloc>().add(CheckAuthStatus());
      }
    });

    // Timeout de seguridad: si despues de 10 segundos no se navego,
    // ir a login para evitar que la app se quede pegada
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && !_hasNavigated) {
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    if (_hasNavigated) return;
    _hasNavigated = true;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _navigateToHome() {
    if (_hasNavigated) return;
    _hasNavigated = true;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _navigateToHome();
          } else if (state is AuthUnauthenticated || state is AuthError) {
            // En caso de error tambien redirigir a login
            _navigateToLogin();
          }
        },
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.primaryLightColor, Color(0xFF0F4C75)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryLightColor.withAlpha(100),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.local_taxi,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Nombre
                      const Text(
                        'BLINCAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Slogan
                      const Text(
                        'Transporte Seguro',
                        style: TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 60),

                      // Loading
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppTheme.primaryLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
