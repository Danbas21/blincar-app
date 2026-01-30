// lib/presentation/widgets/video/rtsp_video_player.dart

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../../../core/constants/camera_constants.dart';

/// Widget que muestra el stream de video RTSP de la cámara Hikvision
///
/// Este widget maneja:
/// - Conexión al stream RTSP
/// - Reproducción automática
/// - Reconexión en caso de error
/// - Controles de reproducción
///
/// Uso:
/// ```dart
/// RtspVideoPlayer(
///   streamUrl: CameraConstants.mainStreamUrl,
///   autoPlay: true,
/// )
/// ```
class RtspVideoPlayer extends StatefulWidget {
  final String? streamUrl;
  final bool autoPlay;
  final bool showControls;
  final bool highQuality;

  const RtspVideoPlayer({
    super.key,
    this.streamUrl,
    this.autoPlay = true,
    this.showControls = true,
    this.highQuality = true,
  });

  @override
  State<RtspVideoPlayer> createState() => _RtspVideoPlayerState();
}

class _RtspVideoPlayerState extends State<RtspVideoPlayer> {
  late VlcPlayerController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    final url = widget.streamUrl ??
        CameraConstants.getStreamUrl(highQuality: widget.highQuality);

    _controller = VlcPlayerController.network(
      url,
      hwAcc: HwAcc.full, // Aceleración por hardware
      autoPlay: widget.autoPlay,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          VlcAdvancedOptions.networkCaching(CameraConstants.bufferSize),
        ]),
        video: VlcVideoOptions([
          VlcVideoOptions.dropLateFrames(true),
          VlcVideoOptions.skipFrames(true),
        ]),
      ),
    );

    _controller.addListener(_playerListener);
  }

  void _playerListener() {
    if (!mounted) return;

    final state = _controller.value.playingState;

    if (state == PlayingState.playing) {
      setState(() {
        _isLoading = false;
        _hasError = false;
      });
    } else if (state == PlayingState.error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Error al conectar con la cámara';
      });

      // Intentar reconectar después de un delay
      Future.delayed(
        Duration(milliseconds: CameraConstants.reconnectDelay),
        () {
          if (mounted) {
            _controller.play();
          }
        },
      );
    } else if (state == PlayingState.buffering) {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_playerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Video Player
          Center(
            child: VlcPlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
              placeholder: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ),

          // Loading Indicator
          if (_isLoading && !_hasError)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Conectando con la cámara...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

          // Error State
          if (_hasError)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage ?? 'Error desconocido',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _hasError = false;
                      });
                      _controller.play();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            ),

          // Controls (opcional)
          if (widget.showControls && !_isLoading && !_hasError)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      },
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.stop, color: Colors.white),
                      onPressed: () => _controller.stop(),
                    ),
                  ],
                ),
              ),
            ),

          // Recording Indicator
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.fiber_manual_record,
                      color: Colors.white, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'EN VIVO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
