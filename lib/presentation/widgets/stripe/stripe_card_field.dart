// lib/presentation/widgets/stripe_card_field.dart

import 'package:blincar_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeCardField extends StatelessWidget {
  final CardFieldInputDetails? Function()? onCardChanged;

  const StripeCardField({
    super.key,
    this.onCardChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CardField(
        onCardChanged: (card) {
          onCardChanged?.call();
        },
        style: const TextStyle(color: AppTheme.textPrimaryColor),
        enablePostalCode: false,
        countryCode: 'MX',
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Número de tarjeta',
          hintStyle: TextStyle(color: AppTheme.textSecondaryColor),
        ),
      ),
    );
  }
}
