import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import '../errors/exceptions.dart';

class LocationService {
  static const LocationSettings _locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  Future<Position> getCurrentLocation() async {
    final hasPermission = await _requestLocationPermission();
    if (!hasPermission) {
      throw const LocationException('Permisos de ubicación denegados');
    }

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      throw LocationException('Error obteniendo ubicación: ${e.toString()}');
    }
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.administrativeArea}';
      }
      return 'Dirección no encontrada';
    } catch (e) {
      throw LocationException('Error obteniendo dirección: ${e.toString()}');
    }
  }

  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: _locationSettings,
    );
  }

  Future<double> calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
}
