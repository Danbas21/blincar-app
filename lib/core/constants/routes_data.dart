// lib/core/constants/routes_data.dart

import '../../domain/entities/trip/route_entity.dart';

/// Rutas hardcodeadas de Blincar
///
/// Basadas en: Draft_Tabulador_BLINCAR_oct_2025.xlsx
class RoutesData {
  /// Terminal 1 del AICM
  static const aicmT1 = LocationPoint(
    name: 'AICM Terminal 1',
    address: 'Av. Capitán Carlos León S/N, Peñón de los Baños, 15620 CDMX',
    latitude: 19.4363,
    longitude: -99.0721,
  );

  /// Terminal 2 del AICM
  static const aicmT2 = LocationPoint(
    name: 'AICM Terminal 2',
    address: 'Av. Capitán Carlos León S/N, Peñón de los Baños, 15620 CDMX',
    latitude: 19.4242,
    longitude: -99.0885,
  );

  /// Zócalo CDMX
  static const zocalo = LocationPoint(
    name: 'Zócalo CDMX',
    address: 'Plaza de la Constitución S/N, Centro Histórico, 06010 CDMX',
    latitude: 19.4326,
    longitude: -99.1332,
  );

  /// Polanco
  static const polanco = LocationPoint(
    name: 'Polanco',
    address: 'Av. Presidente Masaryk 111, Polanco, 11560 CDMX',
    latitude: 19.4326,
    longitude: -99.1910,
  );

  /// Santa Fe
  static const santaFe = LocationPoint(
    name: 'Santa Fe',
    address: 'Vasco de Quiroga 3800, Santa Fe, 05348 CDMX',
    latitude: 19.3599,
    longitude: -99.2599,
  );

  /// Reforma
  static const reforma = LocationPoint(
    name: 'Paseo de la Reforma',
    address: 'Paseo de la Reforma 222, Juárez, 06600 CDMX',
    latitude: 19.4270,
    longitude: -99.1677,
  );

  /// Condesa-Roma
  static const condesaRoma = LocationPoint(
    name: 'Condesa-Roma',
    address: 'Av. Álvaro Obregón 99, Roma Norte, 06700 CDMX',
    latitude: 19.4100,
    longitude: -99.1670,
  );

  /// WTC
  static const wtc = LocationPoint(
    name: 'World Trade Center',
    address: 'Montecito 38, Nápoles, 03810 CDMX',
    latitude: 19.3877,
    longitude: -99.1755,
  );

  /// Auditorio Nacional
  static const auditorio = LocationPoint(
    name: 'Auditorio Nacional',
    address: 'Paseo de la Reforma 50, Polanco, 11560 CDMX',
    latitude: 19.4256,
    longitude: -99.1919,
  );

  /// Foro Sol
  static const foroSol = LocationPoint(
    name: 'Foro Sol',
    address: 'Viad. Río de la Piedad S/N, Granjas México, 08400 CDMX',
    latitude: 19.4071,
    longitude: -99.0907,
  );

  /// Museo de Antropología
  static const museoAntropologia = LocationPoint(
    name: 'Museo Nacional de Antropología',
    address: 'Av. Paseo de la Reforma, Polanco, 11560 CDMX',
    latitude: 19.4260,
    longitude: -99.1863,
  );

  /// Aeropuerto de Toluca
  static const aeropuertoToluca = LocationPoint(
    name: 'Aeropuerto Internacional de Toluca',
    address: 'Carretera Toluca-Palmillas Km 60, 50226 Toluca, Edo. Mex.',
    latitude: 19.3371,
    longitude: -99.5660,
  );

