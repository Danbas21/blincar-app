import '../../domain/entities/trip.dart';

class DocumentItem {
  final String id;
  final String name;
  final String description;
  final String type;
  final DocumentStatus status;
  final DateTime? uploadDate;
  final DateTime? expiryDate;
  final String? comments;

  DocumentItem({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
    this.uploadDate,
    this.expiryDate,
    this.comments,
  });
}

enum DocumentStatus {
  approved,
  pending,
  rejected,
  expired,
  missing,
}

// LUEGO CONTINÚA CON LAS DEMÁS CLASES...

class MockData {
  static List<DailyEarning> getDailyEarnings() {
    return [
      DailyEarning(
          date: DateTime.now().subtract(const Duration(days: 6)),
          amount: 450.50),
      DailyEarning(
          date: DateTime.now().subtract(const Duration(days: 5)),
          amount: 620.30),
      DailyEarning(
          date: DateTime.now().subtract(const Duration(days: 4)),
          amount: 380.75),
      DailyEarning(
          date: DateTime.now().subtract(const Duration(days: 3)),
          amount: 520.00),
      DailyEarning(
          date: DateTime.now().subtract(const Duration(days: 2)),
          amount: 750.25),
      DailyEarning(
          date: DateTime.now().subtract(const Duration(days: 1)),
          amount: 680.90),
      DailyEarning(date: DateTime.now(), amount: 420.15),
    ];
  }

  static List<MonthlyStats> getMonthlyStats() {
    return [
      MonthlyStats(month: 'Ene', earnings: 12450.50, trips: 85),
      MonthlyStats(month: 'Feb', earnings: 13200.30, trips: 92),
      MonthlyStats(month: 'Mar', earnings: 14750.75, trips: 98),
      MonthlyStats(month: 'Abr', earnings: 13900.00, trips: 89),
      MonthlyStats(month: 'May', earnings: 15500.25, trips: 105),
      MonthlyStats(month: 'Jun', earnings: 16800.90, trips: 112),
    ];
  }

