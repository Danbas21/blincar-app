// lib/presentation/pages/home/home_page.dart

import 'package:blincar_app/presentation/pages/activity/activity_page.dart';
import 'package:blincar_app/presentation/pages/location/location_picker_page.dart';
import 'package:blincar_app/presentation/pages/notifications/notifications_page.dart';
import 'package:blincar_app/presentation/pages/panic/panic_page.dart';
import 'package:blincar_app/presentation/pages/trip/payment_confirmation_page.dart';
import 'package:blincar_app/presentation/pages/trip/trip_request_page.dart';
import 'package:blincar_app/presentation/pages/trip/trip_tracking_page.dart';
import 'package:blincar_app/presentation/pages/trip/waiting_assignment_page.dart';

import 'package:blincar_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/google_directions_service.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';

import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late User currentUser;

  // Ubicaciones seleccionadas (estilo Uber)
  SelectedLocation? _originLocation;
  SelectedLocation? _destinationLocation;

  // Tipo de servicio seleccionado
  String _selectedServiceType = 'Punto a Punto';

  // Tipos de servicio con multiplicadores de precio (mismo que trip_request_page.dart)
  final Map<String, double> _serviceMultipliers = {
    'Punto a Punto': 1.0,
    'Con Escolta Armado': 1.5,
    'Con Escolta Desarmado': 1.3,
    'Auto Blindado': 2.0,
    'Auto Blindado + Escolta': 2.5,
  };

  // Duracion y precio calculados por Google Maps
  // Precio: 50 MXN por cada 10 minutos de viaje
  int? _estimatedDurationMinutes;
  double? _estimatedDistanceKm;
  bool _isCalculatingRoute = false;
  String? _durationText;

  // Agendamiento de viaje
  bool _isScheduled = false;
  DateTime? _scheduledDateTime;

  // Precio base por defecto (3 bloques de 10 min = 150 MXN)
  // Se usa cuando no hay duración calculada de Google Maps
  static const double baseTripPrice = 10.0; //aquí cambie el precio

  // Precio calculado según tiempo de viaje (50 MXN / 10 min)
  double get _calculatedPrice {
    if (_estimatedDurationMinutes != null && _estimatedDurationMinutes! > 0) {
      // 50 MXN por cada 10 minutos
      final basePriceBlocks = (_estimatedDurationMinutes! / 10).ceil();
      final basePrice = basePriceBlocks * 10.0; //aquí cambi el precio
      return basePrice * (_serviceMultipliers[_selectedServiceType] ?? 1.0);
    }
    // Precio por defecto si no hay duración calculada
    return baseTripPrice * (_serviceMultipliers[_selectedServiceType] ?? 1.0);
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      currentUser = authState.user;
    }

    // Verificar si hay un viaje activo al abrir la app
    _checkActiveTrip();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkActiveTrip() async {
    final storageService = getIt<StorageService>();
    final activeTripId = storageService.getActiveTripId();

    if (activeTripId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TripTrackingPage(tripId: activeTripId),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          currentUser = state.user;
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeTab(),
            const TripRequestPageV2(),
            _buildActivityTab(),
            const ProfilePage(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildHomeTab() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildMainServiceCards(),
            const SizedBox(height: 32),
            _buildQuickTripSection(),
            const SizedBox(height: 32),
            _buildPanicButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.person,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.helloName(currentUser.fullName),
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                l10n.passengerRole,
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NotificationsPage(),
              ),
            );
          },
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: AppTheme.textPrimaryColor,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.errorColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 3 Cards principales: Por Ruta, Por Día, Personaliza tu viaje
  Widget _buildMainServiceCards() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.transportServices,
          style: const TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Card 1: Por Ruta
            Expanded(
              child: _buildServiceCard(
                title: l10n.byRouteTitle,
                subtitle: l10n.byRouteSubtitle,
                icon: Icons.route,
                gradient: const [Color(0xFF0D47A1), Color(0xFF1E88E5)],
                onTap: () {
                  setState(() => _currentIndex = 1);
                },
              ),
            ),
            const SizedBox(width: 12),
            // Card 2: Por Día
            Expanded(
              child: _buildServiceCard(
                title: l10n.byDayTitle,
                subtitle: l10n.byDaySubtitle,
                icon: Icons.calendar_today,
                gradient: const [Color(0xFF0D47A1), Color(0xFF2196F3)],
                onTap: () => _showDayServiceDialog(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Card 3: Personaliza tu viaje (ancha)
        _buildWideServiceCard(
          title: l10n.customTripTitle,
          subtitle: l10n.customTripSubtitle,
          icon: Icons.edit_location_alt,
          gradient: const [Color(0xFF1A237E), Color(0xFF1976D2)],
          onTap: () => _showCustomTripBottomSheet(),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withAlpha(204),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideServiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sección de viaje rápido con inputs de ubicación y tipo de servicio
  Widget _buildQuickTripSection() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLightColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.flash_on,
                  color: AppTheme.primaryLightColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.quickTrip,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_durationText != null)
                      Text(
                        '$_durationText${_estimatedDistanceKm != null ? ' • ${_estimatedDistanceKm!.toStringAsFixed(1)} km' : ''}',
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              if (_isCalculatingRoute)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${_calculatedPrice.toStringAsFixed(0)} MXN',
                    style: const TextStyle(
                      color: AppTheme.successColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Selector de Origen (estilo Uber)
          _buildLocationSelector(
            label: l10n.originLabel,
            location: _originLocation,
            icon: Icons.trip_origin,
            iconColor: AppTheme.successColor,
            placeholder: l10n.whereFrom,
            onTap: () => _openLocationPicker(isOrigin: true),
          ),
          const SizedBox(height: 12),

          // Selector de Destino (estilo Uber)
          _buildLocationSelector(
            label: l10n.destinationLabel,
            location: _destinationLocation,
            icon: Icons.location_on,
            iconColor: AppTheme.errorColor,
            placeholder: l10n.whereGoing,
            onTap: () => _openLocationPicker(isOrigin: false),
          ),
          const SizedBox(height: 20),

          // Selector de tipo de servicio
          Text(
            l10n.serviceTypeLabel,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildServiceTypeSelector(),
          const SizedBox(height: 20),

          // Agendamiento
          _buildScheduleSection(),
          const SizedBox(height: 20),

          // Botón solicitar
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _canRequestTrip ? _requestQuickTrip : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryLightColor,
                disabledBackgroundColor: AppTheme.dividerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_taxi, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.requestTrip,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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

  /// Verifica si se puede solicitar el viaje
  bool get _canRequestTrip =>
      _originLocation != null && _destinationLocation != null;

  /// Abre el picker de ubicación
  Future<void> _openLocationPicker({required bool isOrigin}) async {
    final result = await Navigator.of(context).push<SelectedLocation>(
      MaterialPageRoute(
        builder: (_) => LocationPickerPage(
          title: isOrigin ? 'Seleccionar origen' : 'Seleccionar destino',
          isOrigin: isOrigin,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (isOrigin) {
          _originLocation = result;
        } else {
          _destinationLocation = result;
        }
      });

      // Calcular ruta si ambas ubicaciones estan seleccionadas
      if (_originLocation != null && _destinationLocation != null) {
        _calculateRoute();
      }
    }
  }

  /// Calcula la duracion y distancia del viaje usando Google Maps
  Future<void> _calculateRoute() async {
    if (_originLocation == null || _destinationLocation == null) return;

    setState(() {
      _isCalculatingRoute = true;
    });

    try {
      final directionsService = getIt<GoogleDirectionsService>();
      final result = await directionsService.getDirections(
        originLat: _originLocation!.latitude,
        originLng: _originLocation!.longitude,
        destinationLat: _destinationLocation!.latitude,
        destinationLng: _destinationLocation!.longitude,
      );

      if (mounted) {
        setState(() {
          _estimatedDurationMinutes = result.durationMinutes;
          _estimatedDistanceKm = result.distanceKm;
          _durationText = result.durationText;
          _isCalculatingRoute = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCalculatingRoute = false;
        });
      }
    }
  }

  /// Widget para mostrar ubicación seleccionada (estilo Uber)
  Widget _buildLocationSelector({
    required String label,
    required SelectedLocation? location,
    required IconData icon,
    required Color iconColor,
    required String placeholder,
    required VoidCallback onTap,
  }) {
    final hasLocation = location != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                hasLocation ? iconColor.withAlpha(100) : AppTheme.dividerColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hasLocation ? location.address : placeholder,
                    style: TextStyle(
                      color: hasLocation
                          ? AppTheme.textPrimaryColor
                          : AppTheme.textSecondaryColor,
                      fontSize: 14,
                      fontWeight:
                          hasLocation ? FontWeight.w500 : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              hasLocation ? Icons.edit : Icons.chevron_right,
              color: AppTheme.textSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Selector de tipo de servicio (radio buttons)
  Widget _buildServiceTypeSelector() {
    return Column(
      children: _serviceMultipliers.entries.map((entry) {
        final isSelected = _selectedServiceType == entry.key;
        final price = baseTripPrice * entry.value;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedServiceType = entry.key;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.textSecondaryColor.withAlpha(26)
                  : AppTheme.cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryLightColor
                    : AppTheme.dividerColor,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? AppTheme.primaryLightColor
                      : AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.primaryLightColor
                          : AppTheme.textPrimaryColor,
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  '\$${price.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: isSelected
                        ? AppTheme.primaryLightColor
                        : AppTheme.textSecondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPanicButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.errorColor, Color(0xFFD32F2F)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.errorColor.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showPanicDialog(),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.panicButtonLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTab() {
    return const ActivityPage();
  }

  Widget _buildBottomNavigationBar() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, l10n.navHome, 0),
              _buildNavItem(Icons.route, l10n.navRoutes, 1),
              _buildNavItem(Icons.history, l10n.navActivity, 2),
              _buildNavItem(Icons.person, l10n.navProfile, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryLightColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppTheme.textSecondaryColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : AppTheme.textSecondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== AGENDAMIENTO ====================

  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle "Programar para más tarde"
        GestureDetector(
          onTap: () {
            setState(() {
              _isScheduled = !_isScheduled;
              if (!_isScheduled) _scheduledDateTime = null;
            });
            if (_isScheduled) _selectScheduledDate();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _isScheduled
                  ? AppTheme.primaryLightColor.withAlpha(26)
                  : AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isScheduled
                    ? AppTheme.primaryLightColor
                    : AppTheme.dividerColor,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: _isScheduled
                      ? AppTheme.primaryLightColor
                      : AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _isScheduled && _scheduledDateTime != null
                        ? _formatScheduledDate(_scheduledDateTime!)
                        : 'Programar para más tarde',
                    style: TextStyle(
                      color: _isScheduled
                          ? AppTheme.textPrimaryColor
                          : AppTheme.textSecondaryColor,
                      fontSize: 14,
                      fontWeight:
                          _isScheduled ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                Switch(
                  value: _isScheduled,
                  onChanged: (val) {
                    setState(() {
                      _isScheduled = val;
                      if (!_isScheduled) _scheduledDateTime = null;
                    });
                    if (val) _selectScheduledDate();
                  },
                  activeThumbColor: AppTheme.primaryLightColor,
                  activeTrackColor: AppTheme.primaryLightColor.withAlpha(128),
                ),
              ],
            ),
          ),
        ),
        if (_isScheduled && _scheduledDateTime != null) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _selectScheduledDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.primaryLightColor.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: AppTheme.primaryLightColor.withAlpha(80)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.edit_calendar,
                      color: AppTheme.primaryLightColor, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    _formatScheduledDate(_scheduledDateTime!),
                    style: const TextStyle(
                      color: AppTheme.primaryLightColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Cambiar',
                    style: TextStyle(
                      color: AppTheme.primaryLightColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _formatScheduledDate(DateTime dt) {
    final now = DateTime.now();
    final isToday =
        dt.day == now.day && dt.month == now.month && dt.year == now.year;
    final tomorrow = now.add(const Duration(days: 1));
    final isTomorrow = dt.day == tomorrow.day &&
        dt.month == tomorrow.month &&
        dt.year == tomorrow.year;

    final timeStr =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

    if (isToday) return 'Hoy a las $timeStr';
    if (isTomorrow) return 'Mañana a las $timeStr';

    const months = [
      '',
      'ene',
      'feb',
      'mar',
      'abr',
      'may',
      'jun',
      'jul',
      'ago',
      'sep',
      'oct',
      'nov',
      'dic'
    ];
    return '${dt.day} ${months[dt.month]} a las $timeStr';
  }

  Future<void> _selectScheduledDate() async {
    final now = DateTime.now();
    final minDate = now.add(const Duration(minutes: 30));

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _scheduledDateTime ?? minDate,
      firstDate: minDate,
      lastDate: now.add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 166, 166, 212),
              surface: AppTheme.surfaceColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledDateTime ?? minDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 156, 156, 181),
              surface: Color.fromARGB(255, 23, 71, 230),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null || !mounted) return;

    final selected = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Mínimo 30 minutos desde ahora
    if (selected.isBefore(minDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'El viaje debe agendarse con al menos 30 minutos de anticipación'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _scheduledDateTime = selected);
  }

  // ==================== DIALOGS Y ACCIONES ====================

  void _showPanicDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Text(
          AppLocalizations.of(context)!.panicDialogTitle,
          style: const TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Text(
          AppLocalizations.of(context)!.panicDialogMessage,
          style: const TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(color: AppTheme.textPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PanicPage(),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.activate,
              style: const TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showDayServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.calendar_today, color: AppTheme.primaryLightColor),
            SizedBox(width: 12),
            Text(
              'Servicio Por Día',
              style: TextStyle(color: AppTheme.textPrimaryColor),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Próximamente disponible',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'El servicio por día te permitirá contratar un conductor y vehículo durante un día completo para múltiples traslados.',
              style: TextStyle(color: AppTheme.textSecondaryColor),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.check_circle,
                    color: Color.fromARGB(255, 83, 76, 175), size: 18),
                SizedBox(width: 8),
                Text('8 horas de servicio',
                    style: TextStyle(color: AppTheme.textSecondaryColor)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.check_circle,
                    color: AppTheme.successColor, size: 18),
                SizedBox(width: 8),
                Text('Múltiples destinos',
                    style: TextStyle(color: AppTheme.textSecondaryColor)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.check_circle,
                    color: AppTheme.successColor, size: 18),
                SizedBox(width: 8),
                Text('Conductor dedicado',
                    style: TextStyle(color: AppTheme.textSecondaryColor)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _showCustomTripBottomSheet() {
    // Usamos las mismas ubicaciones que en la página principal
    // El bottom sheet ahora es más simple y redirige al picker
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _CustomTripPage(
          serviceMultipliers: _serviceMultipliers,
          baseTripPrice: baseTripPrice,
          onTripCreated: (origin, destination, serviceType, price,
              estimatedDuration, estimatedDistance, durationText) {
            // Navegar a la pantalla de pago antes de crear el viaje
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentConfirmationPage(
                  tripData: TripPaymentData(
                    originAddress: origin.address,
                    destinationAddress: destination.address,
                    originLat: origin.latitude,
                    originLng: origin.longitude,
                    destinationLat: destination.latitude,
                    destinationLng: destination.longitude,
                    serviceType: serviceType,
                    totalPrice: price,
                    estimatedDurationMinutes: estimatedDuration,
                    estimatedDistanceKm: estimatedDistance,
                    durationText: durationText,
                  ),
                  onPaymentConfirmed: () {
                    _createCustomTripWithLocations(
                      origin,
                      destination,
                      serviceType,
                      price,
                      estimatedDurationMinutes: estimatedDuration,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Solicitar viaje rápido desde la sección principal
  /// Flujo: Solicitar -> Pagar -> Confirmar (estilo Uber)
  void _requestQuickTrip() {
    if (_originLocation == null || _destinationLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectOriginDestination),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    // Navegar a la pantalla de confirmacion de pago
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentConfirmationPage(
          tripData: TripPaymentData(
            originAddress: _originLocation!.address,
            destinationAddress: _destinationLocation!.address,
            originLat: _originLocation!.latitude,
            originLng: _originLocation!.longitude,
            destinationLat: _destinationLocation!.latitude,
            destinationLng: _destinationLocation!.longitude,
            serviceType: _selectedServiceType,
            totalPrice: _calculatedPrice,
            estimatedDurationMinutes: _estimatedDurationMinutes,
            estimatedDistanceKm: _estimatedDistanceKm,
            durationText: _durationText,
          ),
          onPaymentConfirmed: () {
            // Despues de confirmar pago, crear el viaje
            _createCustomTripWithLocations(
              _originLocation!,
              _destinationLocation!,
              _selectedServiceType,
              _calculatedPrice,
              estimatedDurationMinutes: _estimatedDurationMinutes,
            );
          },
        ),
      ),
    );
  }

  /// Crear viaje con ubicaciones seleccionadas
  ///
  /// Calcula el precio basado en el tiempo estimado de Google Maps:
  /// 50 MXN por cada 10 minutos de viaje
  Future<void> _createCustomTripWithLocations(
    SelectedLocation origin,
    SelectedLocation destination,
    String serviceType,
    double price, {
    int? estimatedDurationMinutes,
  }) async {
    // Verificar usuario autenticado
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.loginRequired)),
      );
      return;
    }

    final user = authState.user;

    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryLightColor),
      ),
    );

    // Crear viaje en Firebase
    final tripRepository = getIt<TripRepository>();
    final routeId = 'custom_${DateTime.now().millisecondsSinceEpoch}';

    // Calcular precio basado en tiempo si se proporciona duracion
    // 50 MXN por cada 10 minutos
    double finalPrice = price;
    if (estimatedDurationMinutes != null && estimatedDurationMinutes > 0) {
      finalPrice = (estimatedDurationMinutes / 10).ceil() * 50.0;
      // Aplicar multiplicador del servicio
      final multiplier = _serviceMultipliers[serviceType] ?? 1.0;
      finalPrice = finalPrice * multiplier;
    }

    final result = await tripRepository.createTripRequest(
      userId: user.id,
      userName: user.fullName,
      userPhone: user.phoneNumber,
      routeId: routeId,
      serviceType: '$serviceType | ${origin.address} → ${destination.address}',
      totalPrice: finalPrice,
      // Datos de ubicacion para viaje personalizado
      originAddress: origin.address,
      originLat: origin.latitude,
      originLng: origin.longitude,
      destinationAddress: destination.address,
      destinationLat: destination.latitude,
      destinationLng: destination.longitude,
      estimatedDurationMinutes: estimatedDurationMinutes,
    );

    // Cerrar loading
    if (mounted) {
      Navigator.of(context).pop();
    }

    // Manejar resultado
    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${failure.message}'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      },
      (trip) async {
        // Guardar tripId activo
        final storageService = getIt<StorageService>();
        await storageService.saveActiveTripId(trip.id);

        // Limpiar ubicaciones y datos calculados
        setState(() {
          _originLocation = null;
          _destinationLocation = null;
          _selectedServiceType = 'Punto a Punto';
          _estimatedDurationMinutes = null;
          _estimatedDistanceKm = null;
          _durationText = null;
        });

        if (mounted) {
          // Navegar a pantalla de espera
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WaitingAssignmentPage(tripId: trip.id),
            ),
          );
        }
      },
    );
  }
}

/// Página para personalizar viaje con selector de ubicaciones estilo Uber
class _CustomTripPage extends StatefulWidget {
  final Map<String, double> serviceMultipliers;
  final double baseTripPrice;
  final void Function(
    SelectedLocation origin,
    SelectedLocation destination,
    String serviceType,
    double price,
    int? estimatedDuration,
    double? estimatedDistance,
    String? durationText,
  ) onTripCreated;

  const _CustomTripPage({
    required this.serviceMultipliers,
    required this.baseTripPrice,
    required this.onTripCreated,
  });

  @override
  State<_CustomTripPage> createState() => _CustomTripPageState();
}

class _CustomTripPageState extends State<_CustomTripPage> {
  SelectedLocation? _origin;
  SelectedLocation? _destination;
  String _selectedService = 'Punto a Punto';

  // Datos de ruta calculados
  int? _estimatedDurationMinutes;
  double? _estimatedDistanceKm;
  String? _durationText;
  bool _isCalculatingRoute = false;

  // Precio calculado basado en duracion (50 MXN / 10 min)
  double get _price {
    if (_estimatedDurationMinutes != null && _estimatedDurationMinutes! > 0) {
      final basePriceBlocks = (_estimatedDurationMinutes! / 10).ceil();
      final basePrice = basePriceBlocks * 50.0;
      return basePrice * (widget.serviceMultipliers[_selectedService] ?? 1.0);
    }
    return widget.baseTripPrice *
        (widget.serviceMultipliers[_selectedService] ?? 1.0);
  }

  bool get _canRequest =>
      _origin != null && _destination != null && !_isCalculatingRoute;

  Future<void> _selectLocation({required bool isOrigin}) async {
    final result = await Navigator.of(context).push<SelectedLocation>(
      MaterialPageRoute(
        builder: (_) => LocationPickerPage(
          title: isOrigin ? 'Seleccionar origen' : 'Seleccionar destino',
          isOrigin: isOrigin,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (isOrigin) {
          _origin = result;
        } else {
          _destination = result;
        }
      });

      // Calcular ruta si ambas ubicaciones estan seleccionadas
      if (_origin != null && _destination != null) {
        _calculateRoute();
      }
    }
  }

  Future<void> _calculateRoute() async {
    if (_origin == null || _destination == null) return;

    setState(() {
      _isCalculatingRoute = true;
    });

    try {
      final directionsService = getIt<GoogleDirectionsService>();
      final result = await directionsService.getDirections(
        originLat: _origin!.latitude,
        originLng: _origin!.longitude,
        destinationLat: _destination!.latitude,
        destinationLng: _destination!.longitude,
      );

      if (mounted) {
        setState(() {
          _estimatedDurationMinutes = result.durationMinutes;
          _estimatedDistanceKm = result.distanceKm;
          _durationText = result.durationText;
          _isCalculatingRoute = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCalculatingRoute = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Personaliza tu Viaje',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector de Origen
            _buildLocationTile(
              label: 'Origen',
              location: _origin,
              icon: Icons.trip_origin,
              iconColor: AppTheme.successColor,
              placeholder: '¿Dónde te recogemos?',
              onTap: () => _selectLocation(isOrigin: true),
            ),
            const SizedBox(height: 16),

            // Selector de Destino
            _buildLocationTile(
              label: 'Destino',
              location: _destination,
              icon: Icons.location_on,
              iconColor: AppTheme.errorColor,
              placeholder: '¿A dónde vas?',
              onTap: () => _selectLocation(isOrigin: false),
            ),

            // Info de ruta calculada
            if (_durationText != null || _isCalculatingRoute) ...[
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLightColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _isCalculatingRoute
                      ? [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Calculando ruta...',
                            style:
                                TextStyle(color: AppTheme.textSecondaryColor),
                          ),
                        ]
                      : [
                          const Icon(Icons.access_time,
                              size: 16, color: AppTheme.primaryLightColor),
                          const SizedBox(width: 4),
                          Text(
                            _durationText!,
                            style: const TextStyle(
                                color: AppTheme.textPrimaryColor),
                          ),
                          if (_estimatedDistanceKm != null) ...[
                            const SizedBox(width: 12),
                            const Icon(Icons.straighten,
                                size: 16, color: AppTheme.primaryLightColor),
                            const SizedBox(width: 4),
                            Text(
                              '${_estimatedDistanceKm!.toStringAsFixed(1)} km',
                              style: const TextStyle(
                                  color: AppTheme.textPrimaryColor),
                            ),
                          ],
                        ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Tipo de servicio
            const Text(
              'Tipo de servicio',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ...widget.serviceMultipliers.entries.map((entry) {
              final isSelected = _selectedService == entry.key;
              // Precio basado en duracion si esta disponible
              double servicePrice;
              if (_estimatedDurationMinutes != null &&
                  _estimatedDurationMinutes! > 0) {
                final basePriceBlocks =
                    (_estimatedDurationMinutes! / 10).ceil();
                final basePrice = basePriceBlocks * 50.0;
                servicePrice = basePrice * entry.value;
              } else {
                servicePrice = widget.baseTripPrice * entry.value;
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedService = entry.key),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryLightColor.withAlpha(26)
                        : AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryLightColor
                          : AppTheme.dividerColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? AppTheme.textSecondaryColor
                            : AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            color: isSelected
                                ? AppTheme.textSecondaryColor
                                : AppTheme.textPrimaryColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        '\$${servicePrice.toStringAsFixed(0)} MXN',
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.textSecondaryColor
                              : AppTheme.textSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Precio total
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryLightColor, Color(0xFF0F4C75)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.totalToPay,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    '\$${_price.toStringAsFixed(0)} MXN',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Botón solicitar
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _canRequest
                    ? () {
                        Navigator.pop(context);
                        widget.onTripCreated(
                          _origin!,
                          _destination!,
                          _selectedService,
                          _price,
                          _estimatedDurationMinutes,
                          _estimatedDistanceKm,
                          _durationText,
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryLightColor,
                  disabledBackgroundColor: AppTheme.dividerColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_taxi, color: Colors.white, size: 26),
                    const SizedBox(width: 12),
                    Text(
                      AppLocalizations.of(context)!.continueToPay,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTile({
    required String label,
    required SelectedLocation? location,
    required IconData icon,
    required Color iconColor,
    required String placeholder,
    required VoidCallback onTap,
  }) {
    final hasLocation = location != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color:
                hasLocation ? iconColor.withAlpha(100) : AppTheme.dividerColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasLocation ? location.address : placeholder,
                    style: TextStyle(
                      color: hasLocation
                          ? AppTheme.textPrimaryColor
                          : AppTheme.textSecondaryColor,
                      fontSize: 15,
                      fontWeight:
                          hasLocation ? FontWeight.w500 : FontWeight.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              hasLocation ? Icons.edit : Icons.chevron_right,
              color: AppTheme.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
