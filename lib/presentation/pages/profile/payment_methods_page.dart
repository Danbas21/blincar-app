// lib/presentation/pages/profile/payment_methods_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/payment_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/payment/payment_bloc.dart';
import '../../bloc/payment/payment_event.dart';
import '../../bloc/payment/payment_state.dart';
import '../../widgets/common/custom_button.dart';

/// Pagina de Metodos de Pago
///
/// Funcionalidades:
/// - Listar tarjetas guardadas
/// - Agregar nueva tarjeta con deteccion automatica del tipo
/// - Establecer tarjeta por defecto
/// - Eliminar tarjetas
class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentBloc>(),
      child: const _PaymentMethodsView(),
    );
  }
}

class _PaymentMethodsView extends StatefulWidget {
  const _PaymentMethodsView();

  @override
  State<_PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<_PaymentMethodsView> {
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCards();
    });
  }

  void _loadCards() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _currentUserId = authState.user.id;
      context.read<PaymentBloc>().add(
            PaymentEvent.loadCards(userId: _currentUserId!),
          );
    }
  }

  void _showAddCardBottomSheet(BuildContext context) {
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
          },
        ),
      ),
    );
  }

  void _setDefaultCard(String cardId) {
    if (_currentUserId == null) return;
    context.read<PaymentBloc>().add(
          PaymentEvent.setDefaultCard(
            userId: _currentUserId!,
            cardId: cardId,
          ),
        );
  }

  void _deleteCard(PaymentCard card) {
    if (_currentUserId == null) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Eliminar tarjeta',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Text(
          'Esta seguro de eliminar la tarjeta terminada en ${card.lastFourDigits}?',
          style: const TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<PaymentBloc>().add(
                    PaymentEvent.deleteCard(
                      userId: _currentUserId!,
                      cardId: card.id,
                    ),
                  );
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is CardAdded) {
          _showSnackBar(context, state.message, isSuccess: true);
        } else if (state is CardDeleted) {
          _showSnackBar(context, state.message, isSuccess: true);
        } else if (state is DefaultCardUpdated) {
          _showSnackBar(context, state.message, isSuccess: true);
        } else if (state is PaymentError) {
          _showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: Text(l10n.paymentMethods),
            backgroundColor: AppTheme.backgroundColor,
            foregroundColor: AppTheme.textPrimaryColor,
            elevation: 0,
          ),
          body: _buildBody(state, l10n),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddCardBottomSheet(context),
            backgroundColor: AppTheme.primaryLightColor,
            icon: const Icon(Icons.add),
            label: const Text('Agregar tarjeta'),
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message,
      {required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor:
            isSuccess ? AppTheme.successColor : AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildBody(PaymentState state, AppLocalizations l10n) {
    return switch (state) {
      PaymentInitial() => const Center(child: CircularProgressIndicator()),
      PaymentLoading() => const Center(child: CircularProgressIndicator()),
      PaymentLoaded(cards: final cards) => _buildContent(cards, l10n),
      CardAdded(cards: final cards) => _buildContent(cards, l10n),
      CardDeleted(cards: final cards) => _buildContent(cards, l10n),
      DefaultCardUpdated(cards: final cards) => _buildContent(cards, l10n),
      PaymentError(cards: final cards) => _buildContent(cards ?? [], l10n),
    };
  }

  Widget _buildContent(List<PaymentCard> cards, AppLocalizations l10n) {
    if (cards.isEmpty) {
      return _buildEmptyState(l10n);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSecurityInfo(),
          const SizedBox(height: 24),
          const Text(
            'Tarjetas guardadas',
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...cards.map((card) => _buildCardItem(card)),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.credit_card_off,
                size: 64,
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sin metodos de pago',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Agrega una tarjeta para poder pagar tus viajes de forma rapida y segura',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Agregar mi primera tarjeta',
              onPressed: () => _showAddCardBottomSheet(context),
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.successColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.lock,
              color: AppTheme.successColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pagos seguros',
                  style: TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tu informacion esta protegida con encriptacion de nivel bancario',
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
    );
  }

  Widget _buildCardItem(PaymentCard card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: card.isDefault
            ? Border.all(color: AppTheme.primaryLightColor, width: 2)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildCardIcon(card.cardType),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        card.cardTypeName,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (card.isDefault) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryLightColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Principal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '**** **** **** ${card.lastFourDigits}',
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Expira ${card.expiryDate}',
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: AppTheme.textSecondaryColor,
              ),
              color: AppTheme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 'default') {
                  _setDefaultCard(card.id);
                } else if (value == 'delete') {
                  _deleteCard(card);
                }
              },
              itemBuilder: (context) => [
                if (!card.isDefault)
                  const PopupMenuItem(
                    value: 'default',
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppTheme.primaryLightColor,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Establecer como principal',
                          style: TextStyle(color: AppTheme.textPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: AppTheme.errorColor,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Eliminar',
                        style: TextStyle(color: AppTheme.errorColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardIcon(CardType cardType) {
    return Container(
      width: 56,
      height: 40,
      decoration: BoxDecoration(
        color: _getCardBackgroundColor(cardType),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: _getCardIconWidget(cardType),
      ),
    );
  }

  Color _getCardBackgroundColor(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
        return const Color(0xFF1A1F71);
      case CardType.mastercard:
        return const Color(0xFFEB001B);
      case CardType.carnet:
        return const Color(0xFF00529B);
      case CardType.amex:
        return const Color(0xFF006FCF);
      case CardType.unknown:
        return AppTheme.cardColor;
    }
  }

  Widget _getCardIconWidget(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
        return const Text(
          'VISA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        );
      case CardType.mastercard:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
            Transform.translate(
              offset: const Offset(-6, 0),
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFFF79E1B),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
              ),
            ),
          ],
        );
      case CardType.carnet:
        return const Text(
          'CARNET',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case CardType.amex:
        return const Text(
          'AMEX',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        );
      case CardType.unknown:
        return const Icon(
          Icons.credit_card,
          color: AppTheme.textSecondaryColor,
          size: 24,
        );
    }
  }
}

