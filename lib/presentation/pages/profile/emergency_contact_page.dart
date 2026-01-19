// lib/presentation/pages/profile/emergency_contact_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_button.dart';

/// Página para configurar el contacto de emergencia
///
/// Funcionalidades:
/// - Agregar/editar nombre del contacto de emergencia
/// - Agregar/editar teléfono del contacto de emergencia
/// - Validación de datos
/// - Información sobre cómo se usa el contacto
class EmergencyContactPage extends StatefulWidget {
  const EmergencyContactPage({super.key});

  @override
  State<EmergencyContactPage> createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentContact();
  }

  void _loadCurrentContact() {
    final authState = context.read<AuthBloc>().state;

    // Obtener usuario del estado actual (puede ser AuthAuthenticated o ProfileUpdated)
    final user = switch (authState) {
      AuthAuthenticated(:final user) => user,
      ProfileUpdated(:final user, message: _) => user,
      ProfileError(:final user, message: _) => user,
      _ => null,
    };

    if (user != null) {
      _nameController.text = user.emergencyContactName ?? '';
      _phoneController.text = user.emergencyContactPhone ?? '';
    }

    // Escuchar cambios para detectar modificaciones
    _nameController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    final authState = context.read<AuthBloc>().state;

    final user = switch (authState) {
      AuthAuthenticated(:final user) => user,
      ProfileUpdated(:final user, message: _) => user,
      ProfileError(:final user, message: _) => user,
      _ => null,
    };

    if (user != null) {
      final originalName = user.emergencyContactName ?? '';
      final originalPhone = user.emergencyContactPhone ?? '';

      setState(() {
        _hasChanges = _nameController.text != originalName ||
            _phoneController.text != originalPhone;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final authState = context.read<AuthBloc>().state;

      final user = switch (authState) {
        AuthAuthenticated(:final user) => user,
        ProfileUpdated(:final user, message: _) => user,
        ProfileError(:final user, message: _) => user,
        _ => null,
      };

      if (user != null) {
        context.read<AuthBloc>().add(
              AuthEvent.updateProfile(
                fullName: user.fullName,
                phoneNumber: user.phoneNumber,
                emergencyContactName: _nameController.text.trim(),
                emergencyContactPhone: _phoneController.text.trim(),
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(child: Text(state.message)),
                ],
              ),
              backgroundColor: AppTheme.successColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(child: Text(state.message)),
                ],
              ),
              backgroundColor: AppTheme.errorColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          title: Text(l10n.emergencyContact),
          backgroundColor: AppTheme.backgroundColor,
          foregroundColor: AppTheme.textPrimaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Información importante
                _buildInfoCard(l10n),
                const SizedBox(height: 32),

                // Formulario
                _buildFormSection(l10n),
                const SizedBox(height: 32),

                // Información adicional
                _buildAdditionalInfo(l10n),
                const SizedBox(height: 32),

                // Botón guardar
                _buildSaveButton(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.errorColor.withValues(alpha: 0.2),
            AppTheme.errorColor.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.errorColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.emergency,
                  color: AppTheme.errorColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.emergencyContact,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getEmergencyDescription(l10n),
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getEmergencyDescription(AppLocalizations l10n) {
    // Usar texto localizado si está disponible, sino usar default
    return 'Este contacto será llamado automáticamente cuando actives el botón de pánico';
  }

  Widget _buildFormSection(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre del contacto
          Text(
            _getContactNameLabel(l10n),
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            style: const TextStyle(color: AppTheme.textPrimaryColor),
            decoration: InputDecoration(
              hintText: _getContactNameHint(l10n),
              hintStyle: TextStyle(
                color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
              ),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: AppTheme.primaryLightColor,
              ),
              filled: true,
              fillColor: AppTheme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryLightColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.errorColor,
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return _getNameRequiredError(l10n);
              }
              if (value.trim().length < 2) {
                return _getNameTooShortError(l10n);
              }
              return null;
            },
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 24),

          // Teléfono del contacto
          Text(
            l10n.emergencyContactPhone,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,
            style: const TextStyle(color: AppTheme.textPrimaryColor),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s()]')),
              LengthLimitingTextInputFormatter(15),
            ],
            decoration: InputDecoration(
              hintText: _getPhoneHint(l10n),
              hintStyle: TextStyle(
                color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
              ),
              prefixIcon: const Icon(
                Icons.phone_outlined,
                color: AppTheme.primaryLightColor,
              ),
              prefixText: '+52 ',
              prefixStyle: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
              ),
              filled: true,
              fillColor: AppTheme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryLightColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.errorColor,
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return _getPhoneRequiredError(l10n);
              }
              // Remover caracteres no numéricos para validación
              final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
              if (digitsOnly.length < 10) {
                return _getPhoneInvalidError(l10n);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Métodos helper para textos (hasta que se agreguen al ARB)
  String _getContactNameLabel(AppLocalizations l10n) => 'Nombre del contacto';
  String _getContactNameHint(AppLocalizations l10n) => 'Ej: María García';
  String _getNameRequiredError(AppLocalizations l10n) =>
      'El nombre es requerido';
  String _getNameTooShortError(AppLocalizations l10n) =>
      'El nombre debe tener al menos 2 caracteres';
  String _getPhoneHint(AppLocalizations l10n) => '55 1234 5678';
  String _getPhoneRequiredError(AppLocalizations l10n) =>
      'El teléfono es requerido';
  String _getPhoneInvalidError(AppLocalizations l10n) =>
      'Ingresa un número de teléfono válido';

  Widget _buildAdditionalInfo(AppLocalizations l10n) {
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
            children: [
              const Icon(
                Icons.info_outline,
                color: AppTheme.primaryLightColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                _getWhenContactedTitle(l10n),
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            Icons.warning_rounded,
            _getContactInfo1(l10n),
            AppTheme.errorColor,
          ),
          _buildInfoItem(
            Icons.phone_in_talk,
            _getContactInfo2(l10n),
            AppTheme.primaryLightColor,
          ),
          _buildInfoItem(
            Icons.location_on,
            _getContactInfo3(l10n),
            AppTheme.successColor,
          ),
          _buildInfoItem(
            Icons.message,
            _getContactInfo4(l10n),
            AppTheme.warningColor,
          ),
        ],
      ),
    );
  }

  String _getWhenContactedTitle(AppLocalizations l10n) =>
      '¿Cuándo se contactará?';
  String _getContactInfo1(AppLocalizations l10n) =>
      'Cuando actives el botón de pánico';
  String _getContactInfo2(AppLocalizations l10n) =>
      'Recibirá una llamada automática';
  String _getContactInfo3(AppLocalizations l10n) =>
      'Se compartirá tu ubicación en tiempo real';
  String _getContactInfo4(AppLocalizations l10n) =>
      'Recibirá un SMS con información del viaje';

  Widget _buildInfoItem(IconData icon, String text, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is ProfileUpdating;

        return CustomButton(
          text: 'Guardar cambios',
          onPressed: _hasChanges && !isLoading ? _saveContact : null,
          isLoading: isLoading,
        );
      },
    );
  }
}
