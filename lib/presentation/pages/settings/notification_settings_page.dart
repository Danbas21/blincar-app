// lib/presentation/pages/settings/notification_settings_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:blincar_app/l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/service_locator.dart';

/// Página de configuración de notificaciones
///
/// Permite al usuario personalizar sus preferencias de notificaciones:
/// - Activar/desactivar tipos de notificaciones
/// - Configurar sonido y vibración
/// - Establecer horarios de "No molestar"
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  final StorageService _storage = getIt<StorageService>();

  // Estado de permisos
  bool _permissionsGranted = false;
  bool _isLoadingPermissions = true;

  // Preferencias de notificaciones
  bool _tripNotifications = true;
  bool _paymentNotifications = true;
  bool _securityNotifications = true;
  bool _promoNotifications = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  // Horario de No Molestar
  bool _quietHoursEnabled = false;
  TimeOfDay _quietStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietEnd = const TimeOfDay(hour: 7, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _checkPermissions();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _tripNotifications = _storage.getBool('notif_trips') ?? true;
      _paymentNotifications = _storage.getBool('notif_payments') ?? true;
      _securityNotifications = _storage.getBool('notif_security') ?? true;
      _promoNotifications = _storage.getBool('notif_promos') ?? false;
      _soundEnabled = _storage.getBool('notif_sound') ?? true;
      _vibrationEnabled = _storage.getBool('notif_vibration') ?? true;
      _quietHoursEnabled = _storage.getBool('notif_quiet_hours') ?? false;

      final quietStartHour = _storage.getInt('notif_quiet_start_hour') ?? 22;
      final quietStartMin = _storage.getInt('notif_quiet_start_min') ?? 0;
      _quietStart = TimeOfDay(hour: quietStartHour, minute: quietStartMin);

      final quietEndHour = _storage.getInt('notif_quiet_end_hour') ?? 7;
      final quietEndMin = _storage.getInt('notif_quiet_end_min') ?? 0;
      _quietEnd = TimeOfDay(hour: quietEndHour, minute: quietEndMin);
    });
  }

  Future<void> _checkPermissions() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {
      _permissionsGranted =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
              settings.authorizationStatus == AuthorizationStatus.provisional;
      _isLoadingPermissions = false;
    });
  }

  Future<void> _requestPermissions() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    setState(() {
      _permissionsGranted =
          settings.authorizationStatus == AuthorizationStatus.authorized;
    });

    if (!_permissionsGranted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Por favor habilita notificaciones en configuración del sistema'),
          backgroundColor: AppTheme.warningColor,
        ),
      );
    }
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    if (value is bool) {
      await _storage.setBool(key, value);
    } else if (value is int) {
      await _storage.setInt(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.notifications),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Estado de permisos
          _buildPermissionCard(l10n),

          const SizedBox(height: 24),

          // Tipos de notificaciones
          _buildSectionTitle(l10n.notificationTypes),
          const SizedBox(height: 12),
          _buildNotificationToggle(
            l10n.notifTrips,
            l10n.notifTripsDescription,
            Icons.directions_car,
            _tripNotifications,
            (value) {
              setState(() => _tripNotifications = value);
              _saveSetting('notif_trips', value);
            },
          ),
          _buildNotificationToggle(
            l10n.notifPayments,
            l10n.notifPaymentsDescription,
            Icons.payment,
            _paymentNotifications,
            (value) {
              setState(() => _paymentNotifications = value);
              _saveSetting('notif_payments', value);
            },
          ),
          _buildNotificationToggle(
            l10n.notifSecurity,
            l10n.notifSecurityDescription,
            Icons.security,
            _securityNotifications,
            (value) {
              setState(() => _securityNotifications = value);
              _saveSetting('notif_security', value);
            },
            isImportant: true,
          ),
          _buildNotificationToggle(
            l10n.notifPromotions,
            l10n.notifPromotionsDescription,
            Icons.local_offer,
            _promoNotifications,
            (value) {
              setState(() => _promoNotifications = value);
              _saveSetting('notif_promos', value);
            },
          ),

          const SizedBox(height: 24),

          // Sonido y vibración
          _buildSectionTitle(l10n.soundVibration),
          const SizedBox(height: 12),
          _buildSettingTile(
            l10n.soundLabel,
            l10n.soundDescription,
            Icons.volume_up,
            Switch(
              value: _soundEnabled,
              onChanged: (value) {
                setState(() => _soundEnabled = value);
                _saveSetting('notif_sound', value);
              },
              activeTrackColor: AppTheme.primaryLightColor,
            ),
          ),
          _buildSettingTile(
            l10n.vibrationLabel,
            l10n.vibrationDescription,
            Icons.vibration,
            Switch(
              value: _vibrationEnabled,
              onChanged: (value) {
                setState(() => _vibrationEnabled = value);
                _saveSetting('notif_vibration', value);
              },
              activeTrackColor: AppTheme.primaryLightColor,
            ),
          ),

          const SizedBox(height: 24),

          // Horario de No Molestar
          _buildSectionTitle(l10n.doNotDisturb),
          const SizedBox(height: 12),
          _buildSettingTile(
            l10n.quietHours,
            l10n.quietHoursDescription,
            Icons.do_not_disturb_on,
            Switch(
              value: _quietHoursEnabled,
              onChanged: (value) {
                setState(() => _quietHoursEnabled = value);
                _saveSetting('notif_quiet_hours', value);
              },
              activeTrackColor: AppTheme.primaryLightColor,
            ),
          ),
          if (_quietHoursEnabled) ...[
            _buildTimePicker(
              l10n.startTime,
              _quietStart,
              (time) {
                setState(() => _quietStart = time);
                _saveSetting('notif_quiet_start_hour', time.hour);
                _saveSetting('notif_quiet_start_min', time.minute);
              },
            ),
            _buildTimePicker(
              l10n.endTime,
              _quietEnd,
              (time) {
                setState(() => _quietEnd = time);
                _saveSetting('notif_quiet_end_hour', time.hour);
                _saveSetting('notif_quiet_end_min', time.minute);
              },
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: AppTheme.warningColor.withValues(alpha: 0.8),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.securityAlertsAlways,
                      style: TextStyle(
                        color: AppTheme.warningColor.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPermissionCard(AppLocalizations l10n) {
    if (_isLoadingPermissions) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _permissionsGranted
            ? AppTheme.successColor.withValues(alpha: 0.1)
            : AppTheme.warningColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _permissionsGranted
              ? AppTheme.successColor.withValues(alpha: 0.3)
              : AppTheme.warningColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _permissionsGranted
                  ? AppTheme.successColor.withValues(alpha: 0.2)
                  : AppTheme.warningColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _permissionsGranted
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              color: _permissionsGranted
                  ? AppTheme.successColor
                  : AppTheme.warningColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _permissionsGranted
                      ? l10n.notificationsEnabled
                      : l10n.notificationsDisabled,
                  style: TextStyle(
                    color: _permissionsGranted
                        ? AppTheme.successColor
                        : AppTheme.warningColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _permissionsGranted
                      ? l10n.notificationsEnabledDesc
                      : l10n.enableSystemNotifications,
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (!_permissionsGranted)
            ElevatedButton(
              onPressed: _requestPermissions,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.warningColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(l10n.enableButton),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged, {
    bool isImportant = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: isImportant
            ? Border.all(
                color: AppTheme.warningColor.withValues(alpha: 0.3),
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryLightColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isImportant) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.warningColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Builder(
                          builder: (ctx) => Text(
                            AppLocalizations.of(ctx)!.importantLabel,
                            style: const TextStyle(
                              color: AppTheme.warningColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: isImportant ? null : onChanged,
            activeTrackColor: AppTheme.primaryLightColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    IconData icon,
    Widget trailing,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.textSecondaryColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildTimePicker(
    String label,
    TimeOfDay time,
    ValueChanged<TimeOfDay> onChanged,
  ) {
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: time,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppTheme.primaryLightColor,
                  surface: AppTheme.surfaceColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              label == 'Inicio' ? Icons.bedtime : Icons.wb_sunny,
              color: AppTheme.textSecondaryColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              time.format(context),
              style: const TextStyle(
                color: AppTheme.primaryLightColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: AppTheme.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