/// Bottom Sheet para agregar una nueva tarjeta
class AddCardBottomSheet extends StatefulWidget {
  final String userId;
  final VoidCallback onCardAdded;

  const AddCardBottomSheet({
    super.key,
    required this.userId,
    required this.onCardAdded,
  });

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  CardType _detectedCardType = CardType.unknown;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_onCardNumberChanged);
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onCardNumberChanged() {
    final cardNumber = _cardNumberController.text;
    final detectedType = CardTypeDetector.detectCardType(cardNumber);

    if (detectedType != _detectedCardType) {
      setState(() {
        _detectedCardType = detectedType;
      });
    }
  }

  void _submitCard() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final cardNumber = _cardNumberController.text.replaceAll(' ', '');
    final expiry = _expiryController.text.split('/');

    // Guardar los ultimos 4 digitos antes de limpiar
    _lastFourDigits = cardNumber.substring(cardNumber.length - 4);

    context.read<PaymentBloc>().add(
          PaymentEvent.addCard(
            userId: widget.userId,
            cardNumber: cardNumber,
            expiryMonth: expiry[0],
            expiryYear: expiry[1],
            cvv: _cvvController.text,
            cardHolderName: _cardHolderController.text.trim(),
          ),
        );
  }

  // Guardar los ultimos 4 digitos para mostrar en el popup
  String _lastFourDigits = '';

  void _showSuccessDialog() {
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
              // Icono de exito animado
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
                'Tarjeta agregada',
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tu tarjeta terminada en $_lastFourDigits ha sido agregada exitosamente.',
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
                    widget.onCardAdded(); // Cierra el bottom sheet
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
                    'Continuar',
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
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is CardAdded) {
          setState(() {
            _isSubmitting = false;
          });
          _showSuccessDialog();
        } else if (state is PaymentError) {
          setState(() {
            _isSubmitting = false;
          });
          // El error se muestra via el listener en el parent
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color:
                            AppTheme.textSecondaryColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: AppTheme.primaryLightColor,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Agregar tarjeta',
                        style: TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildCardPreview(),
                  const SizedBox(height: 24),
                  _buildCardNumberField(),
                  const SizedBox(height: 16),
                  _buildCardHolderField(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildExpiryField()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildCVVField()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSecurityNote(),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Agregar tarjeta',
                    onPressed: _isSubmitting ? null : _submitCard,
                    isLoading: _isSubmitting,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getCardGradient(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getCardGradient().first.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.contactless,
                      color: Colors.white,
                      size: 32,
                    ),
                    _buildCardTypeIcon(),
                  ],
                ),
                const Spacer(),
                Text(
                  CardTypeDetector.formatCardNumber(
                    _cardNumberController.text.isEmpty
                        ? '0000000000000000'
                        : _cardNumberController.text,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'monospace',
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TITULAR',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _cardHolderController.text.isEmpty
                              ? 'NOMBRE APELLIDO'
                              : _cardHolderController.text.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'VENCE',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _expiryController.text.isEmpty
                              ? 'MM/YY'
                              : _expiryController.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getCardGradient() {
    switch (_detectedCardType) {
      case CardType.visa:
        return [const Color(0xFF1A1F71), const Color(0xFF0B1350)];
      case CardType.mastercard:
        return [const Color(0xFFFF5F00), const Color(0xFFEB001B)];
      case CardType.carnet:
        return [const Color(0xFF00529B), const Color(0xFF003D75)];
      case CardType.amex:
        return [const Color(0xFF006FCF), const Color(0xFF00498A)];
      case CardType.unknown:
        return [AppTheme.surfaceColor, AppTheme.cardColor];
    }
  }

  Widget _buildCardTypeIcon() {
    switch (_detectedCardType) {
      case CardType.visa:
        return const Text(
          'VISA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        );
      case CardType.mastercard:
        return Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
            Transform.translate(
              offset: const Offset(-12, 0),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFF79E1B),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
          ],
        );
      case CardType.carnet:
        return const Text(
          'CARNET',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
      case CardType.amex:
        return const Text(
          'AMEX',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      case CardType.unknown:
        return const Icon(
          Icons.credit_card,
          color: Colors.white,
          size: 32,
        );
    }
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: AppTheme.textPrimaryColor),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        _CardNumberInputFormatter(),
      ],
      decoration: InputDecoration(
        labelText: 'Numero de tarjeta',
        labelStyle: const TextStyle(color: AppTheme.textSecondaryColor),
        hintText: '0000 0000 0000 0000',
        hintStyle: TextStyle(
          color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: _buildSmallCardIcon(),
        ),
        filled: true,
        fillColor: AppTheme.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.primaryLightColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.errorColor,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingresa el numero de tarjeta';
        }
        final cleanNumber = value.replaceAll(' ', '');
        if (cleanNumber.length < 13) {
          return 'Numero de tarjeta invalido';
        }
        if (!CardTypeDetector.isValidCardNumber(cleanNumber)) {
          return 'Numero de tarjeta invalido';
        }
        return null;
      },
    );
  }

  Widget _buildSmallCardIcon() {
    if (_detectedCardType == CardType.unknown) {
      return const Icon(
        Icons.credit_card,
        color: AppTheme.textSecondaryColor,
      );
    }

    return Container(
      width: 32,
      height: 24,
      decoration: BoxDecoration(
        color: _getCardGradient().first,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: _detectedCardType == CardType.mastercard
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEB001B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-4, 0),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF79E1B),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                _detectedCardType == CardType.visa
                    ? 'V'
                    : _detectedCardType == CardType.carnet
                        ? 'C'
                        : 'A',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildCardHolderField() {
    return TextFormField(
      controller: _cardHolderController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.characters,
      style: const TextStyle(color: AppTheme.textPrimaryColor),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: 'Nombre del titular',
        labelStyle: const TextStyle(color: AppTheme.textSecondaryColor),
        hintText: 'NOMBRE COMO APARECE EN LA TARJETA',
        hintStyle: TextStyle(
          color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
        ),
        prefixIcon: const Icon(
          Icons.person_outline,
          color: AppTheme.primaryLightColor,
        ),
        filled: true,
        fillColor: AppTheme.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.primaryLightColor,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Ingresa el nombre del titular';
        }
        if (value.trim().length < 3) {
          return 'Nombre demasiado corto';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryField() {
    return TextFormField(
      controller: _expiryController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: AppTheme.textPrimaryColor),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        _ExpiryDateInputFormatter(),
      ],
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: 'Vencimiento',
        labelStyle: const TextStyle(color: AppTheme.textSecondaryColor),
        hintText: 'MM/YY',
        hintStyle: TextStyle(
          color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
        ),
        prefixIcon: const Icon(
          Icons.calendar_today,
          color: AppTheme.primaryLightColor,
        ),
        filled: true,
        fillColor: AppTheme.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.primaryLightColor,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Requerido';
        }
        final parts = value.split('/');
        if (parts.length != 2) {
          return 'Formato invalido';
        }
        if (!CardTypeDetector.isValidExpiry(parts[0], parts[1])) {
          return 'Tarjeta expirada';
        }
        return null;
      },
    );
  }

  Widget _buildCVVField() {
    return TextFormField(
      controller: _cvvController,
      keyboardType: TextInputType.number,
      obscureText: true,
      style: const TextStyle(color: AppTheme.textPrimaryColor),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(
          _detectedCardType == CardType.amex ? 4 : 3,
        ),
      ],
      decoration: InputDecoration(
        labelText: 'CVV',
        labelStyle: const TextStyle(color: AppTheme.textSecondaryColor),
        hintText: _detectedCardType == CardType.amex ? '****' : '***',
        hintStyle: TextStyle(
          color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppTheme.primaryLightColor,
        ),
        filled: true,
        fillColor: AppTheme.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.primaryLightColor,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Requerido';
        }
        if (!CardTypeDetector.isValidCVV(value, _detectedCardType)) {
          return 'CVV invalido';
        }
        return null;
      },
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.security,
            color: AppTheme.successColor,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tu informacion esta encriptada y segura. No almacenamos el CVV.',
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

/// Formateador para el numero de tarjeta (agrega espacios cada 4 digitos)
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Formateador para la fecha de expiracion (MM/YY)
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length && i < 4; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
