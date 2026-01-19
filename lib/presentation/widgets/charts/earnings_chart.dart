import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/mock/mock_data.dart';

class EarningsChart extends StatelessWidget {
  final List<DailyEarning> data;

  const EarningsChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text(
          'No hay datos disponibles',
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
      );
    }

    final maxAmount = data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    final minAmount = data.map((e) => e.amount).reduce((a, b) => a < b ? a : b);

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: data.map((earning) {
              final heightPercent =
                  (earning.amount - minAmount) / (maxAmount - minAmount);
              final barHeight = (heightPercent * 200).clamp(20.0, 200.0);

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Valor
                      Text(
                        '\$${earning.amount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Barra
                      Container(
                        width: double.infinity,
                        height: barHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppTheme.primaryLightColor,
                              AppTheme.primaryLightColor.withOpacity(0.7),
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Día
                      Text(
                        _getDayLabel(earning.date),
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _getDayLabel(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Hoy';
    if (difference == 1) return 'Ayer';

    const days = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];
    return days[date.weekday % 7];
  }
}
