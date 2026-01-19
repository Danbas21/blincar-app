// lib/presentation/pages/profile/edit_profile_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_text_field.dart';

/// Página de edición de perfil de usuario
///
/// Permite editar:
/// - Foto de perfil
/// - Nombre completo
/// - Teléfono
/// - Contacto de emergencia
/// - Email (requiere contraseña)
/// - Contraseña (requiere contraseña actual)
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  // Controllers para información básica
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emergencyNameController;
  late TextEditingController _emergencyPhoneController;

  // Controllers para cambio de email
  final _newEmailController = TextEditingController();
  final _emailPasswordController = TextEditingController();

  // Controllers para cambio de contraseña
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Estado
  User? _currentUser;
  File? _selectedImage;
  bool _isEditingProfile = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emergencyNameController = TextEditingController();
    _emergencyPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _newEmailController.dispose();
    _emailPasswordController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _initializeControllers(User user) {
    if (_currentUser?.id != user.id) {
      _currentUser = user;
      _nameController.text = user.fullName;
      _phoneController.text = user.phoneNumber;
      _emergencyNameController.text = user.emergencyContactName ?? '';
      _emergencyPhoneController.text = user.emergencyContactPhone ?? '';
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        // Subir la imagen automáticamente
        if (mounted) {
          context.read<AuthBloc>().add(
                AuthEvent.uploadProfilePhoto(imageFile: _selectedImage!),
              );
        }
      }
    } catch (e) {
      _showSnackBar('Error al seleccionar imagen: $e', isError: true);
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Cambiar foto de perfil',
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppTheme.accentColor),
                title: const Text(
                  'Tomar foto',
                  style: TextStyle(color: AppTheme.textPrimaryColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppTheme.accentColor),
                title: const Text(
                  'Elegir de galería',
                  style: TextStyle(color: AppTheme.textPrimaryColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthEvent.updateProfile(
              fullName: _nameController.text.trim(),
              phoneNumber: _phoneController.text.trim(),
              emergencyContactName: _emergencyNameController.text.trim(),
              emergencyContactPhone: _emergencyPhoneController.text.trim(),
            ),
          );
    }
  }

  void _updateEmail() {
    if (_emailFormKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthEvent.updateEmail(
              newEmail: _newEmailController.text.trim(),
              currentPassword: _emailPasswordController.text,
            ),
          );
    }
  }

  void _updatePassword() {
    if (_passwordFormKey.currentState?.validate() ?? false) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        _showSnackBar('Las contraseñas no coinciden', isError: true);
        return;
      }

      context.read<AuthBloc>().add(
            AuthEvent.updatePassword(
              currentPassword: _currentPasswordController.text,
              newPassword: _newPasswordController.text,
            ),
          );
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppTheme.errorColor : AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case ProfileUpdated(user: final user, message: final message):
            _showSnackBar(message);
            _initializeControllers(user);
            setState(() {
              _isEditingProfile = false;
              _isEditingEmail = false;
              _selectedImage = null;
            });
            // Limpiar campos de email
            _newEmailController.clear();
            _emailPasswordController.clear();
            break;

          case PasswordUpdated():
            _showSnackBar('Contraseña actualizada correctamente');
            setState(() {
              _isEditingPassword = false;
            });
            // Limpiar campos de contraseña
            _currentPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            break;

          case ProfileError(user: final user, message: final message):
            _showSnackBar(message, isError: true);
            _initializeControllers(user);
            break;

          case AuthError(message: final message):
            _showSnackBar(message, isError: true);
            break;

          case AuthAuthenticated(user: final user):
            _initializeControllers(user);
            break;

          default:
            break;
        }
      },
      builder: (context, state) {
        final isLoading = state is ProfileUpdating || state is UploadingPhoto;

        // Obtener usuario actual
        User? user;
        if (state is AuthAuthenticated) {
          user = state.user;
          _initializeControllers(user);
        } else if (state is ProfileUpdated) {
          user = state.user;
        } else if (state is ProfileError) {
          user = state.user;
        } else if (state is PasswordUpdated) {
          user = state.user;
        }

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: const Text('Editar Perfil'),
            backgroundColor: AppTheme.backgroundColor,
            foregroundColor: AppTheme.textPrimaryColor,
            elevation: 0,
          ),
          body: user == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.accentColor,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Foto de perfil
                      _buildProfilePhotoSection(user, isLoading),

                      const SizedBox(height: 24),

                      // Información básica
                      _buildBasicInfoSection(user, isLoading),

                      const SizedBox(height: 16),

                      // Cambiar email
                      _buildEmailSection(user, isLoading),

                      const SizedBox(height: 16),

                      // Cambiar contraseña
                      _buildPasswordSection(isLoading),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildProfilePhotoSection(User user, bool isLoading) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: isLoading ? null : _showImagePickerOptions,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.accentColor,
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      )
                    : user.photoURL != null && user.photoURL!.isNotEmpty
                        ? Image.network(
                            user.photoURL!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: AppTheme.accentColor,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultAvatar(user),
                          )
                        : _buildDefaultAvatar(user),
              ),
            ),
          ),
          // Botón de cámara
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: isLoading ? null : _showImagePickerOptions,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.backgroundColor,
                    width: 2,
                  ),
                ),
                child: isLoading && _selectedImage != null
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(User user) {
    return Container(
      color: AppTheme.surfaceColor,
      child: Center(
        child: Text(
          user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : 'U',
          style: const TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection(User user, bool isLoading) {
    return _buildExpandableSection(
      title: 'Información Personal',
      icon: Icons.person,
      isExpanded: _isEditingProfile,
      onToggle: () => setState(() => _isEditingProfile = !_isEditingProfile),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: 'Nombre completo',
              hint: 'Tu nombre completo',
              controller: _nameController,
              validator: Validators.name,
              prefixIcon: const Icon(Icons.person_outline,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Teléfono',
              hint: '10 dígitos',
              controller: _phoneController,
              validator: Validators.phone,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_outlined,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Contacto de emergencia',
              hint: 'Nombre del contacto',
              controller: _emergencyNameController,
              prefixIcon: const Icon(Icons.contact_emergency_outlined,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Teléfono de emergencia',
              hint: '10 dígitos',
              controller: _emergencyPhoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_outlined,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 20),
            _buildActionButton(
              text: 'Guardar cambios',
              onPressed: isLoading ? null : _saveProfile,
              isLoading: isLoading && !_isEditingEmail && !_isEditingPassword,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailSection(User user, bool isLoading) {
    return _buildExpandableSection(
      title: 'Cambiar correo electrónico',
      icon: Icons.email,
      subtitle: user.email,
      isExpanded: _isEditingEmail,
      onToggle: () => setState(() => _isEditingEmail = !_isEditingEmail),
      content: Form(
        key: _emailFormKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline,
                      color: AppTheme.warningColor, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Se enviará un correo de verificación al nuevo email',
                      style: TextStyle(
                        color: AppTheme.warningColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Nuevo correo electrónico',
              hint: 'ejemplo@correo.com',
              controller: _newEmailController,
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Contraseña actual',
              hint: 'Ingresa tu contraseña',
              controller: _emailPasswordController,
              validator: (value) => Validators.required(value, 'Contraseña'),
              obscureText: true,
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 20),
            _buildActionButton(
              text: 'Actualizar correo',
              onPressed: isLoading ? null : _updateEmail,
              isLoading: isLoading && _isEditingEmail,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordSection(bool isLoading) {
    return _buildExpandableSection(
      title: 'Cambiar contraseña',
      icon: Icons.lock,
      isExpanded: _isEditingPassword,
      onToggle: () => setState(() => _isEditingPassword = !_isEditingPassword),
      content: Form(
        key: _passwordFormKey,
        child: Column(
          children: [
            CustomTextField(
              label: 'Contraseña actual',
              hint: 'Ingresa tu contraseña actual',
              controller: _currentPasswordController,
              validator: (value) => Validators.required(value, 'Contraseña'),
              obscureText: true,
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Nueva contraseña',
              hint: 'Mínimo 8 caracteres',
              controller: _newPasswordController,
              validator: Validators.password,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Confirmar nueva contraseña',
              hint: 'Repite la nueva contraseña',
              controller: _confirmPasswordController,
              validator: (value) {
                if (value != _newPasswordController.text) {
                  return 'Las contraseñas no coinciden';
                }
                return Validators.password(value);
              },
              obscureText: true,
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppTheme.textSecondaryColor),
              enabled: !isLoading,
            ),
            const SizedBox(height: 20),
            _buildActionButton(
              text: 'Actualizar contraseña',
              onPressed: isLoading ? null : _updatePassword,
              isLoading: isLoading && _isEditingPassword,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    String? subtitle,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget content,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? AppTheme.accentColor : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: AppTheme.accentColor, size: 24),
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: content,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
