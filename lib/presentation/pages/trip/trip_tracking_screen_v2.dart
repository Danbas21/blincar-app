import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/video/video_stream_bloc.dart';
import '../../bloc/video/video_stream_event.dart';
import '../../bloc/video/video_stream_state.dart';
import '../../../core/services/service_locator.dart';
import '../../../domain/repositories/video_stream_repository.dart';

class TripTrackingScreenV2 extends StatelessWidget {
  final String tripId;
  final String driverId;

  const TripTrackingScreenV2({
    required this.tripId,
    required this.driverId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoStreamBloc(
        repository: getIt<VideoStreamRepository>(),
      )..add(InitializeVideoEvent(tripId: tripId, driverId: driverId)),
      child: _TripTrackingView(tripId: tripId, driverId: driverId),
    );
  }
}

class _TripTrackingView extends StatelessWidget {
  final String tripId;
  final String driverId;

  const _TripTrackingView({
    required this.tripId,
    required this.driverId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viaje en Curso'),
        backgroundColor: Colors.green,
      ),
      body: BlocConsumer<VideoStreamBloc, VideoStreamState>(
        listener: (context, state) {
          if (state is VideoStreamError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is VideoStreamInitializing) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Inicializando cámara...'),
                ],
              ),
            );
          }

          if (state is VideoStreamReady) {
            // Auto-start
            context.read<VideoStreamBloc>().add(
                  StartStreamingEvent(sessionId: state.sessionId),
                );
          }

          if (state is VideoStreamActive) {
            return _buildActiveView(context, state);
          }

          if (state is VideoStreamStopped) {
            return _buildStoppedView(context, state);
          }

          return Center(child: Text('Estado: ${state.runtimeType}'));
        },
      ),
    );
  }

  Widget _buildActiveView(BuildContext context, VideoStreamActive state) {
    return Column(
      children: [
        // Cámara Preview (simplificado)
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, size: 100, color: Colors.white54),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.fiber_manual_record,
                            color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'GRABANDO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Info
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sesión: ${state.sessionId}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  'Chunks subidos: ${state.chunksUploaded}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Tamaño total: ${state.totalSizeMB} MB',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),

        // Botón finalizar
        Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              context.read<VideoStreamBloc>().add(
                    StopStreamingEvent(sessionId: state.sessionId),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text(
              'FINALIZAR VIAJE',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoppedView(BuildContext context, VideoStreamStopped state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 100, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Viaje Finalizado',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text('Total chunks: ${state.totalChunks}'),
          Text('Total grabado: ${state.totalSizeMB} MB'),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Volver'),
          ),
        ],
      ),
    );
  }
}
