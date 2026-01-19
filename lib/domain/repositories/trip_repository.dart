// lib/domain/repositories/trip_repository.dart

import 'trip_read_repository.dart';
import 'trip_write_repository.dart';
import 'trip_monitor_repository.dart';

/// Repository compuesto para gestion completa de viajes
///
/// Extiende las tres interfaces segregadas para mantener
/// compatibilidad con codigo existente que usa TripRepository.
///
/// Interface Segregation aplicado:
/// - [TripReadRepository]: Operaciones de lectura (usuarios)
/// - [TripWriteRepository]: Operaciones de escritura (usuarios, conductores)
/// - [TripMonitorRepository]: Operaciones de monitoreo (administradores)
///
/// Uso recomendado:
/// - Componentes de usuario: usar TripReadRepository
/// - Componentes de conductor: usar TripReadRepository + TripWriteRepository
/// - Panel de monitor: usar TripMonitorRepository + TripWriteRepository
/// - Implementaciones completas: usar TripRepository
///
/// Ejemplo:
/// ```dart
/// // En un Use Case de usuario que solo lee viajes
/// class GetUserTripsUseCase {
///   final TripReadRepository repository;
///   // ...
/// }
///
/// // En un Use Case de monitor que necesita todo
/// class MonitorService {
///   final TripMonitorRepository monitorRepo;
///   final TripWriteRepository writeRepo;
///   // ...
/// }
/// ```
abstract class TripRepository
    implements TripReadRepository, TripWriteRepository, TripMonitorRepository {}