  static List<Trip> getRecentTrips() {
    return [
      Trip(
        id: '1',
        passengerId: 'user1',
        driverId: 'driver1',
        status: TripStatus.completed,
        originAddress: 'Polanco, CDMX',
        destinationAddress: 'Roma Norte, CDMX',
        originCoordinates:
            const Coordinates(latitude: 19.4326, longitude: -99.1332),
        destinationCoordinates:
            const Coordinates(latitude: 19.4185, longitude: -99.1636),
        actualPrice: 185.50,
        actualDistance: 8.2,
        actualDuration: 25,
        requestedAt: DateTime.now().subtract(const Duration(hours: 2)),
        completedAt:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 35)),
        ratingByPassenger: 5,
      ),
      Trip(
        id: '2',
        passengerId: 'user2',
        driverId: 'driver1',
        status: TripStatus.completed,
        originAddress: 'Condesa, CDMX',
        destinationAddress: 'Aeropuerto CDMX',
        originCoordinates:
            const Coordinates(latitude: 19.4105, longitude: -99.1708),
        destinationCoordinates:
            const Coordinates(latitude: 19.4363, longitude: -99.0721),
        actualPrice: 320.00,
        actualDistance: 15.5,
        actualDuration: 45,
        requestedAt: DateTime.now().subtract(const Duration(hours: 5)),
        completedAt:
            DateTime.now().subtract(const Duration(hours: 4, minutes: 15)),
        ratingByPassenger: 4,
      ),
      Trip(
        id: '3',
        passengerId: 'user3',
        driverId: 'driver1',
        status: TripStatus.completed,
        originAddress: 'Santa Fe, CDMX',
        destinationAddress: 'Centro Histórico, CDMX',
        originCoordinates:
            const Coordinates(latitude: 19.3598, longitude: -99.2576),
        destinationCoordinates:
            const Coordinates(latitude: 19.4326, longitude: -99.1332),
        actualPrice: 275.75,
        actualDistance: 22.1,
        actualDuration: 38,
        requestedAt: DateTime.now().subtract(const Duration(hours: 8)),
        completedAt:
            DateTime.now().subtract(const Duration(hours: 7, minutes: 22)),
        ratingByPassenger: 5,
      ),
    ];
  }

  static DriverStats getDriverStats() {
    return DriverStats(
      totalEarnings: 48750.25,
      monthlyEarnings: 16800.90,
      weeklyEarnings: 3825.85,
      totalTrips: 489,
      monthlyTrips: 112,
      weeklyTrips: 28,
      averageRating: 4.8,
      totalHours: 1245,
      monthlyHours: 185,
      weeklyHours: 42,
    );
  }

  // AGREGAR ESTE MÉTODO QUE FALTABA
  static List<NotificationItem> getNotifications() {
    return [
      NotificationItem(
        id: '1',
        title: 'Viaje completado',
        message:
            'Tu viaje a Roma Norte ha sido completado. Califica tu experiencia.',
        type: NotificationType.trip,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        title: 'Pago procesado',
        message: 'Se ha procesado tu pago de \$185.50 MXN exitosamente.',
        type: NotificationType.payment,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationItem(
        id: '3',
        title: 'Nuevo conductor disponible',
        message:
            'Un conductor está cerca de tu ubicación para el viaje solicitado.',
        type: NotificationType.trip,
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isRead: true,
      ),
      NotificationItem(
        id: '4',
        title: 'Actualización de seguridad',
        message: 'Hemos actualizado nuestras políticas de seguridad.',
        type: NotificationType.security,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        title: 'Bienvenido a Blincar',
        message:
            'Gracias por registrarte. Completa tu perfil para una mejor experiencia.',
        type: NotificationType.system,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
      ),
    ];
  }

  static List<DocumentItem> getPersonalDocuments() {
    return [
      DocumentItem(
        id: '1',
        name: 'INE/IFE',
        description: 'Identificación oficial vigente',
        type: 'personal',
        status: DocumentStatus.approved,
        uploadDate: DateTime.now().subtract(const Duration(days: 15)),
      ),
      DocumentItem(
        id: '2',
        name: 'CURP',
        description: 'Clave Única de Registro de Población',
        type: 'personal',
        status: DocumentStatus.approved,
        uploadDate: DateTime.now().subtract(const Duration(days: 15)),
      ),
      DocumentItem(
        id: '3',
        name: 'Comprobante de Domicilio',
        description: 'No mayor a 3 meses',
        type: 'personal',
        status: DocumentStatus.pending,
        uploadDate: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  static List<DocumentItem> getLicenseDocuments() {
    return [
      DocumentItem(
        id: '4',
        name: 'Licencia de Chofer',
        description: 'Licencia tipo A vigente',
        type: 'license',
        status: DocumentStatus.approved,
        uploadDate: DateTime.now().subtract(const Duration(days: 20)),
        expiryDate: DateTime.now().add(const Duration(days: 365)),
      ),
      DocumentItem(
        id: '5',
        name: 'Certificado Médico',
        description: 'Apto para conducir',
        type: 'license',
        status: DocumentStatus.expired,
        uploadDate: DateTime.now().subtract(const Duration(days: 100)),
        expiryDate: DateTime.now().subtract(const Duration(days: 10)),
        comments: 'Documento vencido. Favor de renovar.',
      ),
    ];
  }

  static List<DocumentItem> getVehicleDocuments() {
    return [
      DocumentItem(
        id: '6',
        name: 'Tarjeta de Circulación',
        description: 'Vigente y a nombre del conductor',
        type: 'vehicle',
        status: DocumentStatus.approved,
        uploadDate: DateTime.now().subtract(const Duration(days: 30)),
        expiryDate: DateTime.now().add(const Duration(days: 180)),
      ),
      DocumentItem(
        id: '7',
        name: 'Verificación Vehicular',
        description: 'Verificación ambiental vigente',
        type: 'vehicle',
        status: DocumentStatus.pending,
        uploadDate: DateTime.now().subtract(const Duration(days: 5)),
        expiryDate: DateTime.now().add(const Duration(days: 90)),
      ),
    ];
  }

  static List<DocumentItem> getInsuranceDocuments() {
    return [
      DocumentItem(
        id: '8',
        name: 'Seguro de Responsabilidad Civil',
        description: 'Cobertura mínima \$2,000,000 MXN',
        type: 'insurance',
        status: DocumentStatus.approved,
        uploadDate: DateTime.now().subtract(const Duration(days: 10)),
        expiryDate: DateTime.now().add(const Duration(days: 300)),
      ),
      DocumentItem(
        id: '9',
        name: 'Seguro de Vida',
        description: 'Cobertura para conductor',
        type: 'insurance',
        status: DocumentStatus.rejected,
        uploadDate: DateTime.now().subtract(const Duration(days: 7)),
        comments:
            'La cobertura es insuficiente. Mínimo requerido: \$500,000 MXN',
      ),
    ];
  }
}

// Clases de datos existentes
class DailyEarning {
  final DateTime date;
  final double amount;

  DailyEarning({required this.date, required this.amount});
}

class MonthlyStats {
  final String month;
  final double earnings;
  final int trips;

  MonthlyStats(
      {required this.month, required this.earnings, required this.trips});
}

class DriverStats {
  final double totalEarnings;
  final double monthlyEarnings;
  final double weeklyEarnings;
  final int totalTrips;
  final int monthlyTrips;
  final int weeklyTrips;
  final double averageRating;
  final int totalHours;
  final int monthlyHours;
  final int weeklyHours;

  DriverStats({
    required this.totalEarnings,
    required this.monthlyEarnings,
    required this.weeklyEarnings,
    required this.totalTrips,
    required this.monthlyTrips,
    required this.weeklyTrips,
    required this.averageRating,
    required this.totalHours,
    required this.monthlyHours,
    required this.weeklyHours,
  });
}

// AGREGAR ESTAS CLASES PARA NOTIFICACIONES
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
  });
}

enum NotificationType {
  trip,
  payment,
  security,
  system,
}
