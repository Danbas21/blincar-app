import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/common/custom_button.dart';

/// Página de verificación de teléfono por SMS OTP
///
/// Flujo:
/// 1. Usuario ingresa su número de teléfono
/// 2. Firebase envía SMS con código de 6 dígitos
/// 3. Usuario ingresa el código
/// 4. Verificación exitosa → callback con credenciales
class PhoneVerificationPage extends StatefulWidget {
  final String? initialPhoneNumber;
  final Function(PhoneAuthCredential credential)? onVerified;
  final VoidCallback? onSkip;
  final bool allowSkip;

  const PhoneVerificationPage({
    super.key,
    this.initialPhoneNumber,
    this.onVerified,
    this.onSkip,
    this.allowSkip = false,
  });

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  bool _codeSent = false;
  String? _verificationId;
  int? _resendToken;
  String? _errorMessage;

  Timer? _resendTimer;
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialPhoneNumber != null) {
      _phoneController.text = widget.initialPhoneNumber!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _otpFocusNodes) {
      node.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  String _formatPhoneNumber(String phone) {
    // Limpiar y formatear número mexicano
    String cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');

    // Si empieza con 52, ya tiene código de país
    if (cleaned.startsWith('52')) {
      return '+$cleaned';
    }

    // Si es número de 10 dígitos, agregar +52
    if (cleaned.length == 10) {
      return '+52$cleaned';
    }

    // Si ya tiene +, devolverlo
    if (phone.startsWith('+')) {
      return phone;
    }

    return '+52$cleaned';
  }

  Future<void> _sendVerificationCode() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() => _errorMessage = 'Ingresa tu número de teléfono');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final formattedPhone = _formatPhoneNumber(phone);

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verificación en Android (cuando se detecta el SMS automáticamente)
          debugPrint('[PhoneVerification] Auto-verificación completada');
          if (widget.onVerified != null) {
            widget.onVerified!(credential);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('[PhoneVerification] Error: ${e.message}');
          setState(() {
            _isLoading = false;
            _errorMessage = _getErrorMessage(e.code);
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint('[PhoneVerification] Código enviado');
          setState(() {
            _isLoading = false;
            _codeSent = true;
            _verificationId = verificationId;
            _resendToken = resendToken;
          });
          _startResendTimer();
          _otpFocusNodes[0].requestFocus();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        forceResendingToken: _resendToken,
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al enviar código: $e';
      });
    }
  }

  void _startResendTimer() {
    _resendCountdown = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _verifyCode() async {
    final code = _otpControllers.map((c) => c.text).join();
    if (code.length != 6) {
      setState(() => _errorMessage = 'Ingresa el código completo de 6 dígitos');
      return;
    }

    if (_verificationId == null) {
      setState(() => _errorMessage = 'Error: Vuelve a solicitar el código');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      if (widget.onVerified != null) {
        widget.onVerified!(credential);
      } else {
        // Si no hay callback, intentar vincular al usuario actual
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          await currentUser.linkWithCredential(credential);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Teléfono verificado correctamente'),
                backgroundColor: AppTheme.successColor,
              ),
            );
            Navigator.of(context).pop(true);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = _getErrorMessage(e.code);
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al verificar código: $e';
      });
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'invalid-phone-number':
        return 'Número de teléfono inválido';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde';
      case 'invalid-verification-code':
        return 'Código incorrecto. Verifica e intenta de nuevo';
      case 'session-expired':
        return 'El código ha expirado. Solicita uno nuevo';
      case 'credential-already-in-use':
        return 'Este teléfono ya está vinculado a otra cuenta';
      default:
        return 'Error de verificación: $code';
    }
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _otpFocusNodes[index + 1].requestFocus();
    }

    // Auto-verificar cuando se completan los 6 dígitos
    final code = _otpControllers.map((c) => c.text).join();
    if (code.length == 6) {
      _verifyCode();
    }
  }

  void _onOtpKeyDown(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _otpControllers[index].text.isEmpty &&
        index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
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
        actions: widget.allowSkip
            ? [
                TextButton(
                  onPressed: widget.onSkip ?? () => Navigator.of(context).pop(),
                  child: Text(
                    l10n.cancel,
                    style: const TextStyle(color: AppTheme.textSecondaryColor),
                  ),
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Icon(
                _codeSent ? Icons.sms : Icons.phone_android,
                color: AppTheme.primaryLightColor,
                size: 48,
              ),
              const SizedBox(height: 24),
              Text(
                _codeSent ? l10n.enterVerificationCode : l10n.verifyPhone,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _codeSent
                    ? l10n.codeSentTo(_formatPhoneNumber(_phoneController.text))
                    : l10n.enterPhoneToVerify,
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),

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

              // Phone input or OTP input
              if (!_codeSent)
                _buildPhoneInput()
              else
                _buildOtpInput(),

              const Spacer(),

              // Action button
              CustomButton(
                text: _codeSent ? l10n.verify : l10n.sendCode,
                onPressed: _codeSent ? _verifyCode : _sendVerificationCode,
                isLoading: _isLoading,
              ),

              // Resend option
              if (_codeSent) ...[
                const SizedBox(height: 16),
                Center(
                  child: _resendCountdown > 0
                      ? Text(
                          l10n.resendCodeIn(_resendCountdown),
                          style: const TextStyle(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 14,
                          ),
                        )
                      : TextButton(
                          onPressed: _sendVerificationCode,
                          child: Text(
                            l10n.resendCode,
                            style: const TextStyle(
                              color: AppTheme.primaryLightColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ],

              // Change number option
              if (_codeSent) ...[
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _codeSent = false;
                        _verificationId = null;
                        for (final controller in _otpControllers) {
                          controller.clear();
                        }
                      });
                    },
                    child: Text(
                      l10n.changePhoneNumber,
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Row(
        children: [
          // Country code
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: AppTheme.dividerColor),
              ),
            ),
            child: const Row(
              children: [
                Text(
                  '+52',
                  style: TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.textSecondaryColor,
                ),
              ],
            ),
          ),
          // Phone number input
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                hintText: '55 1234 5678',
                hintStyle: TextStyle(color: AppTheme.textSecondaryColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 48,
          height: 56,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) => _onOtpKeyDown(index, event),
            child: TextField(
              controller: _otpControllers[index],
              focusNode: _otpFocusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                counterText: '',
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
                  borderSide:
                      const BorderSide(color: AppTheme.primaryLightColor, width: 2),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _onOtpChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}
