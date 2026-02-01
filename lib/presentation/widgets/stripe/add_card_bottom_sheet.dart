import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/stripe_backend_service.dart';
import '../../../core/services/service_locator.dart';
import '../../widgets/common/custom_button.dart';

/// Bottom sheet para agregar una nueva tarjeta usando Stripe SDK
///
/// Usa el CardField oficial de Stripe para captura segura de datos
/// cumpliendo con PCI DSS (los datos nunca tocan nuestros servidores).
class AddCardBottomSheet extends StatefulWidget {
  final String userId;
  final VoidCallback? onCardAdded;

  const AddCardBottomSheet({
    super.key,
    required this.userId,
    this.onCardAdded,
  });

  /// Muestra el bottom sheet y retorna true si se agregó una tarjeta
  static Future<bool?> show(BuildContext context, String userId) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCardBottomSheet(
        userId: userId,
        onCardAdded: () => Navigator.pop(context, true),
      ),
    );
  }

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  bool _isLoading = false;
  bool _isCardComplete = false;
  String? _errorMessage;

  final StripeBackendService _stripeBackend = getIt<StripeBackendService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          const Text(
            'Agregar tarjeta',
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ingresa los datos de tu tarjeta de crédito o débito',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // Stripe CardField
          Container(
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _errorMessage != null
                    ? AppTheme.errorColor
                    : AppTheme.dividerColor,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: CardField(
              onCardChanged: (card) {
                setState(() {
                  _isCardComplete = card?.complete ?? false;
                  _errorMessage = null;
                });
              },
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
              ),
              enablePostalCode: false,
              countryCode: 'MX',
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppTheme.textSecondaryColor),
              ),
            ),
          ),

          // Error message
          if (_errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: AppTheme.errorColor,
                fontSize: 12,
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Security note
          Row(
            children: [
              Icon(
                Icons.lock_outline,
                size: 16,
                color: AppTheme.textSecondaryColor.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tus datos están protegidos con encriptación de Stripe',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancelar',
                  onPressed: () => Navigator.pop(context, false),
                  type: ButtonType.outline,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Guardar',
                  onPressed:
                      _isCardComplete && !_isLoading ? _handleSaveCard : null,
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleSaveCard() async {
    if (!_isCardComplete) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Get or create Stripe customer
      final customerResult = await _stripeBackend.getOrCreateCustomer();
      if (!customerResult.isSuccess) {
        throw Exception(customerResult.error);
      }

      // 2. Create SetupIntent for secure card storage
      final setupResult = await _stripeBackend.createSetupIntent();
      if (!setupResult.isSuccess) {
        throw Exception(setupResult.error);
      }

      // 3. Confirm SetupIntent with card details (handled by Stripe SDK)
      final setupIntent = await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: setupResult.data!.clientSecret,
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      if (setupIntent.status == PaymentIntentsStatus.Succeeded) {
        // Success - card was saved
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tarjeta agregada correctamente'),
              backgroundColor: AppTheme.successColor,
            ),
          );
          widget.onCardAdded?.call();
        }
      } else {
        throw Exception('Error al confirmar la tarjeta');
      }
    } on StripeException catch (e) {
      setState(() {
        _errorMessage = _mapStripeError(e);
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _mapStripeError(StripeException e) {
    switch (e.error.code) {
      case FailureCode.Canceled:
        return 'Operación cancelada';
      case FailureCode.Failed:
        return e.error.localizedMessage ?? 'Error al procesar la tarjeta';
      case FailureCode.Timeout:
        return 'Tiempo de espera agotado';
      default:
        return e.error.localizedMessage ?? 'Error desconocido';
    }
  }
}
