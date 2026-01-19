// lib/domain/domain.dart

// ===== DOMAIN LAYER EXPORTS =====

// Entities
export 'entities/user.dart';
export 'entities/driver.dart';
export 'entities/vehicle.dart';
export 'entities/service_type.dart';
export 'entities/service_package.dart';
export 'entities/trip_request.dart';
export 'entities/active_trip.dart';
export 'entities/trip/trip_entity.dart';
export 'entities/video/video_chunk.dart';

// Value Objects
export 'value_objects/coordinates.dart';
export 'value_objects/location.dart';

// Repositories - Segregated Interfaces (SOLID - Interface Segregation)
export 'repositories/auth_repository.dart';
export 'repositories/trip_repository.dart';
export 'repositories/trip_read_repository.dart';
export 'repositories/trip_write_repository.dart';
export 'repositories/trip_monitor_repository.dart';

// Use cases - Auth
export 'usecases/auth/login_usecase.dart';
export 'usecases/auth/register_usecase.dart';

// Use cases - Trip
export 'usecases/trip/create_trip_request_usecase.dart';
export 'usecases/trip/get_trip_by_id_usecase.dart';
export 'usecases/trip/get_user_active_trip_usecase.dart';
export 'usecases/trip/get_user_trips_usecase.dart';
export 'usecases/trip/watch_trip_usecase.dart';
