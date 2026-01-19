import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/custom_button.dart';

/// Bottom sheet para agregar una nueva tarjeta
///
/// Muestra un formulario simplificado para agregar métodos de pago.
/// TODO: Integrar con Stripe para captura segura de tarjetas.
class AddCardBottomSheet extends StatefulWidget {
  final String userId;
  final VoidCallback? onCardAdded;

  const AddCardBottomSheet({
    super.key,
    required this.userId,
    this.onCardAdded,
  });

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  bool _isLoading = false;

  void _addCard() async {
    setState(() => _isLoading = true);

    // TODO: Implementar integración con Stripe
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    if (widget.onCardAdded != null) {
      widget.onCardAdded!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Agregar tarjeta',
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'La integración con Stripe está en desarrollo.',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Cerrar',
            onPressed: () => Navigator.pop(context),
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
