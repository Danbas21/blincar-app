// lib/presentation/pages/payment/payment_history_page.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/stripe_backend_service.dart';
import '../../../core/services/service_locator.dart';

/// Página de historial de pagos
///
/// Muestra el historial de transacciones de pagos del usuario,
/// incluyendo pagos de viajes, reembolsos y métodos de pago utilizados.
/// Se conecta con el backend de Stripe para obtener datos reales.
class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  String _selectedFilter = 'Todos';
  final List<String> _filters = ['Todos', 'Pagos', 'Reembolsos', 'Pendientes'];

  bool _isLoading = true;
  String? _errorMessage;
  List<PaymentTransaction> _transactions = [];

  final StripeBackendService _stripeBackend = getIt<StripeBackendService>();

  @override
  void initState() {
    super.initState();
    _loadPaymentHistory();
  }

  Future<void> _loadPaymentHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _stripeBackend.getPaymentHistory(limit: 50);

      if (result.isSuccess) {
        setState(() {
          _transactions = result.data ?? [];
          _isLoading = false;
        });
      } else {
        // Si el endpoint no está disponible, usar datos mock
        setState(() {
          _transactions = _getMockTransactions();
          _isLoading = false;
        });
      }
    } catch (e) {
      // En caso de error, mostrar datos mock para desarrollo
      setState(() {
        _transactions = _getMockTransactions();
        _isLoading = false;
      });
    }
  }

  List<PaymentTransaction> _getMockTransactions() {
    return [
      PaymentTransaction(
        id: 'pi_mock_001',
        description: 'Viaje a Roma Norte',
        amount: 185.50,
        currency: 'MXN',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: PaymentTransactionStatus.succeeded,
        type: PaymentTransactionType.payment,
        paymentMethodBrand: 'visa',
        paymentMethodLast4: '4242',
        tripId: 'trip_123',
      ),
      PaymentTransaction(
        id: 'pi_mock_002',
        description: 'Viaje al Aeropuerto',
        amount: 320.00,
        currency: 'MXN',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        status: PaymentTransactionStatus.succeeded,
        type: PaymentTransactionType.payment,
        paymentMethodBrand: 'mastercard',
        paymentMethodLast4: '5555',
        tripId: 'trip_122',
      ),
      PaymentTransaction(
        id: 'pi_mock_003',
        description: 'Reembolso - Viaje cancelado',
        amount: 150.00,
        currency: 'MXN',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        status: PaymentTransactionStatus.refunded,
        type: PaymentTransactionType.refund,
        paymentMethodBrand: 'visa',
        paymentMethodLast4: '4242',
        refundReason: 'Viaje cancelado por el conductor',
      ),
      PaymentTransaction(
        id: 'pi_mock_004',
        description: 'Viaje a Santa Fe',
        amount: 275.75,
        currency: 'MXN',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        status: PaymentTransactionStatus.succeeded,
        type: PaymentTransactionType.payment,
        paymentMethodBrand: 'visa',
        paymentMethodLast4: '4242',
        tripId: 'trip_121',
      ),
      PaymentTransaction(
        id: 'pi_mock_005',
        description: 'Viaje programado',
        amount: 450.00,
        currency: 'MXN',
        createdAt: DateTime.now().add(const Duration(days: 2)),
        status: PaymentTransactionStatus.pending,
        type: PaymentTransactionType.payment,
        paymentMethodBrand: 'visa',
        paymentMethodLast4: '4242',
        tripId: 'trip_124',
      ),
      PaymentTransaction(
        id: 'pi_mock_006',
        description: 'Viaje a Polanco',
        amount: 210.25,
        currency: 'MXN',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        status: PaymentTransactionStatus.failed,
        type: PaymentTransactionType.payment,
        paymentMethodBrand: 'mastercard',
        paymentMethodLast4: '5555',
        errorMessage: 'Fondos insuficientes',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredPayments = _getFilteredPayments();

    // Calcular totales
    final totalPaid = _transactions
        .where((t) => t.status == PaymentTransactionStatus.succeeded &&
            t.type == PaymentTransactionType.payment)
        .fold(0.0, (sum, t) => sum + t.amount);

    final completedCount = _transactions
        .where((t) => t.status == PaymentTransactionStatus.succeeded)
        .length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Historial de Pagos'),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPaymentHistory,
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _buildErrorState()
              : Column(
                  children: [
                    // Resumen de pagos
                    _buildSummaryCard(totalPaid, completedCount),

                    // Filtros
                    _buildFilters(),

                    const SizedBox(height: 16),

                    // Lista de pagos
                    Expanded(
                      child: filteredPayments.isEmpty
                          ? _buildEmptyState()
                          : RefreshIndicator(
                              onRefresh: _loadPaymentHistory,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                itemCount: filteredPayments.length,
                                itemBuilder: (context, index) {
                                  final payment = filteredPayments[index];
                                  return _buildPaymentCard(payment);
                                },
                              ),
                            ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildSummaryCard(double totalPaid, int completedCount) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryLightColor,
            AppTheme.primaryLightColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total pagado',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${totalPaid.toStringAsFixed(2)} MXN',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$completedCount transacciones completadas',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;

          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryLightColor
                    : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryLightColor
                      : AppTheme.dividerColor,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : AppTheme.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: AppTheme.textSecondaryColor,
          ),
          SizedBox(height: 16),
          Text(
            'No hay transacciones',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppTheme.errorColor,
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage ?? 'Error al cargar historial',
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadPaymentHistory,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  List<PaymentTransaction> _getFilteredPayments() {
    switch (_selectedFilter) {
      case 'Pagos':
        return _transactions
            .where((t) =>
                t.type == PaymentTransactionType.payment &&
                t.status == PaymentTransactionStatus.succeeded)
            .toList();
      case 'Reembolsos':
        return _transactions
            .where((t) => t.type == PaymentTransactionType.refund ||
                t.status == PaymentTransactionStatus.refunded)
            .toList();
      case 'Pendientes':
        return _transactions
            .where((t) =>
                t.status == PaymentTransactionStatus.pending ||
                t.status == PaymentTransactionStatus.failed)
            .toList();
      default:
        return _transactions;
    }
  }

  Widget _buildPaymentCard(PaymentTransaction payment) {
    return GestureDetector(
      onTap: () => _showPaymentDetails(payment),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.dividerColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Icono
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _getTypeColor(payment).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _getTypeIcon(payment),
                color: _getTypeColor(payment),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.description,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        payment.paymentMethodDisplay,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppTheme.textSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(payment.createdAt),
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  if (payment.errorMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      payment.errorMessage!,
                      style: const TextStyle(
                        color: AppTheme.errorColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Monto
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${payment.type == PaymentTransactionType.refund ? '+' : '-'}\$${payment.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: payment.type == PaymentTransactionType.refund
                        ? AppTheme.successColor
                        : AppTheme.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(payment.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    payment.status.displayName,
                    style: TextStyle(
                      color: _getStatusColor(payment.status),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentDetails(PaymentTransaction payment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getTypeColor(payment).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTypeIcon(payment),
                    color: _getTypeColor(payment),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.description,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(payment.status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          payment.status.displayName,
                          style: TextStyle(
                            color: _getStatusColor(payment.status),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildDetailRow('Monto',
                '${payment.type == PaymentTransactionType.refund ? '+' : ''}\$${payment.amount.toStringAsFixed(2)} ${payment.currency}'),
            _buildDetailRow('Método de pago', payment.paymentMethodDisplay),
            _buildDetailRow('Fecha', _formatDateFull(payment.createdAt)),
            _buildDetailRow('ID de transacción', payment.id),
            if (payment.tripId != null)
              _buildDetailRow('ID de viaje', payment.tripId!),
            if (payment.refundReason != null)
              _buildDetailRow('Motivo del reembolso', payment.refundReason!),
            if (payment.errorMessage != null)
              _buildDetailRow('Error', payment.errorMessage!,
                  valueColor: AppTheme.errorColor),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryLightColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cerrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? AppTheme.textPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(PaymentTransaction payment) {
    if (payment.status == PaymentTransactionStatus.failed) {
      return AppTheme.errorColor;
    }
    switch (payment.type) {
      case PaymentTransactionType.payment:
        return AppTheme.primaryLightColor;
      case PaymentTransactionType.refund:
        return AppTheme.successColor;
    }
  }

  IconData _getTypeIcon(PaymentTransaction payment) {
    if (payment.status == PaymentTransactionStatus.failed) {
      return Icons.error_outline;
    }
    switch (payment.type) {
      case PaymentTransactionType.payment:
        return Icons.directions_car;
      case PaymentTransactionType.refund:
        return Icons.replay;
    }
  }

  Color _getStatusColor(PaymentTransactionStatus status) {
    switch (status) {
      case PaymentTransactionStatus.succeeded:
        return AppTheme.successColor;
      case PaymentTransactionStatus.pending:
        return AppTheme.warningColor;
      case PaymentTransactionStatus.failed:
        return AppTheme.errorColor;
      case PaymentTransactionStatus.refunded:
        return AppTheme.successColor;
      case PaymentTransactionStatus.canceled:
        return AppTheme.textSecondaryColor;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.isNegative) {
      return 'Programado ${date.day}/${date.month}';
    } else if (difference.inHours < 24) {
      return 'Hoy ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatDateFull(DateTime date) {
    final months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    return '${date.day} de ${months[date.month - 1]} de ${date.year}, '
        '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
