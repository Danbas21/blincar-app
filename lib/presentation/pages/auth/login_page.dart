// lib/presentation/pages/auth/login_page.dart

import 'package:blincar_app/presentation/pages/auth/register_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/images_constant.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthEvent.login(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  void _handleGoogleSignIn() {
    context.read<AuthBloc>().add(const AuthEvent.signInWithGoogle());
  }

  void _handleAppleSignIn() {
    context.read<AuthBloc>().add(const AuthEvent.signInWithApple());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    // Logo
                    SvgPicture.asset(
                      ImagesBlincar.whiteElephant,
                      width: 100,
                      height: 100,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Titulo principal
                    const Text(
                      'MOVILIDAD DE ALTO NIVEL\nCON SEGURIDAD TOTAL.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Subtitulo
                    const Text(
                      'INICIA SESION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Campo de email
                    _buildGradientTextField(
                      controller: _emailController,
                      hintText: 'Correo Electronico Corporativo o Personal*',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    // Campo de password
                    _buildGradientTextField(
                      controller: _passwordController,
                      hintText: 'Contrasena*',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Olvidaste contrasena
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          '?Has olvidado tu contrasena?',
                          style: TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Boton Iniciar Sesion
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return _buildOutlinedButton(
                          text: 'Iniciar Sesion',
                          onPressed: state is AuthLoading ? null : _handleLogin,
                          isLoading: state is AuthLoading,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Link de registro
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: '?Eres nuevo en BlinCar? ',
                          style: TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: '!Inscribete!',
                              style: TextStyle(
                                color: AppTheme.textPrimaryColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Divisor con "o"
                    _buildDividerWithText('o'),
                    const SizedBox(height: 24),
                    // Botones de autenticacion social
                    // Apple Sign In solo disponible en iOS nativo (no web)
                    if (!kIsWeb &&
                        Theme.of(context).platform == TargetPlatform.iOS) ...[
                      _buildSocialButton(
                        icon: Icons.apple,
                        text: 'Continuar con Apple',
                        onPressed: _handleAppleSignIn,
                      ),
                      const SizedBox(height: 12),
                    ],
                    _buildSocialButton(
                      iconWidget: _buildGoogleIcon(),
                      text: 'Continuar con Google',
                      onPressed: _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 12),
                    _buildSocialButton(
                      icon: Icons.facebook,
                      iconColor: const Color(0xFF1877F2),
                      text: 'Continuar con Facebook',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Facebook Sign In proximamente'),
                            backgroundColor: AppTheme.primaryLightColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00C6FF),
            Color(0xFF001580),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(10.5),
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: 200,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    IconData? icon,
    Widget? iconWidget,
    Color? iconColor,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00C6FF),
            Color(0xFF001580),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(1.5),
      child: Material(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10.5),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                if (iconWidget != null)
                  iconWidget
                else if (icon != null)
                  Icon(
                    icon,
                    color: iconColor ?? Colors.white,
                    size: 24,
                  ),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(4),
      child: const Text(
        'G',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF4285F4),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
