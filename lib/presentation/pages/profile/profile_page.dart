import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/user.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/locale/locale_bloc.dart';
import '../../bloc/locale/locale_event.dart';
import '../../bloc/locale/locale_state.dart';
import '../../widgets/common/custom_button.dart';
import '../auth/login_page.dart';
import 'edit_profile_page.dart';
import 'emergency_contact_page.dart';
import 'payment_methods_page.dart';
import 'documentation_page.dart';
import '../dev/dev_tools_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    // Obtener usuario del estado (puede ser AuthAuthenticated o ProfileUpdated)
    final user = switch (authState) {
      AuthAuthenticated(:final user) => user,
      ProfileUpdated(:final user, message: _) => user,
      ProfileError(:final user, message: _) => user,
      _ => null,
    };
    if (user != null) {
      currentUser = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        } else if (state is AuthAuthenticated) {
          setState(() {
            currentUser = state.user;
          });
        } else if (state is ProfileUpdated) {
          setState(() {
            currentUser = state.user;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          title: Text(l10n.myAccount),
          backgroundColor: AppTheme.backgroundColor,
          foregroundColor: AppTheme.textPrimaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 32),
              _buildMenuSection(l10n),
              const SizedBox(height: 32),
              // Sección de conductor (deshabilitada - todos son pasajeros por ahora)
              // if (isDriver) ...[
              //   _buildDriverSection(l10n),
              //   const SizedBox(height: 32),
              // ],
              _buildSettingsSection(l10n),
              const SizedBox(height: 32),
              _buildLogoutButton(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryLightColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: currentUser.photoURL != null
                ? ClipRounded(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      currentUser.photoURL!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser.fullName,
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentUser.email,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLightColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Pasajero',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: AppTheme.primaryLightColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.profile,
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          icon: Icons.person_outline,
          title: l10n.editProfile,
          subtitle: l10n.profile,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.payment,
          title: l10n.paymentMethods,
          subtitle: l10n.paymentMethods,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PaymentMethodsPage(),
              ),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.phone,
          title: l10n.phone,
          subtitle: currentUser.phoneNumber.isNotEmpty
              ? currentUser.phoneNumber
              : l10n.noData,
          trailing: currentUser.phoneNumber.isNotEmpty
              ? const Icon(Icons.verified, color: AppTheme.successColor)
              : const Icon(Icons.warning, color: AppTheme.warningColor),
          onTap: () {
            // Navegar a editar perfil para actualizar telefono
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.contact_emergency,
          title: l10n.emergencyContact,
          subtitle: currentUser.emergencyContactName ?? l10n.noData,
          trailing: currentUser.emergencyContactPhone != null &&
                  currentUser.emergencyContactPhone!.isNotEmpty
              ? const Icon(Icons.verified, color: AppTheme.successColor)
              : const Icon(Icons.warning, color: AppTheme.warningColor),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EmergencyContactPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDriverSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.documentation,
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          icon: Icons.description,
          title: l10n.documentation,
          subtitle: l10n.driverLicense,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DocumentationPage(),
              ),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.verified_user,
          title: l10n.verification,
          subtitle: l10n.loading,
          trailing: const Icon(Icons.pending, color: AppTheme.warningColor),
          onTap: () {
            // TODO: Show verification status
          },
        ),
        _buildMenuItem(
          icon: Icons.account_balance_wallet,
          title: l10n.wallet,
          subtitle: l10n.earnings,
          onTap: () {
            // TODO: Navigate to wallet
          },
        ),
      ],
    );
  }

  Widget _buildSettingsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settings,
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          icon: Icons.build,
          title: 'Dev Tools (DEMO)',
          subtitle: 'Cargar datos de prueba en Firebase',
          trailing: const Icon(Icons.warning, color: AppTheme.warningColor),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DevToolsPage(),
              ),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.notifications_outlined,
          title: l10n.notifications,
          subtitle: l10n.notifications,
          onTap: () {
            // TODO: Navigate to notifications settings
          },
        ),
        // Sección de Idioma con BlocBuilder para mostrar idioma actual
        BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            final currentLocale = localeState.locale;
            final languageName = LocaleBloc.getLanguageName(currentLocale);
            final flag = LocaleBloc.getLanguageFlag(currentLocale);

            return _buildMenuItem(
              icon: Icons.language,
              title: l10n.language,
              subtitle: '$flag $languageName',
              onTap: () {
                _showLanguageDialog(l10n);
              },
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.privacy_tip_outlined,
          title: l10n.privacyPolicy,
          subtitle: l10n.privacyPolicy,
          onTap: () {
            // TODO: Show privacy policy
          },
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          title: l10n.termsAndConditions,
          subtitle: l10n.termsAndConditions,
          onTap: () {
            // TODO: Show terms and conditions
          },
        ),
        _buildMenuItem(
          icon: Icons.help_outline,
          title: l10n.settings,
          subtitle: l10n.settings,
          onTap: () {
            // TODO: Navigate to help
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryLightColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 14,
          ),
        ),
        trailing: trailing ??
            const Icon(
              Icons.chevron_right,
              color: AppTheme.textSecondaryColor,
            ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: isLoading ? null : () => _showLogoutDialog(l10n),
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.logout, color: Colors.white),
            label: Text(
              l10n.logout,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, localeState) {
          final currentLocale = localeState.locale;

          return AlertDialog(
            backgroundColor: AppTheme.surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.language,
                  color: AppTheme.primaryLightColor,
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.selectLanguage,
                  style: TextStyle(color: AppTheme.textPrimaryColor),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.languageDescription,
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                // Opción Español
                _buildLanguageOption(
                  locale: const Locale('es', 'MX'),
                  name: l10n.spanish,
                  flag: '\u{1F1F2}\u{1F1FD}',
                  isSelected: currentLocale.languageCode == 'es',
                  onTap: () {
                    context.read<LocaleBloc>().add(
                          LocaleEvent.change(locale: const Locale('es', 'MX')),
                        );
                    Navigator.of(dialogContext).pop();
                    _showLanguageChangedSnackbar(l10n);
                  },
                ),
                const SizedBox(height: 12),
                // Opción Inglés
                _buildLanguageOption(
                  locale: const Locale('en', 'US'),
                  name: l10n.english,
                  flag: '\u{1F1FA}\u{1F1F8}',
                  isSelected: currentLocale.languageCode == 'en',
                  onTap: () {
                    context.read<LocaleBloc>().add(
                          LocaleEvent.change(locale: const Locale('en', 'US')),
                        );
                    Navigator.of(dialogContext).pop();
                    _showLanguageChangedSnackbar(l10n);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  l10n.cancel,
                  style: TextStyle(color: AppTheme.textSecondaryColor),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageOption({
    required Locale locale,
    required String name,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryLightColor.withValues(alpha: 0.2)
              : AppTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? AppTheme.primaryLightColor : AppTheme.surfaceColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppTheme.successColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  void _showLanguageChangedSnackbar(AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(l10n.languageChanged),
          ],
        ),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          l10n.logout,
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Text(
          l10n.logoutConfirmation,
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: AppTheme.textSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(const AuthEvent.logout());
            },
            child: Text(
              l10n.logout,
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget helper para ClipRounded
class ClipRounded extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;

  const ClipRounded({
    super.key,
    required this.child,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: child,
    );
  }
}
