// test/domain/entities/driver_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:blincar_app/domain/entities/driver.dart';
import 'package:blincar_app/domain/value_objects/coordinates.dart';

void main() {
  group('Driver Entity', () {
    late Driver driver;

    setUp(() {
      driver = Driver(
        id: 'driver-123',
        firebaseUid: 'uid-abc-123',
        email: 'conductor@blincar.com',
        phoneNumber: '+52 55 1234 5678',
        fullName: 'Juan Perez Garcia',
        licenseNumber: 'LIC-2024-001',
        // Valid license expiry date (1 year from now)
        licenseExpiryDate: DateTime.now().add(const Duration(days: 365)),
        isAvailable: true,
        isActive: true,
        currentTripId: null,
        currentLocation: null,
        profilePhotoUrl: null,
        rating: 4.8,
        totalTrips: 150,
        lastUpdate: null,
      );
    });

    test('should create Driver with required fields', () {
      expect(driver.id, 'driver-123');
      expect(driver.firebaseUid, 'uid-abc-123');
      expect(driver.email, 'conductor@blincar.com');
      expect(driver.phoneNumber, '+52 55 1234 5678');
      expect(driver.fullName, 'Juan Perez Garcia');
    });

    test('should have default values for optional fields', () {
      const minimalDriver = Driver(
        id: 'min-123',
        firebaseUid: 'uid-min',
        email: 'min@test.com',
        phoneNumber: '+52 55 0000 0000',
        fullName: 'Minimal Driver',
      );

      expect(minimalDriver.isAvailable, true);
      expect(minimalDriver.isActive, true);
      expect(minimalDriver.totalTrips, 0);
      expect(minimalDriver.licenseNumber, isNull);
      expect(minimalDriver.rating, isNull);
    });

    test('copyWith should create new instance with updated fields', () {
      final updatedDriver = driver.copyWith(
        isAvailable: false,
        totalTrips: 151,
      );

      expect(updatedDriver.isAvailable, false);
      expect(updatedDriver.totalTrips, 151);
      // Unchanged fields should remain the same
      expect(updatedDriver.id, driver.id);
      expect(updatedDriver.fullName, driver.fullName);
    });

    test('canAcceptTrip should return true when available, active, and has valid license', () {
      expect(driver.canAcceptTrip, true);

      final unavailableDriver = driver.copyWith(isAvailable: false);
      expect(unavailableDriver.canAcceptTrip, false);

      final inactiveDriver = driver.copyWith(isActive: false);
      expect(inactiveDriver.canAcceptTrip, false);

      // Driver with current trip should not accept new trips
      final busyDriver = driver.copyWith(currentTripId: 'trip-123');
      expect(busyDriver.canAcceptTrip, false);

      // Driver with invalid license should not accept trips
      final expiredLicenseDriver = driver.copyWith(
        licenseExpiryDate: DateTime.now().subtract(const Duration(days: 30)),
      );
      expect(expiredLicenseDriver.canAcceptTrip, false);
    });

    test('hasValidLicense should check license expiry', () {
      // Driver without license
      const driverNoLicense = Driver(
        id: 'no-lic',
        firebaseUid: 'uid-no-lic',
        email: 'no@lic.com',
        phoneNumber: '+52 55 0000 0001',
        fullName: 'No License',
      );
      expect(driverNoLicense.hasValidLicense, false);

      // Driver with expired license
      final driverExpired = driver.copyWith(
        licenseExpiryDate: DateTime.now().subtract(const Duration(days: 30)),
      );
      expect(driverExpired.hasValidLicense, false);

      // Driver with valid license
      final driverValid = driver.copyWith(
        licenseExpiryDate: DateTime.now().add(const Duration(days: 365)),
      );
      expect(driverValid.hasValidLicense, true);
    });

    test('formattedRating should return formatted string', () {
      expect(driver.formattedRating, '4.8');

      final noRating = driver.copyWith(rating: null);
      expect(noRating.formattedRating, 'N/A');
    });

    test('equality should work correctly with Freezed', () {
      // Create two drivers with the same fixed date for equality comparison
      final fixedDate = DateTime(2026, 12, 31);
      final driver1 = Driver(
        id: 'driver-123',
        firebaseUid: 'uid-abc-123',
        email: 'conductor@blincar.com',
        phoneNumber: '+52 55 1234 5678',
        fullName: 'Juan Perez Garcia',
        licenseNumber: 'LIC-2024-001',
        licenseExpiryDate: fixedDate,
        rating: 4.8,
        totalTrips: 150,
      );
      final driver2 = Driver(
        id: 'driver-123',
        firebaseUid: 'uid-abc-123',
        email: 'conductor@blincar.com',
        phoneNumber: '+52 55 1234 5678',
        fullName: 'Juan Perez Garcia',
        licenseNumber: 'LIC-2024-001',
        licenseExpiryDate: fixedDate,
        rating: 4.8,
        totalTrips: 150,
      );

      expect(driver1, equals(driver2));
      expect(driver1.hashCode, equals(driver2.hashCode));
    });

    test('should support location coordinates', () {
      const location = Coordinates(latitude: 19.4326, longitude: -99.1332);
      final driverWithLocation = driver.copyWith(currentLocation: location);

      expect(driverWithLocation.currentLocation, isNotNull);
      expect(driverWithLocation.currentLocation!.latitude, 19.4326);
      expect(driverWithLocation.currentLocation!.longitude, -99.1332);
    });
  });
}
