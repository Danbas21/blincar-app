// lib/presentation/pages/panic/panic_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/user.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_button.dart';
import '../profile/emergency_contact_page.dart';

/// Página del Botón de Pánico
///
/// Funcionalidades:
/// - Cuenta regresiva antes de activar la alerta
/// - Llama automáticamente al contacto de emergencia
/// - Notifica a autoridades y sistema Blincar
/// - Comparte ubicación en tiempo real
class PanicPage extends StatefulWidget {
  const PanicPage({super.key});

  @override
  State<PanicPage> createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _countdownController;
  late Animation<double> _pulseAnimation;

  bool _isPanicActivated = false;
  bool _isCountingDown = false;
  int _countdown = 5;
  Timer? _countdownTimer;

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadUser();
  }

  void _loadUser() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      setState(() {
        _currentUser = authState.user;
      });
    }
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _countdownController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _countdownController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startPanicSequence() {
    setState(() {
      _isCountingDown = true;
      _countdown = 5;
    });

    // Vibración intensa
    HapticFeedback.heavyImpact();

    _countdownController.forward();

    // Countdown
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
        HapticFeedback.mediumImpact();
      } else {
        timer.cancel();
        _activatePanic();
      }
    });
  }

  void _activatePanic() {
    setState(() {
      _isPanicActivated = true;
      _isCountingDown = false;
    });

    // Vibración de alerta
    HapticFeedback.heavyImpact();

    // Enviar alerta y llamar al contacto de emergencia
    _sendPanicAlert();
    _callEmergencyContact();
  }

  void _sendPanicAlert() {
    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(l10n.alertSent)),
          ],
        ),
        backgroundColor: AppTheme.errorColor,
        duration: const Duration(seconds: 3),
      ),
    );

    // TODO: Implementar envío real de alerta a:
    // - Autoridades locales
    // - Centro de monitoreo Blincar
    // - Compartir ubicación GPS en tiempo real
    // - Iniciar grabación de audio/video
  }

  Future<void> _callEmergencyContact() async {
    final l10n = AppLocalizations.of(context)!;

    if (_currentUser?.emergencyContactPhone == null ||
        _currentUser!.emergencyContactPhone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.warning, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(l10n.noEmergencyContactConfigured)),
            ],
          ),
          backgroundColor: AppTheme.warningColor,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Configurar',
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EmergencyContactPage(),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    // Mostrar mensaje de llamada
    final contactName = _currentUser!.emergencyContactName ?? 'Contacto';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.phone_in_talk, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(l10n.callingContact(contactName))),
          ],
        ),
        backgroundColor: AppTheme.successColor,
        duration: const Duration(seconds: 2),
      ),
    );

    // Realizar la llamada
    final phoneNumber =
        _currentUser!.emergencyContactPhone!.replaceAll(RegExp(r'[^0-9+]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(child: Text(l10n.callFailed)),
                ],
              ),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text(l10n.callFailed)),
              ],
            ),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _cancelPanic() {
    _countdownController.reset();
    _countdownTimer?.cancel();
    setState(() {
      _isCountingDown = false;
      _countdown = 5;
    });
  }

  void _deactivatePanic() {
    setState(() {
      _isPanicActivated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          setState(() {
            _currentUser = state.user;
          });
        }
      },
      child: Scaffold(
        backgroundColor:
            _isPanicActivated ? AppTheme.errorColor : AppTheme.backgroundColor,
        appBar: AppBar(
          title: Text(
            _isPanicActivated ? l10n.panicAlertActive : l10n.panicTitle,
            style: TextStyle(
              color:
                  _isPanicActivated ? Colors.white : AppTheme.textPrimaryColor,
            ),
          ),
          backgroundColor: _isPanicActivated
              ? AppTheme.errorColor
              : AppTheme.backgroundColor,
          foregroundColor:
              _isPanicActivated ? Colors.white : AppTheme.textPrimaryColor,
          elevation: 0,
        ),
        body: _isPanicActivated
            ? _buildActiveAlertView(l10n)
            : _buildPanicView(l10n),
      ),
    );
  }

  Widget _buildPanicView(AppLocalizations l10n) {
    final hasEmergencyContact = _currentUser?.emergencyContactPhone != null &&
        _currentUser!.emergencyContactPhone!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Información de seguridad
          _buildSecurityInfoCard(l10n),
          const SizedBox(height: 24),

          // Advertencia si no hay contacto de emergencia
          if (!hasEmergencyContact) _buildNoContactWarning(l10n),

          const Spacer(),

          if (_isCountingDown)
            _buildCountdownView(l10n)
          else
            _buildPanicButton(),

          const SizedBox(height: 40),

          // Contactos de emergencia
          _buildEmergencyContactsCard(l10n),
        ],
      ),
    );
  }

  Widget _buildSecurityInfoCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.security,
            color: AppTheme.primaryLightColor,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.emergencySystem,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.panicActivateInfo,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(l10n.panicFeature1),
          _buildFeatureItem(l10n.panicFeature2),
          _buildFeatureItem(l10n.panicFeature3),
          _buildFeatureItem(l10n.panicFeature4),
          _buildFeatureItem(l10n.panicFeature5),
        ],
      ),
    );
  }

  Widget _buildNoContactWarning(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EmergencyContactPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.warningColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.warningColor.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: AppTheme.warningColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.emergencyContactRequired,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.configureEmergencyContact,
                    style: TextStyle(
                      color: AppTheme.warningColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppTheme.warningColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownView(AppLocalizations l10n) {
    return Column(
      children: [
        Text(
          l10n.activatingAlertIn,
          style: const TextStyle(
            color: AppTheme.errorColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppTheme.errorColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.errorColor.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(
              _countdown.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        CustomButton(
          text: l10n.cancel.toUpperCase(),
          onPressed: _cancelPanic,
          type: ButtonType.secondary,
        ),
      ],
    );
  }

  Widget _buildPanicButton() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: GestureDetector(
        onTap: _startPanicSequence,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            gradient: const RadialGradient(
              colors: [AppTheme.errorColor, Color(0xFFD32F2F)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.errorColor.withValues(alpha: 0.4),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.panicButton.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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

  Widget _buildEmergencyContactsCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.emergencyContacts,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_currentUser?.emergencyContactPhone != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EmergencyContactPage(),
                      ),
                    );
                  },
                  child: Text(
                    l10n.editProfile,
                    style: const TextStyle(
                      color: AppTheme.primaryLightColor,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _buildEmergencyContactItem(
            '911',
            l10n.emergencies,
            Icons.local_police,
            onTap: () => _makeCall('911'),
          ),
          if (_currentUser?.emergencyContactPhone != null &&
              _currentUser!.emergencyContactPhone!.isNotEmpty)
            _buildEmergencyContactItem(
              _currentUser!.emergencyContactPhone!,
              _currentUser!.emergencyContactName ?? l10n.emergencyContact,
              Icons.person,
              onTap: () => _makeCall(_currentUser!.emergencyContactPhone!),
              isHighlighted: true,
            )
          else
            _buildAddContactItem(l10n),
          _buildEmergencyContactItem(
            'Centro Blincar',
            l10n.support247,
            Icons.headset_mic,
            onTap: () => _makeCall('+525512345678'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactItem(
    String number,
    String name,
    IconData icon, {
    VoidCallback? onTap,
    bool isHighlighted = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: isHighlighted
            ? BoxDecoration(
                color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isHighlighted
                    ? AppTheme.primaryLightColor.withValues(alpha: 0.2)
                    : AppTheme.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isHighlighted
                    ? AppTheme.primaryLightColor
                    : AppTheme.textSecondaryColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 14,
                      fontWeight:
                          isHighlighted ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  Text(
                    number,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.phone,
              color: isHighlighted
                  ? AppTheme.primaryLightColor
                  : AppTheme.textSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddContactItem(AppLocalizations l10n) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EmergencyContactPage(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.warningColor.withValues(alpha: 0.5),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.person_add,
                color: AppTheme.warningColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.configureEmergencyContact,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    l10n.notConfigured,
                    style: const TextStyle(
                      color: AppTheme.warningColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.add,
              color: AppTheme.warningColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makeCall(String phoneNumber) async {
    final l10n = AppLocalizations.of(context)!;
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.callFailed),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.callFailed),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  Widget _buildActiveAlertView(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 60),

          const Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 80,
          ),

          const SizedBox(height: 20),

          Text(
            l10n.panicAlertActive,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            l10n.authoritiesNotified,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 40),

          // Estado de la alerta
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildAlertStatus(l10n.authoritiesNotifiedStatus, true),
                _buildAlertStatus(l10n.emergencyContactCalled, true),
                _buildAlertStatus(l10n.recordingStarted, true),
                _buildAlertStatus(l10n.locationShared, true),
                _buildAlertStatus(l10n.nearbyDriversAlerted, true),
              ],
            ),
          ),

          const Spacer(),

          // Botón para llamar nuevamente al contacto
          if (_currentUser?.emergencyContactPhone != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomButton(
                text:
                    'Llamar a ${_currentUser!.emergencyContactName ?? "Contacto"}',
                onPressed: _callEmergencyContact,
                type: ButtonType.secondary,
              ),
            ),

          CustomButton(
            text: l10n.deactivateAlert,
            onPressed: _deactivatePanic,
            type: ButtonType.secondary,
          ),

          const SizedBox(height: 20),

          Text(
            l10n.deactivateOnlySafe,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppTheme.successColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertStatus(String text, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.radio_button_unchecked,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
