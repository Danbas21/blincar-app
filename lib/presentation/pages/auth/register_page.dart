import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validators.dart';
import '../../../core/services/storage_upload_service.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../home/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactPhoneController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  final StorageUploadService _storageService = StorageUploadService();

  String _selectedRole = 'passenger';
  bool _acceptTerms = false;
  bool _acceptPrivacy = false;
  bool _isUploadingIne = false;

  // INE Images
  XFile? _ineFrontImage;
  XFile? _ineBackImage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña';
    }
    if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  Future<void> _pickImage(bool isFront) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isFront ? 'INE - Anverso (Frente)' : 'INE - Reverso (Atrás)',
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryLightColor,
                  ),
                ),
                title: const Text(
                  'Tomar foto',
                  style: TextStyle(color: AppTheme.textPrimaryColor),
                ),
                subtitle: const Text(
                  'Usar la cámara del dispositivo',
                  style: TextStyle(color: AppTheme.textSecondaryColor),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await _imagePicker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    setState(() {
                      if (isFront) {
                        _ineFrontImage = image;
                      } else {
                        _ineBackImage = image;
                      }
                    });
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.photo_library,
                    color: AppTheme.accentColor,
                  ),
                ),
                title: const Text(
                  'Seleccionar de galería',
                  style: TextStyle(color: AppTheme.textPrimaryColor),
                ),
                subtitle: const Text(
                  'Elegir una imagen existente',
                  style: TextStyle(color: AppTheme.textSecondaryColor),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await _imagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    setState(() {
                      if (isFront) {
                        _ineFrontImage = image;
                      } else {
                        _ineBackImage = image;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// Sube las imágenes de INE a Firebase Storage y guarda las URLs
  Future<void> _uploadIneImages(String userId) async {
    if (_ineFrontImage == null || _ineBackImage == null) return;

    setState(() => _isUploadingIne = true);

    _log('Subiendo imágenes de INE para usuario: $userId');

    try {
      final urls = await _storageService.uploadIneImages(
        userId: userId,
        frontImage: _ineFrontImage!,
        backImage: _ineBackImage!,
      );

      // Guardar URLs en Firebase Realtime Database
      if (urls['ineFrontUrl'] != null || urls['ineBackUrl'] != null) {
        await FirebaseDatabase.instance
            .ref('blincar/users/$userId/documents')
            .set({
          'ineFrontUrl': urls['ineFrontUrl'],
          'ineBackUrl': urls['ineBackUrl'],
          'uploadedAt': DateTime.now().toIso8601String(),
          'status': 'pending_review', // Para revisión por admin
        });

        _log('URLs de INE guardadas en base de datos');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Documentos subidos correctamente'),
              backgroundColor: AppTheme.successColor,
            ),
          );
        }
      }
    } catch (e) {
      _log('Error subiendo INE: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error subiendo documentos: $e'),
            backgroundColor: AppTheme.warningColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploadingIne = false);
      }
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[RegisterPage] $message');
    }
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debes aceptar los términos y condiciones'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      if (!_acceptPrivacy) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debes aceptar la política de privacidad'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      // Validar INE
      if (_ineFrontImage == null || _ineBackImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debes cargar ambos lados de tu INE'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      context.read<AuthBloc>().add(
            RegisterEvent(
              email: _emailController.text.trim(),
              password: _passwordController.text,
              fullName:
                  '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
              phoneNumber: _phoneController.text.trim(),
              emergencyContactName: _emergencyContactNameController.text.trim(),
              emergencyContactPhone:
                  _emergencyContactPhoneController.text.trim(),
              // TODO: Agregar paths de INE al evento cuando se implemente storage
              // ineFrontPath: _ineFrontImage?.path,
              // ineBackPath: _ineBackImage?.path,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthAuthenticated) {
            // Subir imágenes de INE si existen
            if (_ineFrontImage != null && _ineBackImage != null) {
              await _uploadIneImages(state.user.id);
            }

            if (!mounted) return;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Crear cuenta',
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Completa la información para registrarte',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Tipo de usuario
                    const Text(
                      'Tipo de cuenta',
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedRole = 'passenger'),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _selectedRole == 'passenger'
                                    ? AppTheme.primaryLightColor
                                    : AppTheme.surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedRole == 'passenger'
                                      ? AppTheme.primaryLightColor
                                      : AppTheme.dividerColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: _selectedRole == 'passenger'
                                        ? Colors.white
                                        : AppTheme.textSecondaryColor,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Pasajero',
                                    style: TextStyle(
                                      color: _selectedRole == 'passenger'
                                          ? Colors.white
                                          : AppTheme.textSecondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedRole = 'driver'),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _selectedRole == 'driver'
                                    ? AppTheme.primaryLightColor
                                    : AppTheme.surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedRole == 'driver'
                                      ? AppTheme.primaryLightColor
                                      : AppTheme.dividerColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.drive_eta,
                                    color: _selectedRole == 'driver'
                                        ? Colors.white
                                        : AppTheme.textSecondaryColor,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Conductor',
                                    style: TextStyle(
                                      color: _selectedRole == 'driver'
                                          ? Colors.white
                                          : AppTheme.textSecondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Información personal
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Nombre',
                            hint: 'Tu nombre',
                            controller: _firstNameController,
                            validator: Validators.name,
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            label: 'Apellidos',
                            hint: 'Tus apellidos',
                            controller: _lastNameController,
                            validator: Validators.name,
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    CustomTextField(
                      label: 'Teléfono',
                      hint: '5512345678',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: Validators.phone,
                      prefixIcon: const Icon(
                        Icons.phone_outlined,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),

                    const SizedBox(height: 24),

                    CustomTextField(
                      label: 'Correo Electrónico',
                      hint: 'tu@email.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),

                    const SizedBox(height: 24),

                    CustomTextField(
                      label: 'Contraseña',
                      hint: '••••••••',
                      controller: _passwordController,
                      obscureText: true,
                      validator: Validators.password,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),

                    const SizedBox(height: 24),

                    CustomTextField(
                      label: 'Confirmar Contraseña',
                      hint: '••••••••',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: _validateConfirmPassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ==================== SECCIÓN INE ====================
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.dividerColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryLightColor
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.badge,
                                  color: AppTheme.primaryLightColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Identificación Oficial (INE)',
                                      style: TextStyle(
                                        color: AppTheme.textPrimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Sube fotos claras de tu INE',
                                      style: TextStyle(
                                        color: AppTheme.textSecondaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // INE Anverso (Frente)
                          _buildIneUploadCard(
                            title: 'Anverso (Frente)',
                            subtitle: 'Foto con tu nombre y fotografía',
                            icon: Icons.credit_card,
                            image: _ineFrontImage,
                            onTap: () => _pickImage(true),
                            onRemove: () =>
                                setState(() => _ineFrontImage = null),
                          ),

                          const SizedBox(height: 16),

                          // INE Reverso (Atrás)
                          _buildIneUploadCard(
                            title: 'Reverso (Atrás)',
                            subtitle: 'Foto con el código de barras',
                            icon: Icons.qr_code,
                            image: _ineBackImage,
                            onTap: () => _pickImage(false),
                            onRemove: () =>
                                setState(() => _ineBackImage = null),
                          ),

                          const SizedBox(height: 16),

                          // Info de seguridad
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.successColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: AppTheme.successColor,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Tu información está protegida y encriptada',
                                    style: TextStyle(
                                      color: AppTheme.successColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Contacto de emergencia
                    const Text(
                      'Contacto de Emergencia',
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: 'Nombre del contacto',
                      hint: 'Nombre completo',
                      controller: _emergencyContactNameController,
                      validator: Validators.name,
                      prefixIcon: const Icon(
                        Icons.contact_emergency,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),

                    const SizedBox(height: 24),

                    CustomTextField(
                      label: 'Teléfono de emergencia',
                      hint: '5512345678',
                      controller: _emergencyContactPhoneController,
                      keyboardType: TextInputType.phone,
                      validator: Validators.phone,
                      prefixIcon: const Icon(
                        Icons.phone_in_talk,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Términos y condiciones
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptTerms,
                          onChanged: (value) =>
                              setState(() => _acceptTerms = value ?? false),
                          activeColor: AppTheme.primaryLightColor,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _acceptTerms = !_acceptTerms),
                            child: const Text(
                              'Acepto los términos y condiciones',
                              style:
                                  TextStyle(color: AppTheme.textSecondaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptPrivacy,
                          onChanged: (value) =>
                              setState(() => _acceptPrivacy = value ?? false),
                          activeColor: AppTheme.primaryLightColor,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(
                                () => _acceptPrivacy = !_acceptPrivacy),
                            child: const Text(
                              'Acepto la política de privacidad',
                              style:
                                  TextStyle(color: AppTheme.textSecondaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading =
                            state is AuthLoading || _isUploadingIne;
                        return CustomButton(
                          text: _isUploadingIne
                              ? 'Subiendo documentos...'
                              : 'Crear Cuenta',
                          onPressed: _handleRegister,
                          isLoading: isLoading,
                        );
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIneUploadCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required XFile? image,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    final hasImage = image != null;

    return GestureDetector(
      onTap: hasImage ? null : onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasImage ? AppTheme.successColor : AppTheme.dividerColor,
            width: hasImage ? 2 : 1,
            style: hasImage ? BorderStyle.solid : BorderStyle.solid,
          ),
        ),
        child: hasImage
            ? Stack(
                children: [
                  // Preview de la imagen
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: kIsWeb
                        ? Image.network(
                            image.path,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(image.path),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  // Overlay con info
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.8),
                            Colors.transparent,
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.successColor,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Botones de acción
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      children: [
                        // Botón cambiar
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Botón eliminar
                        GestureDetector(
                          onTap: onRemove,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppTheme.errorColor.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: AppTheme.textSecondaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: AppTheme.primaryLightColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
