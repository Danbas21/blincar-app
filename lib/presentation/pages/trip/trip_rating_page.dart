import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/common/custom_button.dart';

/// Página para calificar el viaje después de completarlo
///
/// Estructura en Firebase:
/// /blincar/ratings/{tripId}
///   - tripId
///   - passengerId
///   - driverId
///   - stars (1-5)
///   - comment
///   - createdAt
class TripRatingPage extends StatefulWidget {
  final String tripId;
  final String passengerId;
  final String driverId;
  final String driverName;
  final String? driverPhoto;
  final VoidCallback? onRatingSubmitted;
  final VoidCallback? onSkip;

  const TripRatingPage({
    super.key,
    required this.tripId,
    required this.passengerId,
    required this.driverId,
    required this.driverName,
    this.driverPhoto,
    this.onRatingSubmitted,
    this.onSkip,
  });

  @override
  State<TripRatingPage> createState() => _TripRatingPageState();
}

class _TripRatingPageState extends State<TripRatingPage>
    with SingleTickerProviderStateMixin {
  int _selectedStars = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {
    if (_selectedStars == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una calificación'),
          backgroundColor: AppTheme.warningColor,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final database = FirebaseDatabase.instance;
      await database.ref('blincar/ratings/${widget.tripId}').set({
        'tripId': widget.tripId,
        'passengerId': widget.passengerId,
        'driverId': widget.driverId,
        'stars': _selectedStars,
        'comment': _commentController.text.trim(),
        'createdAt': ServerValue.timestamp,
      });

      // Actualizar promedio de calificación del conductor
      await _updateDriverRating();

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.thankYouForRating),
            backgroundColor: AppTheme.successColor,
          ),
        );

        if (widget.onRatingSubmitted != null) {
          widget.onRatingSubmitted!();
        } else {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al enviar calificación: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  Future<void> _updateDriverRating() async {
    try {
      final database = FirebaseDatabase.instance;

      // Obtener todas las calificaciones del conductor
      final snapshot = await database
          .ref('blincar/ratings')
          .orderByChild('driverId')
          .equalTo(widget.driverId)
          .once();

      if (snapshot.snapshot.value != null) {
        final ratings = snapshot.snapshot.value as Map<dynamic, dynamic>;
        int totalStars = 0;
        int count = 0;

        ratings.forEach((key, value) {
          if (value is Map && value['stars'] != null) {
            totalStars += (value['stars'] as int);
            count++;
          }
        });

        if (count > 0) {
          final average = totalStars / count;
          await database
              .ref('blincar/drivers/${widget.driverId}/rating')
              .set(average);
          await database
              .ref('blincar/drivers/${widget.driverId}/totalRatings')
              .set(count);
        }
      }
    } catch (e) {
      debugPrint('Error actualizando rating del conductor: $e');
    }
  }

  void _onStarTapped(int stars) {
    setState(() => _selectedStars = stars);
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.textPrimaryColor),
          onPressed: widget.onSkip ?? () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  kToolbarHeight -
                  48,
            ),
            child: Column(
              children: [
                // Avatar del conductor
                CircleAvatar(
                radius: 50,
                backgroundColor: AppTheme.primaryLightColor,
                backgroundImage: widget.driverPhoto != null
                    ? NetworkImage(widget.driverPhoto!)
                    : null,
                child: widget.driverPhoto == null
                    ? Text(
                        widget.driverName.isNotEmpty
                            ? widget.driverName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),

              // Nombre del conductor
              Text(
                widget.driverName,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Título
              Text(
                l10n.howWasYourTrip,
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),

              // Estrellas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starNumber = index + 1;
                  final isSelected = starNumber <= _selectedStars;

                  return GestureDetector(
                    onTap: () => _onStarTapped(starNumber),
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        final scale = starNumber == _selectedStars
                            ? _scaleAnimation.value
                            : 1.0;
                        return Transform.scale(
                          scale: scale,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              isSelected ? Icons.star : Icons.star_border,
                              size: 48,
                              color: isSelected
                                  ? AppTheme.warningColor
                                  : AppTheme.textSecondaryColor,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Texto de calificación
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _getRatingText(_selectedStars),
                  key: ValueKey(_selectedStars),
                  style: TextStyle(
                    color: _selectedStars > 0
                        ? AppTheme.primaryLightColor
                        : AppTheme.textSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Campo de comentario
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.dividerColor),
                ),
                child: TextField(
                  controller: _commentController,
                  maxLines: 4,
                  style: const TextStyle(color: AppTheme.textPrimaryColor),
                  decoration: InputDecoration(
                    hintText: l10n.commentPlaceholder,
                    hintStyle:
                        const TextStyle(color: AppTheme.textSecondaryColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    labelText: l10n.leaveComment,
                    labelStyle:
                        const TextStyle(color: AppTheme.textSecondaryColor),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Botones
              CustomButton(
                text: l10n.submitRating,
                onPressed: _submitRating,
                isLoading: _isSubmitting,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed:
                    widget.onSkip ?? () => Navigator.of(context).pop(false),
                child: Text(
                  l10n.skipRating,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }

  String _getRatingText(int stars) {
    switch (stars) {
      case 1:
        return 'Muy malo';
      case 2:
        return 'Malo';
      case 3:
        return 'Regular';
      case 4:
        return 'Bueno';
      case 5:
        return 'Excelente';
      default:
        return 'Selecciona una calificación';
    }
  }
}
