import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:blincar_app/l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final database = FirebaseDatabase.instance;
      final snapshot = await database
          .ref('blincar/notifications/${user.uid}')
          .orderByChild('createdAt')
          .limitToLast(50)
          .get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final notifications = <NotificationItem>[];

        data.forEach((key, value) {
          if (value is Map) {
            notifications.add(NotificationItem(
              id: key.toString(),
              title: value['title']?.toString() ?? 'Notificación',
              message: value['body']?.toString() ?? '',
              type: _parseType(value['type']?.toString()),
              timestamp: DateTime.fromMillisecondsSinceEpoch(
                (value['createdAt'] as int?) ?? DateTime.now().millisecondsSinceEpoch,
              ),
              isRead: value['read'] == true,
              tripId: value['tripId']?.toString(),
            ));
          }
        });

        // Ordenar por fecha descendente (más recientes primero)
        notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        setState(() {
          _notifications = notifications;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint('Error cargando notificaciones: $e');
      setState(() => _isLoading = false);
    }
  }

  NotificationType _parseType(String? type) {
    switch (type) {
      case 'assigned':
      case 'driver_arrived':
      case 'inProgress':  // Current format
      case 'in_progress': // Legacy format
      case 'completed':
      case 'driver_nearby':
        return NotificationType.trip;
      case 'cancelled':
        return NotificationType.security;
      case 'payment':
        return NotificationType.payment;
      default:
        return NotificationType.system;
    }
  }

  Future<void> _markAllAsRead() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final database = FirebaseDatabase.instance;
      final updates = <String, dynamic>{};

      for (final notification in _notifications) {
        if (!notification.isRead) {
          updates['blincar/notifications/${user.uid}/${notification.id}/read'] = true;
        }
      }

      if (updates.isNotEmpty) {
        await database.ref().update(updates);
        setState(() {
          _notifications = _notifications.map((n) => NotificationItem(
            id: n.id,
            title: n.title,
            message: n.message,
            type: n.type,
            timestamp: n.timestamp,
            isRead: true,
            tripId: n.tripId,
          )).toList();
        });
      }
    } catch (e) {
      debugPrint('Error marcando notificaciones: $e');
    }
  }

  Future<void> _markAsRead(NotificationItem notification) async {
    if (notification.isRead) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseDatabase.instance
          .ref('blincar/notifications/${user.uid}/${notification.id}/read')
          .set(true);

      setState(() {
        final index = _notifications.indexWhere((n) => n.id == notification.id);
        if (index != -1) {
          _notifications[index] = NotificationItem(
            id: notification.id,
            title: notification.title,
            message: notification.message,
            type: notification.type,
            timestamp: notification.timestamp,
            isRead: true,
            tripId: notification.tripId,
          );
        }
      });
    } catch (e) {
      debugPrint('Error marcando notificación: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.notifications),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
        actions: [
          if (_notifications.any((n) => !n.isRead))
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(l10n.markAllRead),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNotifications,
              child: _notifications.isEmpty
                  ? ListView(
                      children: [
                        const SizedBox(height: 200),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.notifications_off,
                                size: 64,
                                color: AppTheme.textSecondaryColor,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                l10n.noNotifications,
                                style: const TextStyle(
                                  color: AppTheme.textSecondaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return GestureDetector(
                          onTap: () => _markAsRead(notification),
                          child: _buildNotificationCard(notification, l10n),
                        );
                      },
                    ),
            ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead ? AppTheme.cardColor : AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification.isRead
              ? AppTheme.dividerColor
              : AppTheme.primaryLightColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getTypeColor(notification.type).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getTypeIcon(notification.type),
              color: _getTypeColor(notification.type),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 16,
                    fontWeight: notification.isRead
                        ? FontWeight.normal
                        : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatTime(notification.timestamp, l10n),
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppTheme.primaryLightColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.trip:
        return AppTheme.primaryLightColor;
      case NotificationType.payment:
        return AppTheme.successColor;
      case NotificationType.security:
        return AppTheme.errorColor;
      case NotificationType.system:
        return AppTheme.accentColor;
    }
  }

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.trip:
        return Icons.directions_car;
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.security:
        return Icons.security;
      case NotificationType.system:
        return Icons.info;
    }
  }

  String _formatTime(DateTime timestamp, AppLocalizations l10n) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return l10n.justNow;
    } else if (difference.inHours < 1) {
      return 'Hace ${difference.inMinutes} min';
    } else if (difference.inDays < 1) {
      return 'Hace ${difference.inHours}h';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

/// Modelo de notificación
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? tripId;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.tripId,
  });
}

enum NotificationType {
  trip,
  payment,
  security,
  system,
}
