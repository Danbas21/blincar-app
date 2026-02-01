import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

/// Página para eliminar la cuenta del usuario
///
/// Flujo:
/// 1. Usuario confirma escribiendo "ELIMINAR"
/// 2. Se solicita re-autenticación por seguridad
/// 3. Se eliminan datos de Firebase Database
/// 4. Se elimina cuenta de Firebase Auth
/// 5. Se cierra sesión y redirige a login
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isDeleting = false;
  bool _showPasswordField = false;
  String? _errorMessage;

  @override
  void dispose() {
    _confirmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _canDelete {
    final text = _confirmController.text.toUpperCase();
    return text == 'ELIMINAR' || text == 'DELETE';
  }

  Future<void> _deleteAccount() async {
    if (!_canDelete) return;

    final l10n = AppLocalizations.of(context)!;

    // Mostrar diálogo de confirmación final
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Text(
          l10n.confirmDeleteAccount,
          style: const TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Text(
          l10n.deleteAccountWarning,
          style: const TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              l10n.cancel,
              style: const TextStyle(color: AppTheme.textSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.delete,
              style: const TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isDeleting = true;
      _errorMessage = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _isDeleting = false;
          _errorMessage = 'Usuario no autenticado';
        });
        return;
      }

      // Verificar si necesitamos re-autenticación
      final providers = user.providerData.map((e) => e.providerId).toList();
      final needsReauth = providers.contains('password');

      if (needsReauth && !_showPasswordField) {
        setState(() {
          _showPasswordField = true;
          _isDeleting = false;
        });
        return;
      }

      // Re-autenticar si es necesario
      if (needsReauth && _passwordController.text.isNotEmpty) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _passwordController.text,
        );
        await user.reauthenticateWithCredential(credential);
      }

      // Eliminar datos del usuario en Firebase Database
      await _deleteUserData(user.uid);

      // Eliminar cuenta de Firebase Auth
      await user.delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.accountDeleted),
            backgroundColor: AppTheme.successColor,
          ),
        );

        // Cerrar sesión y redirigir a login
        context.read<AuthBloc>().add(const LogoutEvent());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isDeleting = false;
        _errorMessage = _getErrorMessage(e.code);
      });
    } catch (e) {
      setState(() {
        _isDeleting = false;
        _errorMessage = 'Error al eliminar cuenta: $e';
      });
    }
  }

  Future<void> _deleteUserData(String userId) async {
    final database = FirebaseDatabase.instance;

    // Eliminar datos del usuario
    await database.ref('blincar/users/$userId').remove();

    // Eliminar documentos del usuario
    await database.ref('blincar/documents/$userId').remove();

    // Eliminar ratings hechos por el usuario
    final ratingsSnapshot = await database
        .ref('blincar/ratings')
        .orderByChild('passengerId')
        .equalTo(userId)
        .once();

    if (ratingsSnapshot.snapshot.value != null) {
      final ratings = ratingsSnapshot.snapshot.value as Map<dynamic, dynamic>;
      for (final key in ratings.keys) {
        await database.ref('blincar/ratings/$key').remove();
      }
    }

    // Marcar viajes del usuario como "cuenta eliminada"
    final tripsSnapshot = await database
        .ref('blincar/trips')
        .orderByChild('passengerId')
        .equalTo(userId)
        .once();

    if (tripsSnapshot.snapshot.value != null) {
      final trips = tripsSnapshot.snapshot.value as Map<dynamic, dynamic>;
      for (final key in trips.keys) {
        await database.ref('blincar/trips/$key/passengerDeleted').set(true);
      }
    }

    debugPrint('[DeleteAccount] Datos del usuario $userId eliminados');
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'requires-recent-login':
        return 'Por seguridad, vuelve a iniciar sesión antes de eliminar tu cuenta';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde';
      default:
        return 'Error: $code';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.deleteAccount,
          style: const TextStyle(color: AppTheme.textPrimaryColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icono de advertencia
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: AppTheme.errorColor,
                    size: 64,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Título de advertencia
              const Center(
                child: Text(
                  '¿Eliminar tu cuenta?',
                  style: TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Descripción
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.errorColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.deleteAccountWarning,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildWarningItem('Tu perfil e información personal'),
                    _buildWarningItem('Historial de viajes'),
                    _buildWarningItem('Métodos de pago guardados'),
                    _buildWarningItem('Calificaciones y comentarios'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Error message
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppTheme.errorColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: AppTheme.errorColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Campo de confirmación
              Text(
                l10n.typeDeleteToConfirm,
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(color: AppTheme.textPrimaryColor),
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'ELIMINAR',
                  hintStyle: const TextStyle(color: AppTheme.textSecondaryColor),
                  filled: true,
                  fillColor: AppTheme.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.dividerColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.dividerColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _canDelete
                          ? AppTheme.errorColor
                          : AppTheme.primaryLightColor,
                    ),
                  ),
                ),
              ),

              // Campo de contraseña (si se necesita re-autenticación)
              if (_showPasswordField) ...[
                const SizedBox(height: 16),
                const Text(
                  'Por seguridad, ingresa tu contraseña:',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: '',
                  hint: 'Contraseña actual',
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],

              const Spacer(),

              // Botón de eliminar
              CustomButton(
                text: l10n.deleteAccount.toUpperCase(),
                onPressed: _canDelete ? _deleteAccount : null,
                isLoading: _isDeleting,
                type: ButtonType.primary,
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    l10n.cancel,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Icon(
            Icons.remove_circle_outline,
            color: AppTheme.errorColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
