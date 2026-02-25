// lib/presentation/pages/help/help_page.dart

import 'package:flutter/material.dart';
import 'package:blincar_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';

/// Página de Ayuda y Soporte
///
/// Proporciona FAQ, información de contacto y acceso a soporte.
/// Organizada por categorías para fácil navegación.
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<_FaqCategory> _categories = [
    _FaqCategory(
      title: 'Viajes',
      icon: Icons.directions_car,
      questions: [
        _FaqItem(
          question: '¿Cómo solicito un viaje?',
          answer: '1. Abre la aplicación e ingresa tu destino en la barra de búsqueda.\n'
              '2. Selecciona el tipo de servicio (Ejecutivo, Premium, etc.).\n'
              '3. Revisa el precio estimado y confirma.\n'
              '4. Espera a que se asigne un conductor.\n'
              '5. Rastrea la llegada del conductor en tiempo real.',
        ),
        _FaqItem(
          question: '¿Puedo programar un viaje para después?',
          answer: 'Sí. Puedes programar viajes con hasta 7 días de anticipación. '
              'Selecciona "Programar viaje" al solicitar y elige la fecha y hora deseada. '
              'Recibirás una notificación cuando el conductor esté en camino.',
        ),
        _FaqItem(
          question: '¿Qué hago si mi conductor no llega?',
          answer: 'Si tu conductor no llega dentro del tiempo estimado:\n'
              '1. Contacta al conductor a través de la app.\n'
              '2. Espera 5 minutos adicionales.\n'
              '3. Si no hay respuesta, cancela sin cargo.\n'
              '4. Solicita un nuevo viaje.\n'
              'Reporta el incidente para que podamos mejorar el servicio.',
        ),
        _FaqItem(
          question: '¿Puedo cambiar mi destino durante el viaje?',
          answer: 'Sí, puedes modificar tu destino en cualquier momento durante el viaje. '
              'La tarifa se ajustará automáticamente según la nueva ruta. '
              'Informa al conductor sobre el cambio.',
        ),
        _FaqItem(
          question: '¿Cómo cancelo un viaje?',
          answer: 'Puedes cancelar desde la pantalla de seguimiento del viaje:\n'
              '• Cancelación gratuita: dentro de 2 minutos.\n'
              '• Con cargo: después de 2 minutos o si el conductor ya está en camino.\n'
              'Te notificaremos si aplica algún cargo.',
        ),
      ],
    ),
    _FaqCategory(
      title: 'Pagos',
      icon: Icons.payment,
      questions: [
        _FaqItem(
          question: '¿Qué métodos de pago aceptan?',
          answer: 'Aceptamos:\n'
              '• Tarjetas de crédito (Visa, Mastercard, American Express)\n'
              '• Tarjetas de débito\n'
              '• Carnet (tarjetas mexicanas)\n'
              'Todos los pagos son procesados de forma segura a través de Stripe.',
        ),
        _FaqItem(
          question: '¿Cómo agrego una tarjeta?',
          answer: '1. Ve a tu Perfil > Métodos de Pago.\n'
              '2. Toca "Agregar tarjeta".\n'
              '3. Ingresa los datos de tu tarjeta.\n'
              '4. La tarjeta se guardará de forma segura.',
        ),
        _FaqItem(
          question: '¿Por qué me cobraron más de lo estimado?',
          answer: 'La tarifa puede variar por:\n'
              '• Cambios de destino durante el viaje.\n'
              '• Tiempo de espera adicional.\n'
              '• Peajes o estacionamientos.\n'
              '• Alta demanda al momento de solicitar.\n'
              'Revisa el desglose en tu historial de viajes.',
        ),
        _FaqItem(
          question: '¿Cómo solicito una factura?',
          answer: 'Las facturas se envían automáticamente a tu correo registrado. '
              'También puedes descargarlas desde Historial > Selecciona el viaje > '
              '"Solicitar factura". Asegúrate de tener tus datos fiscales actualizados.',
        ),
        _FaqItem(
          question: '¿Cómo solicito un reembolso?',
          answer: 'Si crees que un cargo es incorrecto:\n'
              '1. Ve a Historial de Pagos.\n'
              '2. Selecciona la transacción.\n'
              '3. Toca "Reportar problema".\n'
              '4. Describe el problema.\n'
              'Revisaremos tu caso en 24-48 horas.',
        ),
      ],
    ),
    _FaqCategory(
      title: 'Seguridad',
      icon: Icons.security,
      questions: [
        _FaqItem(
          question: '¿Cómo funciona el Botón de Pánico?',
          answer: 'El Botón de Pánico es una función de emergencia:\n'
              '1. Accede desde el menú principal o durante un viaje.\n'
              '2. Mantén presionado por 3 segundos.\n'
              '3. Se enviará tu ubicación GPS a tu contacto de emergencia.\n'
              '4. Nuestro equipo de seguridad será notificado.\n'
              '5. Puedes agregar notas de voz si es necesario.',
        ),
        _FaqItem(
          question: '¿Cómo comparto mi viaje?',
          answer: 'Durante un viaje activo:\n'
              '1. Toca el ícono de compartir en la pantalla de seguimiento.\n'
              '2. Selecciona contactos o apps para compartir.\n'
              '3. Tus contactos recibirán un enlace con tu ubicación en tiempo real.\n'
              'El enlace expira al finalizar el viaje.',
        ),
        _FaqItem(
          question: '¿Cómo actualizo mi contacto de emergencia?',
          answer: 'Ve a Perfil > Contacto de emergencia.\n'
              'Ingresa el nombre y teléfono de una persona de confianza. '
              'Esta persona será notificada si usas el Botón de Pánico.',
        ),
        _FaqItem(
          question: '¿Los conductores están verificados?',
          answer: 'Sí. Todos nuestros conductores pasan por:\n'
              '• Verificación de antecedentes penales.\n'
              '• Validación de licencia de conducir.\n'
              '• Revisión de historial de manejo.\n'
              '• Inspección vehicular.\n'
              '• Capacitación en servicio al cliente.',
        ),
      ],
    ),
    _FaqCategory(
      title: 'Cuenta',
      icon: Icons.person,
      questions: [
        _FaqItem(
          question: '¿Cómo cambio mi número de teléfono?',
          answer: 'Ve a Perfil > Editar perfil > Número de teléfono.\n'
              'Deberás verificar el nuevo número con un código SMS.',
        ),
        _FaqItem(
          question: '¿Cómo cambio mi contraseña?',
          answer: '1. Ve a Perfil > Editar perfil > Cambiar contraseña.\n'
              '2. Ingresa tu contraseña actual.\n'
              '3. Escribe y confirma la nueva contraseña.\n'
              'Si olvidaste tu contraseña, usa "¿Olvidaste tu contraseña?" en el login.',
        ),
        _FaqItem(
          question: '¿Cómo elimino mi cuenta?',
          answer: 'Para eliminar tu cuenta permanentemente:\n'
              '1. Contacta a soporte desde esta página.\n'
              '2. Solicita la eliminación de cuenta.\n'
              '3. Confirma tu identidad.\n'
              'Tus datos serán eliminados según nuestra política de privacidad.',
        ),
        _FaqItem(
          question: '¿Cómo subo mis documentos?',
          answer: 'Ve a Perfil > Documentación.\n'
              'Sube los documentos requeridos tomando una foto clara o '
              'seleccionando un archivo de tu dispositivo. '
              'Los documentos se revisan en 24-48 horas.',
        ),
      ],
    ),
  ];

  List<_FaqItem> get _filteredQuestions {
    if (_searchQuery.isEmpty) return [];

    final query = _searchQuery.toLowerCase();
    final results = <_FaqItem>[];

    for (final category in _categories) {
      for (final question in category.questions) {
        if (question.question.toLowerCase().contains(query) ||
            question.answer.toLowerCase().contains(query)) {
          results.add(question);
        }
      }
    }

    return results;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.helpTitle),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Búsqueda
          Padding(
            padding: const EdgeInsets.all(24),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: l10n.faqSearchHint,
                hintStyle: const TextStyle(color: AppTheme.textSecondaryColor),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppTheme.textSecondaryColor,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(color: AppTheme.textPrimaryColor),
            ),
          ),

          // Contenido
          Expanded(
            child: _searchQuery.isNotEmpty
                ? _buildSearchResults(l10n)
                : _buildCategoriesAndContact(l10n),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(AppLocalizations l10n) {
    final results = _filteredQuestions;

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noSearchResults,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _contactSupport(),
              icon: const Icon(Icons.support_agent),
              label: Text(l10n.contactSupport),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryLightColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return _buildFaqCard(results[index]);
      },
    );
  }

  Widget _buildCategoriesAndContact(AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        // Contacto rápido
        _buildContactCard(l10n),

        const SizedBox(height: 24),

        // Categorías
        Text(
          l10n.faqTitle,
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        ..._categories.map((category) => _buildCategorySection(category)),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildContactCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryLightColor,
            AppTheme.primaryLightColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.support_agent, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                l10n.support247,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.supportDescription,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildContactButton(
                  icon: Icons.phone,
                  label: 'Llamar',
                  onTap: () => _callSupport(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContactButton(
                  icon: Icons.email,
                  label: 'Email',
                  onTap: () => _emailSupport(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContactButton(
                  icon: Icons.chat,
                  label: 'Chat',
                  onTap: () => _openChat(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(_FaqCategory category) {
    return ExpansionTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          category.icon,
          color: AppTheme.primaryLightColor,
          size: 20,
        ),
      ),
      title: Text(
        category.title,
        style: const TextStyle(
          color: AppTheme.textPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${category.questions.length} preguntas',
        style: const TextStyle(
          color: AppTheme.textSecondaryColor,
          fontSize: 12,
        ),
      ),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 16),
      children: category.questions.map((q) => _buildFaqCard(q)).toList(),
    );
  }

  Widget _buildFaqCard(_FaqItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            item.question,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(color: AppTheme.dividerColor),
            const SizedBox(height: 8),
            Text(
              item.answer,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  '¿Te fue útil?',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _markHelpful(true),
                  icon: const Icon(Icons.thumb_up_outlined, size: 16),
                  label: const Text('Sí'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.successColor,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _markHelpful(false),
                  icon: const Icon(Icons.thumb_down_outlined, size: 16),
                  label: const Text('No'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.errorColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _contactSupport() {
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
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Contactar Soporte',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildContactOption(
              icon: Icons.phone,
              title: 'Llamar ahora',
              subtitle: '+52 55 1234 5678',
              onTap: _callSupport,
            ),
            _buildContactOption(
              icon: Icons.email,
              title: 'Enviar email',
              subtitle: 'soporte@blincar.com',
              onTap: _emailSupport,
            ),
            _buildContactOption(
              icon: Icons.chat,
              title: 'Chat en vivo',
              subtitle: 'Respuesta inmediata',
              onTap: _openChat,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryLightColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primaryLightColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppTheme.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _callSupport() async {
    final uri = Uri(scheme: 'tel', path: '+525512345678');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _emailSupport() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'soporte@blincar.com',
      queryParameters: {
        'subject': 'Solicitud de soporte - Blincar',
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _openChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chat de soporte próximamente'),
        backgroundColor: AppTheme.primaryLightColor,
      ),
    );
  }

  void _markHelpful(bool helpful) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          helpful ? 'Gracias por tu feedback' : 'Te contactaremos para ayudarte',
        ),
        backgroundColor: helpful ? AppTheme.successColor : AppTheme.primaryLightColor,
      ),
    );
  }
}

class _FaqCategory {
  final String title;
  final IconData icon;
  final List<_FaqItem> questions;

  _FaqCategory({
    required this.title,
    required this.icon,
    required this.questions,
  });
}

class _FaqItem {
  final String question;
  final String answer;

  _FaqItem({
    required this.question,
    required this.answer,
  });
}
