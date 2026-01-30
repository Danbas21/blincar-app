import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/mock/mock_data.dart';
import '../../widgets/common/custom_button.dart';

class DocumentationPage extends StatefulWidget {
  const DocumentationPage({super.key});

  @override
  State<DocumentationPage> createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Documentación'),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryLightColor,
          labelColor: AppTheme.textPrimaryColor,
          unselectedLabelColor: AppTheme.textSecondaryColor,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Personal'),
            Tab(text: 'Licencia'),
            Tab(text: 'Vehículo'),
            Tab(text: 'Seguros'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalDocuments(),
          _buildLicenseDocuments(),
          _buildVehicleDocuments(),
          _buildInsuranceDocuments(),
        ],
      ),
    );
  }

  Widget _buildPersonalDocuments() {
    final personalDocs = MockData.getPersonalDocuments();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Documentos Personales',
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sube tus documentos oficiales para verificación',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ...personalDocs.map((doc) => _buildDocumentCard(doc)),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Subir Nuevo Documento',
            onPressed: () => _showUploadDialog('personal'),
            icon: Icons.upload_file,
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseDocuments() {
    final licenseDocs = MockData.getLicenseDocuments();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Licencia de Conducir',
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Licencia vigente y especializada según el tipo de servicio',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // Información de licencia requerida
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.warningColor.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: AppTheme.warningColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Licencias Requeridas',
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildLicenseRequirement(
                    'Chofer/Automovilista', 'Servicios básicos'),
                _buildLicenseRequirement(
                    'Chofer Federal', 'Servicios por días'),
                _buildLicenseRequirement(
                    'Escolta', 'Servicios blindados y escolta'),
                _buildLicenseRequirement(
                    'Manejo Defensivo', 'Todos los servicios de seguridad'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          ...licenseDocs.map((doc) => _buildDocumentCard(doc)),

          const SizedBox(height: 32),

          CustomButton(
            text: 'Subir Licencia',
            onPressed: () => _showUploadDialog('license'),
            icon: Icons.badge,
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleDocuments() {
    final vehicleDocs = MockData.getVehicleDocuments();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Documentos del Vehículo',
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tarjeta de circulación, verificación y documentos vehiculares',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // Información del vehículo registrado
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehículo Registrado',
                  style: TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildVehicleInfo('Marca', 'Chevrolet'),
                _buildVehicleInfo('Modelo', 'Aveo 2022'),
                _buildVehicleInfo('Color', 'Blanco'),
                _buildVehicleInfo('Placas', 'ABC-123-D'),
                _buildVehicleInfo('Año', '2022'),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Editar información del vehículo
                  },
                  child: const Text('Editar información'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          ...vehicleDocs.map((doc) => _buildDocumentCard(doc)),

          const SizedBox(height: 32),

          CustomButton(
            text: 'Subir Documento Vehicular',
            onPressed: () => _showUploadDialog('vehicle'),
            icon: Icons.directions_car,
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceDocuments() {
    final insuranceDocs = MockData.getInsuranceDocuments();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Seguros y Pólizas',
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Seguros de responsabilidad civil, vida y vehículo vigentes',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // Seguros requeridos
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.successColor.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: AppTheme.successColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Seguros Obligatorios',
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInsuranceRequirement(
                    'Responsabilidad Civil', 'Mínimo \$2,000,000 MXN'),
                _buildInsuranceRequirement(
                    'Seguro de Vida', 'Mínimo \$500,000 MXN'),
                _buildInsuranceRequirement(
                    'Seguro Vehicular', 'Cobertura amplia vigente'),
                _buildInsuranceRequirement(
                    'Gastos Médicos', 'Para pasajeros y conductor'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          ...insuranceDocs.map((doc) => _buildDocumentCard(doc)),

          const SizedBox(height: 32),

          CustomButton(
            text: 'Subir Póliza de Seguro',
            onPressed: () => _showUploadDialog('insurance'),
            icon: Icons.security,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(DocumentItem doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getStatusColor(doc.status).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getStatusColor(doc.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getDocumentIcon(doc.type),
                  color: _getStatusColor(doc.status),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.name,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      doc.description,
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(doc.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(doc.status),
                  style: TextStyle(
                    color: _getStatusColor(doc.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (doc.uploadDate != null) ...[
            const SizedBox(height: 12),
            Text(
              'Subido: ${doc.uploadDate!.day}/${doc.uploadDate!.month}/${doc.uploadDate!.year}',
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ],
          if (doc.expiryDate != null) ...[
            const SizedBox(height: 4),
            Text(
              'Vence: ${doc.expiryDate!.day}/${doc.expiryDate!.month}/${doc.expiryDate!.year}',
              style: TextStyle(
                color: _isExpiringSoon(doc.expiryDate!)
                    ? AppTheme.warningColor
                    : AppTheme.textSecondaryColor,
                fontSize: 12,
                fontWeight: _isExpiringSoon(doc.expiryDate!)
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
          if (doc.comments != null && doc.comments!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.comment,
                    color: AppTheme.textSecondaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      doc.comments!,
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              if (doc.status == DocumentStatus.rejected ||
                  doc.status == DocumentStatus.expired) ...[
                Expanded(
                  child: CustomButton(
                    text: 'Resubir',
                    onPressed: () => _showUploadDialog(doc.type),
                    type: ButtonType.secondary,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: CustomButton(
                  text: 'Ver Documento',
                  onPressed: () => _viewDocument(doc),
                  type: ButtonType.outline,
                  height: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseRequirement(String type, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: AppTheme.warningColor,
            size: 8,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: '$type: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
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
    );
  }

  Widget _buildInsuranceRequirement(String type, String coverage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppTheme.successColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: '$type: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: coverage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.approved:
        return AppTheme.successColor;
      case DocumentStatus.pending:
        return AppTheme.warningColor;
      case DocumentStatus.rejected:
        return AppTheme.errorColor;
      case DocumentStatus.expired:
        return AppTheme.errorColor;
      case DocumentStatus.missing:
        return AppTheme.textSecondaryColor;
    }
  }

  String _getStatusText(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.approved:
        return 'Aprobado';
      case DocumentStatus.pending:
        return 'Pendiente';
      case DocumentStatus.rejected:
        return 'Rechazado';
      case DocumentStatus.expired:
        return 'Vencido';
      case DocumentStatus.missing:
        return 'Faltante';
    }
  }

  IconData _getDocumentIcon(String type) {
    switch (type) {
      case 'personal':
        return Icons.person;
      case 'license':
        return Icons.badge;
      case 'vehicle':
        return Icons.directions_car;
      case 'insurance':
        return Icons.security;
      default:
        return Icons.description;
    }
  }

  bool _isExpiringSoon(DateTime expiryDate) {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    return difference <= 30;
  }

  void _showUploadDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          'Subir Documento',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Selecciona cómo quieres subir tu documento:',
              style: TextStyle(color: AppTheme.textSecondaryColor),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Tomar Foto',
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implementar cámara
                _simulateUpload();
              },
              icon: Icons.camera_alt,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Seleccionar Archivo',
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implementar selector de archivos
                _simulateUpload();
              },
              type: ButtonType.outline,
              icon: Icons.folder,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _viewDocument(DocumentItem doc) {
    // TODO: Implementar visor de documentos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abriendo documento: ${doc.name}'),
      ),
    );
  }

  void _simulateUpload() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📄 Documento subido exitosamente'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }
}
