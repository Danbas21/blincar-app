import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

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

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _videoController;
  bool _videoInitialized = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _initVideo();

    // Timeout de seguridad: si en 10s no navega, ir a login
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && !_hasNavigated) {
        _navigateToLogin();
      }
    });
  }

  Future<void> _initVideo() async {
    _videoController = VideoPlayerController.asset('assets/video/splash.mp4');

    try {
      await _videoController.initialize();

      if (!mounted) return;

      setState(() => _videoInitialized = true);

      // Reproducir el video sin loop
      await _videoController.setLooping(false);
      await _videoController.setVolume(1.0);
      await _videoController.play();

      // Verificar auth cuando el video lleva ~1 segundo reproduciéndose
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          context.read<AuthBloc>().add(CheckAuthStatus());
        }
      });

      // Cuando el video termina, asegurarse de navegar
      _videoController.addListener(_onVideoEnd);
    } catch (e) {
      // Si el video falla, usar splash de fallback con logo
      if (mounted) {
        setState(() => _videoInitialized = false);
        // Verificar auth de todas formas
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            context.read<AuthBloc>().add(CheckAuthStatus());
          }
        });
      }
    }
  }

  void _onVideoEnd() {
    if (_videoController.value.position >= _videoController.value.duration &&
        !_videoController.value.isPlaying &&
        _videoController.value.duration > Duration.zero) {
      // Video terminó - si ya teníamos el resultado del auth, navegar
      // Si no, esperar (el BlocListener lo manejará)
    }
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
    _videoController.removeListener(_onVideoEnd);
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Esperar a que el video termine si queda poco tiempo
            final remaining = _videoController.value.duration -
                _videoController.value.position;
            if (_videoInitialized && remaining.inMilliseconds > 500) {
              Future.delayed(
                remaining.inMilliseconds > 3000
                    ? const Duration(milliseconds: 500)
                    : remaining,
                () {
                  if (mounted) _navigateToHome();
                },
              );
            } else {
              _navigateToHome();
            }
          } else if (state is AuthUnauthenticated || state is AuthError) {
            final remaining = _videoController.value.duration -
                _videoController.value.position;
            if (_videoInitialized && remaining.inMilliseconds > 500) {
              Future.delayed(
                remaining.inMilliseconds > 3000
                    ? const Duration(milliseconds: 500)
                    : remaining,
                () {
                  if (mounted) _navigateToLogin();
                },
              );
            } else {
              _navigateToLogin();
            }
          }
        },
        child: _videoInitialized
            ? _buildVideoSplash()
            : _buildFallbackSplash(),
      ),
    );
  }

  Widget _buildVideoSplash() {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _videoController.value.size.width,
          height: _videoController.value.size.height,
          child: VideoPlayer(_videoController),
        ),
      ),
    );
  }

  // Splash de respaldo si el video falla
  Widget _buildFallbackSplash() {
    return Container(
      color: AppTheme.backgroundColor,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_taxi,
              size: 80,
              color: AppTheme.primaryLightColor,
            ),
            SizedBox(height: 24),
            Text(
              'BLINCAR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
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
  }
}