  /// Lista de rutas principales desde AICM
  static final List<RouteEntity> allRoutes = [
    // 1. AICM → Zócalo
    const RouteEntity(
      id: 'route_aicm_zocalo',
      name: 'AICM → Zócalo',
      origin: aicmT1,
      destination: zocalo,
      distanceKm: 8.0,
      estimatedDurationMinutes: 25,
      basePrice: 4290.0,
      category: RouteCategory.cityCenter,
    ),

    // 2. AICM → Polanco
    const RouteEntity(
      id: 'route_aicm_polanco',
      name: 'AICM → Polanco',
      origin: aicmT1,
      destination: polanco,
      distanceKm: 19.0,
      estimatedDurationMinutes: 48,
      basePrice: 3900.0,
      category: RouteCategory.businessDistrict,
    ),

    // 3. AICM → Santa Fe
    const RouteEntity(
      id: 'route_aicm_santafe',
      name: 'AICM → Santa Fe',
      origin: aicmT1,
      destination: santaFe,
      distanceKm: 18.0,
      estimatedDurationMinutes: 62,
      basePrice: 4680.0,
      category: RouteCategory.businessDistrict,
    ),

    // 4. AICM → Reforma
    const RouteEntity(
      id: 'route_aicm_reforma',
      name: 'AICM → Reforma',
      origin: aicmT1,
      destination: reforma,
      distanceKm: 12.0,
      estimatedDurationMinutes: 38,
      basePrice: 3510.0,
      category: RouteCategory.businessDistrict,
    ),

    // 5. AICM → Condesa-Roma
    const RouteEntity(
      id: 'route_aicm_condesa',
      name: 'AICM → Condesa-Roma',
      origin: aicmT1,
      destination: condesaRoma,
      distanceKm: 15.0,
      estimatedDurationMinutes: 45,
      basePrice: 4290.0,
      category: RouteCategory.residential,
    ),

    // 6. AICM → WTC
    const RouteEntity(
      id: 'route_aicm_wtc',
      name: 'AICM → WTC',
      origin: aicmT1,
      destination: wtc,
      distanceKm: 13.0,
      estimatedDurationMinutes: 40,
      basePrice: 3900.0,
      category: RouteCategory.businessDistrict,
    ),

    // 7. AICM → Auditorio Nacional
    const RouteEntity(
      id: 'route_aicm_auditorio',
      name: 'AICM → Auditorio Nacional',
      origin: aicmT1,
      destination: auditorio,
      distanceKm: 17.0,
      estimatedDurationMinutes: 50,
      basePrice: 3900.0,
      category: RouteCategory.cultural,
    ),

    // 8. AICM → Foro Sol
    const RouteEntity(
      id: 'route_aicm_forosol',
      name: 'AICM → Foro Sol',
      origin: aicmT1,
      destination: foroSol,
      distanceKm: 6.0,
      estimatedDurationMinutes: 20,
      basePrice: 5070.0,
      category: RouteCategory.cultural,
    ),

    // 9. AICM → Museo Antropología
    const RouteEntity(
      id: 'route_aicm_museo',
      name: 'AICM → Museo Antropología',
      origin: aicmT1,
      destination: museoAntropologia,
      distanceKm: 17.0,
      estimatedDurationMinutes: 48,
      basePrice: 3900.0,
      category: RouteCategory.cultural,
    ),

    // 10. Aeropuerto Toluca → Santa Fe (con caseta)
    const RouteEntity(
      id: 'route_toluca_santafe',
      name: 'Toluca → Santa Fe',
      origin: aeropuertoToluca,
      destination: santaFe,
      distanceKm: 19.0,
      estimatedDurationMinutes: 40,
      basePrice: 6189.0,
      tollCost: 111.0,
      category: RouteCategory.highway,
    ),
  ];

  /// Obtener ruta por ID
  static RouteEntity? getRouteById(String id) {
    try {
      return allRoutes.firstWhere((route) => route.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Buscar rutas por origen
  static List<RouteEntity> getRoutesByOrigin(String originName) {
    return allRoutes
        .where((route) =>
            route.origin.name.toLowerCase().contains(originName.toLowerCase()))
        .toList();
  }

  /// Buscar rutas por destino
  static List<RouteEntity> getRoutesByDestination(String destinationName) {
    return allRoutes
        .where((route) => route.destination.name
            .toLowerCase()
            .contains(destinationName.toLowerCase()))
        .toList();
  }

  /// Obtener rutas del AICM (las mas comunes)
  static List<RouteEntity> get airportRoutes {
    return allRoutes
        .where((route) => route.origin.name.startsWith('AICM'))
        .toList();
  }

  /// Obtener rutas por categoría
  static List<RouteEntity> getRoutesByCategory(RouteCategory category) {
    return allRoutes.where((route) => route.category == category).toList();
  }
}
