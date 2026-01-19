// lib/domain/repositories/trip_monitor_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/trip/trip_entity.dart';
import '../../core/errors/failures.dart';

/// Interfaz para operaciones de monitoreo de viajes
///
/// Interface Segregation: Solo contiene metodos para el panel de monitor.
/// Util para administradores y operadores que supervisan viajes.
///
/// Principio: Los clientes no deben depender de interfaces que no usan.
///
/// Esta interfaz es usada exclusivamente por:
/// - Panel de Monitor (web o app)
/// - Dashboard de administracion
/// - Servicios de reportes
abstract class TripMonitorRepository {
  /// Obtener todas las solicitudes pendientes de asignacion
  ///
  /// Returns lista de viajes en estado 'requested'.
  /// El monitor usara esta lista para asignar conductores.
  Future<Either<Failure, List<TripEntity>>> getPendingRequests();

  /// Stream de solicitudes pendientes
  ///
  /// Emite actualizaciones cuando:
  /// - Llega una nueva solicitud
  /// - Una solicitud es asignada (se remueve de la lista)
  /// - Una solicitud es cancelada (se remueve de la lista)
  Stream<Either<Failure, List<TripEntity>>> watchPendingRequests();

  /// Obtener todos los viajes actualmente en progreso
  ///
  /// Returns lista de viajes en estado 'in_progress'.
  /// Util para monitorear viajes en tiempo real.
  Future<Either<Failure, List<TripEntity>>> getActiveTrips();

  /// Stream de viajes en progreso
  ///
  /// Emite actualizaciones cuando:
  /// - Un viaje inicia (se agrega a la lista)
  /// - Un viaje termina o se cancela (se remueve de la lista)
  /// - Cambia la ubicacion del conductor (si se incluye)
  Stream<Either<Failure, List<TripEntity>>> watchActiveTrips();
}
