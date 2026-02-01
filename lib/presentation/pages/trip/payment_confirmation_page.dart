// lib/presentation/pages/trip/payment_confirmation_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/services/stripe_backend_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/payment_card.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/payment/payment_bloc.dart';
import '../../bloc/payment/payment_event.dart';
import '../../bloc/payment/payment_state.dart';
import '../profile/payment_methods_page.dart';

/// Estados posibles del proceso de pago
enum PaymentProcessState {
  idle,       // No hay pago en proceso
  processing, // Procesando pago (llamando a backend)
  pending,    // Esperando confirmacion del backend
  completed,  // Pago completado exitosamente
  failed,     // Pago fallido
}

/// Datos del viaje para mostrar en la pantalla de pago
class TripPaymentData {
  final String originAddress;
  final String destinationAddress;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;
  final String serviceType;
  final double totalPrice;
  final int? estimatedDurationMinutes;
  final double? estimatedDistanceKm;
  final String? durationText;

  const TripPaymentData({
    required this.originAddress,
    required this.destinationAddress,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.serviceType,
    required this.totalPrice,
    this.estimatedDurationMinutes,
    this.estimatedDistanceKm,
    this.durationText,
  });
}

/// Pantalla de confirmacion de pago antes de solicitar el viaje
/// Flujo estilo Uber: Solicitar -> Pagar -> Confirmar
class PaymentConfirmationPage extends StatelessWidget {
  final TripPaymentData tripData;
  final VoidCallback onPaymentConfirmed;

  const PaymentConfirmationPage({
    super.key,
    required this.tripData,
    required this.onPaymentConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentBloc>(),
      child: _PaymentConfirmationView(
        tripData: tripData,
        onPaymentConfirmed: onPaymentConfirmed,
      ),
    );
  }
}

class _PaymentConfirmationView extends StatefulWidget {
  final TripPaymentData tripData;
  final VoidCallback onPaymentConfirmed;

  const _PaymentConfirmationView({
    required this.tripData,
    required this.onPaymentConfirmed,
  });

  @override
  State<_PaymentConfirmationView> createState() =>
      _PaymentConfirmationViewState();
}

