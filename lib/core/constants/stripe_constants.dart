// lib/core/constants/stripe_constants.dart

import '../config/env_config.dart';

/// Constantes de configuracion de Stripe
///
/// IMPORTANTE: Las claves se cargan desde .env
/// La secret key NUNCA debe estar en el codigo Flutter.
///
/// Para produccion, asegurate de usar pk_live_* en el archivo .env
class StripeConstants {
  StripeConstants._();

  /// Stripe Publishable Key (desde .env)
  ///
  /// Esta clave es segura para usar en el cliente.
  /// Permite crear tokens de tarjeta pero NO cobrar.
  static String get publishableKey => EnvConfig.stripePublishableKey;

  /// ID del comerciante para Apple Pay / Google Pay
  static String get merchantId => EnvConfig.stripeMerchantId;

  /// Nombre del comerciante que se muestra en Apple Pay / Google Pay
  static String get merchantDisplayName => EnvConfig.stripeMerchantName;

  /// Nombre del pais (Mexico)
  static String get merchantCountryCode => EnvConfig.stripeCountryCode;

  /// Moneda por defecto
  static String get defaultCurrency => EnvConfig.stripeCurrency;
}
