// lib/presentation/pages/legal/terms_conditions_page.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Página de Términos y Condiciones
///
/// Muestra los términos de uso del servicio Blincar de forma clara
/// y estructurada. Incluye información sobre el servicio, obligaciones
/// del usuario, pagos, cancelaciones y limitaciones de responsabilidad.
class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  /// Muestra los términos como un modal
  static Future<void> showAsModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.dividerColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.gavel, color: AppTheme.primaryLightColor),
                        SizedBox(width: 12),
                        Text(
                          'Términos y Condiciones',
                          style: TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: const _TermsContent(),
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
        title: const Text('Términos y Condiciones'),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: _TermsContent(),
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  const _TermsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLastUpdated(),
        const SizedBox(height: 24),
        _buildIntro(),
        const SizedBox(height: 24),
        _buildSection('1. Aceptación de los Términos', _buildAcceptanceContent()),
        _buildSection('2. Descripción del Servicio', _buildServiceContent()),
        _buildSection('3. Requisitos de Usuario', _buildUserRequirementsContent()),
        _buildSection('4. Solicitud de Viajes', _buildTripRequestContent()),
        _buildSection('5. Pagos y Tarifas', _buildPaymentsContent()),
        _buildSection('6. Cancelaciones', _buildCancellationsContent()),
        _buildSection('7. Conducta del Usuario', _buildConductContent()),
        _buildSection('8. Seguridad', _buildSafetyContent()),
        _buildSection('9. Propiedad Intelectual', _buildIntellectualPropertyContent()),
        _buildSection('10. Limitación de Responsabilidad', _buildLiabilityContent()),
        _buildSection('11. Modificaciones', _buildModificationsContent()),
        _buildSection('12. Ley Aplicable', _buildGoverningLawContent()),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildLastUpdated() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Última actualización: 15 de enero de 2026',
        style: TextStyle(
          color: AppTheme.primaryLightColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warningColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.warningColor.withValues(alpha: 0.3),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: AppTheme.warningColor),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Por favor lee estos términos cuidadosamente antes de usar Blincar. '
              'Al utilizar nuestros servicios, aceptas estos términos en su totalidad.',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildAcceptanceContent() {
    return const Text(
      'Al crear una cuenta o utilizar la aplicación Blincar, aceptas estar '
      'legalmente vinculado por estos Términos y Condiciones, nuestra Política '
      'de Privacidad y cualquier término adicional que aplique a características '
      'específicas del servicio. Si no estás de acuerdo con alguno de estos '
      'términos, no debes usar la aplicación.',
      style: TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildServiceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Blincar es una plataforma tecnológica que conecta a usuarios con '
          'conductores profesionales de transporte ejecutivo. Ofrecemos:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        _buildBulletPoint('Servicio de transporte ejecutivo premium'),
        _buildBulletPoint('Viajes programados y bajo demanda'),
        _buildBulletPoint('Seguimiento en tiempo real'),
        _buildBulletPoint('Pagos seguros a través de la aplicación'),
        _buildBulletPoint('Soporte al cliente 24/7'),
        const SizedBox(height: 12),
        const Text(
          'Blincar actúa como intermediario tecnológico y no es una empresa de '
          'transporte. Los conductores son prestadores de servicios independientes.',
          style: TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildUserRequirementsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Para usar Blincar, debes:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('Tener al menos 18 años de edad'),
        _buildBulletPoint('Proporcionar información veraz y actualizada'),
        _buildBulletPoint('Mantener la confidencialidad de tu cuenta'),
        _buildBulletPoint('Tener un método de pago válido'),
        _buildBulletPoint('Aceptar estos términos y nuestra política de privacidad'),
      ],
    );
  }

  Widget _buildTripRequestContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Las tarifas se calculan antes del viaje y pueden variar según '
          'demanda, distancia y tiempo.',
        ),
        _buildBulletPoint(
          'Debes estar en el punto de recogida indicado. Se cobra tiempo de '
          'espera después de 5 minutos.',
        ),
        _buildBulletPoint(
          'El conductor puede cancelar si no te presentas en 10 minutos, '
          'cobrándose una tarifa de cancelación.',
        ),
        _buildBulletPoint(
          'Cambios de destino durante el viaje pueden modificar la tarifa final.',
        ),
      ],
    );
  }

  Widget _buildPaymentsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Los pagos se procesan automáticamente al finalizar el viaje.',
        ),
        _buildBulletPoint(
          'Aceptamos tarjetas de crédito y débito a través de Stripe.',
        ),
        _buildBulletPoint(
          'Las tarifas incluyen IVA cuando aplique.',
        ),
        _buildBulletPoint(
          'Puedes solicitar factura a través de la aplicación.',
        ),
        _buildBulletPoint(
          'Las propinas son opcionales y van directamente al conductor.',
        ),
        const SizedBox(height: 12),
        _buildHighlightBox(
          'Los cargos adicionales por peajes, estacionamiento o '
          'solicitudes especiales se agregarán a la tarifa base.',
          Icons.attach_money,
          AppTheme.warningColor,
        ),
      ],
    );
  }

  Widget _buildCancellationsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Política de cancelación:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildCancellationItem(
          'Cancelación gratuita',
          'Dentro de los primeros 2 minutos de solicitar el viaje',
          AppTheme.successColor,
        ),
        _buildCancellationItem(
          'Cargo por cancelación',
          'Después de 2 minutos o si el conductor ya está en camino',
          AppTheme.warningColor,
        ),
        _buildCancellationItem(
          'Cargo completo',
          'No presentarse al viaje (no-show)',
          AppTheme.errorColor,
        ),
      ],
    );
  }

  Widget _buildConductContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Al usar Blincar, te comprometes a:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('Tratar a los conductores con respeto'),
        _buildBulletPoint('No transportar materiales ilegales o peligrosos'),
        _buildBulletPoint('No fumar ni consumir alcohol dentro del vehículo'),
        _buildBulletPoint('No dañar el vehículo ni sus accesorios'),
        _buildBulletPoint('Usar el cinturón de seguridad durante el viaje'),
        _buildBulletPoint('No solicitar al conductor violar las leyes de tránsito'),
        const SizedBox(height: 12),
        _buildHighlightBox(
          'El incumplimiento de estas normas puede resultar en la '
          'suspensión o cancelación permanente de tu cuenta.',
          Icons.warning,
          AppTheme.errorColor,
        ),
      ],
    );
  }

  Widget _buildSafetyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Todos los conductores pasan por verificación de antecedentes.',
        ),
        _buildBulletPoint(
          'Los vehículos son inspeccionados regularmente.',
        ),
        _buildBulletPoint(
          'La función de Botón de Pánico envía tu ubicación a emergencias.',
        ),
        _buildBulletPoint(
          'Puedes compartir tu viaje en tiempo real con contactos de emergencia.',
        ),
        _buildBulletPoint(
          'El soporte está disponible 24/7 para emergencias.',
        ),
      ],
    );
  }

  Widget _buildIntellectualPropertyContent() {
    return const Text(
      'La aplicación Blincar, incluyendo su diseño, logos, textos, gráficos '
      'y software, son propiedad de Blincar o sus licenciantes y están '
      'protegidos por las leyes de propiedad intelectual. No puedes copiar, '
      'modificar, distribuir o crear obras derivadas sin autorización expresa.',
      style: TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildLiabilityContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Blincar proporciona la plataforma tecnológica "tal cual". No garantizamos '
          'la disponibilidad ininterrumpida del servicio. En la medida permitida '
          'por la ley, Blincar no será responsable por:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        _buildBulletPoint('Retrasos o cancelaciones de viajes'),
        _buildBulletPoint('Acciones de conductores independientes'),
        _buildBulletPoint('Pérdida de objetos personales'),
        _buildBulletPoint('Daños indirectos o consecuentes'),
      ],
    );
  }

  Widget _buildModificationsContent() {
    return const Text(
      'Blincar puede modificar estos términos en cualquier momento. Te '
      'notificaremos sobre cambios significativos con al menos 30 días de '
      'anticipación. El uso continuado del servicio después de las '
      'modificaciones constituye tu aceptación de los nuevos términos.',
      style: TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildGoverningLawContent() {
    return const Text(
      'Estos términos se rigen por las leyes de los Estados Unidos Mexicanos. '
      'Cualquier disputa será resuelta en los tribunales competentes de la '
      'Ciudad de México, renunciando a cualquier otro fuero que pudiera '
      'corresponder por razón de domicilio.',
      style: TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(
              Icons.circle,
              size: 6,
              color: AppTheme.primaryLightColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationItem(String title, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
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

  Widget _buildHighlightBox(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