class _PaymentConfirmationViewState extends State<_PaymentConfirmationView> {
  String? _currentUserId;
  PaymentCard? _selectedCard;
  PaymentProcessState _paymentState = PaymentProcessState.idle;
  String? _idempotencyKey;
  int _retryCount = 0;
  static const int _maxRetries = 3;
  static const Duration _paymentTimeout = Duration(seconds: 10);
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPaymentMethods();
    });
  }

  void _loadPaymentMethods() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _currentUserId = authState.user.id;
      context.read<PaymentBloc>().add(
            PaymentEvent.loadCards(userId: _currentUserId!),
          );
    }
  }

  void _showAddCardBottomSheet() {
    if (_currentUserId == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<PaymentBloc>(),
        child: AddCardBottomSheet(
          userId: _currentUserId!,
          onCardAdded: () {
            Navigator.pop(sheetContext);
            // Recargar tarjetas despues de agregar una nueva
            _loadPaymentMethods();
          },
        ),
      ),
    );
  }

  /// Genera una clave de idempotencia unica para el pago
  /// Previene cargos duplicados si el usuario presiona multiples veces
  String _generateIdempotencyKey() {
    if (_idempotencyKey != null) {
      return _idempotencyKey!;
    }
    _idempotencyKey = _uuid.v4();
    return _idempotencyKey!;
  }

  /// Procesa el pago con retry logic y timeout
  Future<void> _processPayment() async {
    if (_selectedCard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona un metodo de pago'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    // Evitar multiples intentos simultaneos
    if (_paymentState == PaymentProcessState.processing ||
        _paymentState == PaymentProcessState.pending) {
      debugPrint('[Payment] Ya hay un pago en proceso');
      return;
    }

    setState(() {
      _paymentState = PaymentProcessState.processing;
      _retryCount = 0;
    });

    await _attemptPayment();
  }

  /// Intenta procesar el pago con retry logic
  Future<void> _attemptPayment() async {
    try {
      final idempotencyKey = _generateIdempotencyKey();
      final stripeService = getIt<StripeBackendService>();

      debugPrint('[Payment] Intento ${_retryCount + 1}/$_maxRetries con idempotency key: $idempotencyKey');

      // Actualizar estado a pending antes de la llamada
      if (mounted) {
        setState(() {
          _paymentState = PaymentProcessState.pending;
        });
      }

      // Llamar al backend con timeout
      final result = await stripeService.processPayment(
        amount: widget.tripData.totalPrice,
        paymentMethodId:
            _selectedCard!.stripePaymentMethodId ?? _selectedCard!.id,
      ).timeout(
        _paymentTimeout,
        onTimeout: () {
          debugPrint('[Payment] Timeout despues de ${_paymentTimeout.inSeconds}s');
          throw TimeoutException('El pago tardo demasiado');
        },
      );

      if (!mounted) return;

      if (result.isSuccess && result.data != null) {
        if (result.data!.requiresAction && result.data!.clientSecret != null) {
          // Requiere 3D Secure - manejar autenticacion adicional
          setState(() {
            _paymentState = PaymentProcessState.failed;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Se requiere autenticacion adicional'),
              backgroundColor: AppTheme.warningColor,
            ),
          );
        } else if (result.data!.success) {
          // Pago exitoso
          setState(() {
            _paymentState = PaymentProcessState.completed;
          });
          _showPaymentSuccessAndConfirm();
        } else {
          // Pago fallido - intentar retry
          await _handlePaymentFailure('Pago rechazado: ${result.data!.status ?? "Desconocido"}');
        }
      } else {
        // Error del servidor - intentar retry
        await _handlePaymentFailure(result.error ?? 'Error procesando el pago');
      }
    } on TimeoutException catch (e) {
      if (!mounted) return;
      await _handlePaymentFailure('Timeout: ${e.message}');
    } catch (e) {
      if (!mounted) return;
      await _handlePaymentFailure('Error: ${e.toString()}');
    }
  }

  /// Maneja fallos de pago con retry logic exponencial
  Future<void> _handlePaymentFailure(String errorMessage) async {
    _retryCount++;

    if (_retryCount < _maxRetries) {
      // Calcular delay exponencial: 1s, 2s, 4s
      final delaySeconds = (1 << (_retryCount - 1));
      debugPrint('[Payment] Reintentando en ${delaySeconds}s...');

      setState(() {
        _paymentState = PaymentProcessState.processing;
      });

      // Mostrar mensaje de retry al usuario
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reintentando pago... (${_retryCount}/$_maxRetries)'),
            backgroundColor: AppTheme.warningColor,
            duration: Duration(seconds: delaySeconds),
          ),
        );
      }

      // Esperar antes de reintentar
      await Future.delayed(Duration(seconds: delaySeconds));

      if (mounted) {
        await _attemptPayment();
      }
    } else {
      // Max retries alcanzado - marcar como fallido
      debugPrint('[Payment] Max retries alcanzado');
      setState(() {
        _paymentState = PaymentProcessState.failed;
        _idempotencyKey = null; // Reset para permitir nuevo intento manual
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: AppTheme.errorColor,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _showPaymentSuccessAndConfirm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icono de exito
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppTheme.successColor,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pago confirmado',
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Se ha procesado el pago de \$${widget.tripData.totalPrice.toStringAsFixed(0)} MXN',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext); // Cierra el dialog
                    Navigator.pop(context); // Cierra la pagina de pago
                    widget.onPaymentConfirmed(); // Callback para crear el viaje
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryLightColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Buscar conductor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Confirmar pago',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
      ),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentLoaded && state.cards.isNotEmpty) {
            // Seleccionar la tarjeta por defecto automaticamente
            final defaultCard = state.cards.firstWhere(
              (card) => card.isDefault,
              orElse: () => state.cards.first,
            );
            setState(() {
              _selectedCard = defaultCard;
            });
          } else if (state is CardAdded && state.cards.isNotEmpty) {
            // Si se agrego una tarjeta nueva, seleccionarla
            final defaultCard = state.cards.firstWhere(
              (card) => card.isDefault,
              orElse: () => state.cards.first,
            );
            setState(() {
              _selectedCard = defaultCard;
            });
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Resumen del viaje
                  _buildTripSummary(),
                  const SizedBox(height: 24),

                  // Metodos de pago
                  const Text(
                    'Metodo de pago',
                    style: TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentMethods(state),
                  const SizedBox(height: 16),

                  // Agregar tarjeta
                  _buildAddCardButton(),
                  const SizedBox(height: 24),

                  // Desglose de precio
                  _buildPriceBreakdown(),
                  const SizedBox(height: 24),

                  // Boton confirmar pago
                  _buildConfirmButton(),
                  const SizedBox(height: 16),

                  // Nota de seguridad
                  _buildSecurityNote(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTripSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        children: [
          // Origen
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trip_origin,
                  color: AppTheme.successColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Origen',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      widget.tripData.originAddress,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Linea conectora
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Container(
              width: 2,
              height: 30,
              color: AppTheme.dividerColor,
            ),
          ),

          // Destino
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppTheme.errorColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Destino',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      widget.tripData.destinationAddress,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(height: 24, color: AppTheme.dividerColor),

          // Info del viaje
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.tripData.durationText != null)
                _buildInfoChip(
                  icon: Icons.access_time,
                  label: widget.tripData.durationText!,
                ),
              if (widget.tripData.estimatedDistanceKm != null)
                _buildInfoChip(
                  icon: Icons.straighten,
                  label:
                      '${widget.tripData.estimatedDistanceKm!.toStringAsFixed(1)} km',
                ),
              _buildInfoChip(
                icon: Icons.local_taxi,
                label: widget.tripData.serviceType.split('|').first.trim(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryLightColor, size: 16),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods(PaymentState state) {
    if (state is PaymentLoading || state is PaymentInitial) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final cards = _getCardsFromState(state);

    if (cards.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.dividerColor),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.credit_card_off,
              color: AppTheme.textSecondaryColor,
              size: 40,
            ),
            SizedBox(height: 12),
            Text(
              'No tienes tarjetas guardadas',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Agrega una tarjeta para continuar',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: cards.map((card) => _buildCardOption(card)).toList(),
    );
  }

  List<PaymentCard> _getCardsFromState(PaymentState state) {
    return switch (state) {
      PaymentLoaded(cards: final cards) => cards,
      CardAdded(cards: final cards) => cards,
      CardDeleted(cards: final cards) => cards,
      DefaultCardUpdated(cards: final cards) => cards,
      PaymentError(cards: final cards) => cards ?? [],
      _ => [],
    };
  }

  Widget _buildCardOption(PaymentCard card) {
    final isSelected = _selectedCard?.id == card.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCard = card;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryLightColor.withValues(alpha: 0.1)
              : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? AppTheme.primaryLightColor : AppTheme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppTheme.primaryLightColor
                  : AppTheme.textSecondaryColor,
            ),
            const SizedBox(width: 12),
            _buildCardIcon(card.cardType),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${card.cardTypeName} ****${card.lastFourDigits}',
                    style: TextStyle(
                      color: isSelected
                          ? AppTheme.primaryLightColor
                          : AppTheme.textPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Vence ${card.expiryDate}',
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (card.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Principal',
                  style: TextStyle(
                    color: AppTheme.successColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardIcon(CardType cardType) {
    Color bgColor;
    String label;

    switch (cardType) {
      case CardType.visa:
        bgColor = const Color(0xFF1A1F71);
        label = 'VISA';
        break;
      case CardType.mastercard:
        bgColor = const Color(0xFFEB001B);
        label = 'MC';
        break;
      case CardType.amex:
        bgColor = const Color(0xFF006FCF);
        label = 'AMEX';
        break;
      case CardType.carnet:
        bgColor = const Color(0xFF00529B);
        label = 'C';
        break;
      default:
        bgColor = AppTheme.cardColor;
        label = '';
    }

    return Container(
      width: 40,
      height: 28,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAddCardButton() {
    return GestureDetector(
      onTap: _showAddCardBottomSheet,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryLightColor.withValues(alpha: 0.5),
            style: BorderStyle.solid,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppTheme.primaryLightColor,
            ),
            SizedBox(width: 8),
            Text(
              'Agregar nueva tarjeta',
              style: TextStyle(
                color: AppTheme.primaryLightColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryLightColor.withValues(alpha: 0.1),
            AppTheme.primaryLightColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryLightColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Servicio',
                style: TextStyle(color: AppTheme.textSecondaryColor),
              ),
              Text(
                widget.tripData.serviceType.split('|').first.trim(),
                style: const TextStyle(color: AppTheme.textPrimaryColor),
              ),
            ],
          ),
          if (widget.tripData.estimatedDurationMinutes != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tiempo estimado',
                  style: TextStyle(color: AppTheme.textSecondaryColor),
                ),
                Text(
                  '${widget.tripData.estimatedDurationMinutes} min',
                  style: const TextStyle(color: AppTheme.textPrimaryColor),
                ),
              ],
            ),
          ],
          const Divider(height: 24, color: AppTheme.dividerColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total a pagar',
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${widget.tripData.totalPrice.toStringAsFixed(0)} MXN',
                style: const TextStyle(
                  color: AppTheme.primaryLightColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    final isProcessingOrPending = _paymentState == PaymentProcessState.processing ||
        _paymentState == PaymentProcessState.pending;
    final isFailed = _paymentState == PaymentProcessState.failed;
    final canPay = _selectedCard != null && !isProcessingOrPending;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canPay ? _processPayment : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFailed ? AppTheme.errorColor : AppTheme.primaryLightColor,
          disabledBackgroundColor: AppTheme.dividerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    switch (_paymentState) {
      case PaymentProcessState.processing:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _retryCount > 0
                  ? 'Reintentando... (${_retryCount}/$_maxRetries)'
                  : 'Procesando pago...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

      case PaymentProcessState.pending:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Confirmando pago...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

      case PaymentProcessState.completed:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Pago completado',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

      case PaymentProcessState.failed:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Reintentar pago',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

      case PaymentProcessState.idle:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              'Pagar \$${widget.tripData.totalPrice.toStringAsFixed(0)} MXN',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
    }
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.security,
            color: AppTheme.successColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Pago seguro. Tu informacion esta protegida con encriptacion de nivel bancario.',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
