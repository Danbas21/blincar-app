import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blincar_app/l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/services/document_service.dart';
import '../../../data/mock/mock_data.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_button.dart';

class DocumentationPage extends StatefulWidget {
  const DocumentationPage({super.key});

  @override
  State<DocumentationPage> createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DocumentService _documentService = getIt<DocumentService>();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadUserId();
  }

  void _loadUserId() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _userId = authState.user.id;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.documentation),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryLightColor,
          labelColor: AppTheme.textPrimaryColor,
          unselectedLabelColor: AppTheme.textSecondaryColor,
          isScrollable: true,
          tabs: [
            Tab(text: l10n.personalDocs),
            Tab(text: l10n.licenseDocs),
            Tab(text: l10n.vehicleDocs),
            Tab(text: l10n.insuranceDocs),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalDocuments(l10n),
          _buildLicenseDocuments(l10n),
          _buildVehicleDocuments(l10n),
          _buildInsuranceDocuments(l10n),
        ],
      ),
    );
  }

  Widget _buildPersonalDocuments(AppLocalizations l10n) {
    final personalDocs = MockData.getPersonalDocuments();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.personalDocsTitle,
            style: TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.personalDocsDescription,
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ...personalDocs.map((doc) => _buildDocumentCard(doc, l10n)),
          const SizedBox(height: 32),
          CustomButton(
            text: l10n.uploadDocument,
            onPressed: () => _showUploadDialog('personal', l10n),
            icon: Icons.upload_file,
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseDocuments(AppLocalizations l10n) {
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

          ...licenseDocs.map((doc) => _buildDocumentCard(doc, l10n)),

          const SizedBox(height: 32),

          CustomButton(
            text: l10n.uploadDocument,
            onPressed: () => _showUploadDialog('license', l10n),
            icon: Icons.badge,
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleDocuments(AppLocalizations l10n) {
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

          ...vehicleDocs.map((doc) => _buildDocumentCard(doc, l10n)),

          const SizedBox(height: 32),

          CustomButton(
            text: l10n.uploadDocument,
            onPressed: () => _showUploadDialog('vehicle', l10n),
            icon: Icons.directions_car,
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceDocuments(AppLocalizations l10n) {
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

          ...insuranceDocs.map((doc) => _buildDocumentCard(doc, l10n)),

          const SizedBox(height: 32),

          CustomButton(
            text: l10n.uploadDocument,
            onPressed: () => _showUploadDialog('insurance', l10n),
            icon: Icons.security,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(DocumentItem doc, AppLocalizations l10n) {
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
                  _getStatusText(doc.status, l10n),
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
                    text: l10n.reupload,
                    onPressed: () => _showUploadDialog(doc.type, l10n),
                    type: ButtonType.secondary,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: CustomButton(
                  text: l10n.viewDocument,
                  onPressed: () => _viewDocument(doc, l10n),
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

  String _getStatusText(DocumentStatus status, AppLocalizations l10n) {
    switch (status) {
      case DocumentStatus.approved:
        return l10n.docApproved;
      case DocumentStatus.pending:
        return l10n.docPending;
      case DocumentStatus.rejected:
        return l10n.docRejected;
      case DocumentStatus.expired:
        return l10n.docExpired;
      case DocumentStatus.missing:
        return l10n.docMissing;
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

  void _showUploadDialog(String type, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Text(
          l10n.uploadNewDocument,
          style: const TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.chooseUploadMethod,
              style: const TextStyle(color: AppTheme.textSecondaryColor),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: l10n.takePhoto,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _captureAndUpload(type, useCamera: true);
              },
              icon: Icons.camera_alt,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: l10n.selectFromGallery,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _captureAndUpload(type, useCamera: false);
              },
              type: ButtonType.outline,
              icon: Icons.photo_library,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  Future<void> _captureAndUpload(String documentType,
      {required bool useCamera}) async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Usuario no autenticado'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    // Obtener imagen
    File? imageFile;
    if (useCamera) {
      imageFile = await _documentService.takePhoto();
    } else {
      imageFile = await _documentService.pickImageFromGallery();
    }

    if (imageFile == null) {
      return; // Usuario canceló
    }

    // Mostrar dialog de carga
    _showUploadingDialog();

    // Subir documento
    final result = await _documentService.uploadDocument(
      file: imageFile,
      userId: _userId!,
      documentType: documentType,
      documentName: _getDocumentNameForType(documentType),
    );

    // Cerrar dialog de carga
    if (mounted) {
      Navigator.of(context).pop();
    }

    // Mostrar resultado
    if (mounted) {
      if (result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Documento subido exitosamente'),
              ],
            ),
            backgroundColor: AppTheme.successColor,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                    child:
                        Text(result.errorMessage ?? 'Error al subir documento')),
              ],
            ),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _showUploadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppTheme.primaryLightColor),
            ),
            const SizedBox(height: 20),
            const Text(
              'Subiendo documento...',
              style: TextStyle(color: AppTheme.textPrimaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Por favor espera',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDocumentNameForType(String type) {
    switch (type) {
      case 'personal':
        return 'Documento_Personal';
      case 'license':
        return 'Licencia';
      case 'vehicle':
        return 'Documento_Vehicular';
      case 'insurance':
        return 'Poliza_Seguro';
      default:
        return 'Documento';
    }
  }

  void _viewDocument(DocumentItem doc, AppLocalizations l10n) {
    // Mostrar diálogo con opciones de visualización
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getStatusColor(doc.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getDocumentIcon(doc.type),
                    color: _getStatusColor(doc.status),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.name,
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
                          color:
                              _getStatusColor(doc.status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _getStatusText(doc.status, l10n),
                          style: TextStyle(
                            color: _getStatusColor(doc.status),
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
            Text(
              doc.description,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
            if (doc.uploadDate != null) ...[
              const SizedBox(height: 12),
              _buildDocumentInfoRow(
                Icons.calendar_today,
                'Subido',
                '${doc.uploadDate!.day}/${doc.uploadDate!.month}/${doc.uploadDate!.year}',
              ),
            ],
            if (doc.expiryDate != null) ...[
              const SizedBox(height: 8),
              _buildDocumentInfoRow(
                Icons.event,
                'Vence',
                '${doc.expiryDate!.day}/${doc.expiryDate!.month}/${doc.expiryDate!.year}',
                isWarning: _isExpiringSoon(doc.expiryDate!),
              ),
            ],
            if (doc.comments != null && doc.comments!.isNotEmpty) ...[
              const SizedBox(height: 16),
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
                      color: AppTheme.warningColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        doc.comments!,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                if (doc.status == DocumentStatus.rejected ||
                    doc.status == DocumentStatus.expired) ...[
                  Expanded(
                    child: CustomButton(
                      text: l10n.reupload,
                      onPressed: () {
                        Navigator.pop(context);
                        _showUploadDialog(doc.type, l10n);
                      },
                      icon: Icons.upload,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: CustomButton(
                    text: 'Cerrar',
                    onPressed: () => Navigator.pop(context),
                    type: ButtonType.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentInfoRow(IconData icon, String label, String value,
      {bool isWarning = false}) {
    return Row(
      children: [
        Icon(
          icon,
          color: isWarning ? AppTheme.warningColor : AppTheme.textSecondaryColor,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color:
                isWarning ? AppTheme.warningColor : AppTheme.textPrimaryColor,
            fontSize: 13,
            fontWeight: isWarning ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
