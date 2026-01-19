// test/domain/value_objects/coordinates_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:blincar_app/domain/value_objects/coordinates.dart';

void main() {
  group('Coordinates Value Object', () {
    test('should create Coordinates with valid values', () {
      const coords = Coordinates(latitude: 19.4326, longitude: -99.1332);

      expect(coords.latitude, 19.4326);
      expect(coords.longitude, -99.1332);
    });

    test('isValid should return true for valid coordinates', () {
      const validCoords = Coordinates(latitude: 19.4326, longitude: -99.1332);
      expect(validCoords.isValid, true);

      // Edge cases
      const northPole = Coordinates(latitude: 90, longitude: 0);
      expect(northPole.isValid, true);

      const southPole = Coordinates(latitude: -90, longitude: 0);
      expect(southPole.isValid, true);

      const dateLine = Coordinates(latitude: 0, longitude: 180);
      expect(dateLine.isValid, true);

      const dateLineNeg = Coordinates(latitude: 0, longitude: -180);
      expect(dateLineNeg.isValid, true);
    });

    test('isValid should return false for invalid coordinates', () {
      const invalidLat = Coordinates(latitude: 91, longitude: 0);
      expect(invalidLat.isValid, false);

      const invalidLatNeg = Coordinates(latitude: -91, longitude: 0);
      expect(invalidLatNeg.isValid, false);

      const invalidLon = Coordinates(latitude: 0, longitude: 181);
      expect(invalidLon.isValid, false);

      const invalidLonNeg = Coordinates(latitude: 0, longitude: -181);
      expect(invalidLonNeg.isValid, false);
    });

    test('equality should work correctly with Freezed', () {
      const coords1 = Coordinates(latitude: 19.4326, longitude: -99.1332);
      const coords2 = Coordinates(latitude: 19.4326, longitude: -99.1332);

      expect(coords1, equals(coords2));
      expect(coords1.hashCode, equals(coords2.hashCode));
    });

    test('copyWith should create new instance with updated values', () {
      const original = Coordinates(latitude: 19.4326, longitude: -99.1332);
      final updated = original.copyWith(latitude: 20.0);

      expect(updated.latitude, 20.0);
      expect(updated.longitude, -99.1332);
    });

    test('toJson and fromJson should work correctly', () {
      const original = Coordinates(latitude: 19.4326, longitude: -99.1332);
      final json = original.toJson();

      expect(json['latitude'], 19.4326);
      expect(json['longitude'], -99.1332);

      final restored = Coordinates.fromJson(json);
      expect(restored, equals(original));
    });

    test('different coordinates should not be equal', () {
      const coords1 = Coordinates(latitude: 19.4326, longitude: -99.1332);
      const coords2 = Coordinates(latitude: 19.4327, longitude: -99.1332);

      expect(coords1, isNot(equals(coords2)));
    });
  });
}
