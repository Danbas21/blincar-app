// lib/presentation/pages/legal/privacy_policy_page.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';

/// Página de Política de Privacidad
///
/// Muestra la política de privacidad de Blincar de forma clara y organizada.
/// Incluye secciones sobre recopilación de datos, uso, compartición,
/// derechos del usuario y contacto.
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  /// Muestra la política de privacidad como un modal
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
                        Icon(Icons.privacy_tip, color: AppTheme.primaryLightColor),
                        SizedBox(width: 12),
                        Text(
                          'Política de Privacidad',
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
                  child: const _PrivacyContent(),
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
        title: const Text('Política de Privacidad'),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _sharePolicy(context),
            tooltip: 'Compartir',
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: _PrivacyContent(),
      ),
    );
  }

  void _sharePolicy(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compartir política de privacidad')),
    );
  }
}

class _PrivacyContent extends StatelessWidget {
  const _PrivacyContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLastUpdated(),
        const SizedBox(height: 24),
        _buildIntro(),
        const SizedBox(height: 24),
        _buildSection(
          '1. Información que Recopilamos',
          _buildDataCollectionContent(),
        ),
        _buildSection(
          '2. Cómo Usamos tu Información',
          _buildDataUsageContent(),
        ),
        _buildSection(
          '3. Compartición de Información',
          _buildDataSharingContent(),
        ),
        _buildSection(
          '4. Seguridad de los Datos',
          _buildSecurityContent(),
        ),
        _buildSection(
          '5. Tus Derechos',
          _buildUserRightsContent(),
        ),
        _buildSection(
          '6. Retención de Datos',
          _buildRetentionContent(),
        ),
        _buildSection(
          '7. Cambios a esta Política',
          _buildChangesContent(),
        ),
        _buildSection(
          '8. Contacto',
          _buildContactContent(context),
        ),
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
    return const Text(
      'En Blincar, nos tomamos muy en serio la privacidad de nuestros usuarios. '
      'Esta política describe cómo recopilamos, usamos y protegemos tu información '
      'personal cuando utilizas nuestros servicios de transporte ejecutivo.',
      style: TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 15,
        height: 1.6,
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

  Widget _buildDataCollectionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint('Información de cuenta: nombre, correo electrónico, número de teléfono'),
        _buildBulletPoint('Información de perfil: foto, contacto de emergencia'),
        _buildBulletPoint('Ubicación: datos GPS durante los viajes para seguimiento'),
        _buildBulletPoint('Información de pago: tarjetas guardadas de forma segura con Stripe'),
        _buildBulletPoint('Historial de viajes: origen, destino, fecha, costo'),
        _buildBulletPoint('Documentos: identificación oficial cuando sea requerida'),
        _buildBulletPoint('Comunicaciones: mensajes con conductores y soporte'),
      ],
    );
  }

  Widget _buildDataUsageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint('Proporcionar y mejorar nuestros servicios de transporte'),
        _buildBulletPoint('Procesar pagos y enviar recibos'),
        _buildBulletPoint('Comunicarnos contigo sobre tus viajes'),
        _buildBulletPoint('Garantizar tu seguridad y la de nuestros conductores'),
        _buildBulletPoint('Responder a emergencias y alertas de pánico'),
        _buildBulletPoint('Prevenir fraudes y actividades ilícitas'),
        _buildBulletPoint('Cumplir con obligaciones legales'),
      ],
    );
  }

  Widget _buildDataSharingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compartimos tu información únicamente con:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('Conductores: nombre y ubicación durante el viaje'),
        _buildBulletPoint('Procesadores de pago: Stripe para transacciones seguras'),
        _buildBulletPoint('Servicios de emergencia: en caso de alertas de pánico'),
        _buildBulletPoint('Autoridades: cuando sea requerido por ley'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle, color: AppTheme.successColor, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Nunca vendemos tu información personal a terceros',
                  style: TextStyle(
                    color: AppTheme.successColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint('Encriptación SSL/TLS para todas las comunicaciones'),
        _buildBulletPoint('Almacenamiento seguro con Firebase y Stripe'),
        _buildBulletPoint('Autenticación de dos factores disponible'),
        _buildBulletPoint('Auditorías de seguridad periódicas'),
        _buildBulletPoint('Acceso restringido a datos personales'),
      ],
    );
  }

  Widget _buildUserRightsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tienes derecho a:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint('Acceder a tu información personal'),
        _buildBulletPoint('Rectificar datos incorrectos'),
        _buildBulletPoint('Solicitar la eliminación de tu cuenta'),
        _buildBulletPoint('Exportar tus datos en formato legible'),
        _buildBulletPoint('Oponerte al procesamiento de tus datos'),
        _buildBulletPoint('Retirar tu consentimiento en cualquier momento'),
      ],
    );
  }

  Widget _buildRetentionContent() {
    return const Text(
      'Conservamos tu información mientras mantengas tu cuenta activa o según '
      'sea necesario para proporcionarte servicios. Después de eliminar tu cuenta, '
      'mantenemos ciertos datos durante el período requerido por ley (generalmente '
      '5 años para información fiscal). Los datos de ubicación de viajes se '
      'anonimizan después de 2 años.',
      style: TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildChangesContent() {
    return const Text(
      'Podemos actualizar esta política ocasionalmente. Te notificaremos sobre '
      'cambios significativos a través de la aplicación o por correo electrónico. '
      'El uso continuado de nuestros servicios después de los cambios constituye '
      'tu aceptación de la política actualizada.',
      style: TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildContactContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Si tienes preguntas sobre esta política de privacidad, contáctanos:',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          Icons.email,
          'Correo electrónico',
          'privacidad@blincar.com',
          () => _launchEmail('privacidad@blincar.com'),
        ),
        const SizedBox(height: 8),
        _buildContactCard(
          Icons.phone,
          'Teléfono',
          '+52 55 1234 5678',
          () => _launchPhone('+525512345678'),
        ),
        const SizedBox(height: 8),
        _buildContactCard(
          Icons.location_on,
          'Dirección',
          'Av. Paseo de la Reforma 123\nCol. Juárez, CDMX',
          null,
        ),
      ],
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

  Widget _buildContactCard(
    IconData icon,
    String title,
    String value,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryLightColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.chevron_right,
                color: AppTheme.textSecondaryColor,
              ),
          ],
        ),
      ),
    );
  }

  void _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
