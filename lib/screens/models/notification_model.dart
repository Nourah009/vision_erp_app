// models/notification_model.dart
import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;
  final String? relatedId;
  final Map<String, String>? localizedTitles;
  final Map<String, String>? localizedMessages;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    required this.type,
    this.relatedId,
    this.localizedTitles,
    this.localizedMessages,
  });

  // ✅ دالة للحصول على العنوان المترجم
  String getTranslatedTitle(String languageCode) {
    if (localizedTitles != null && localizedTitles!.containsKey(languageCode)) {
      return localizedTitles![languageCode]!;
    }
    return title;
  }

  // ✅ دالة للحصول على الرسالة المترجمة
  String getTranslatedMessage(String languageCode) {
    if (localizedMessages != null && localizedMessages!.containsKey(languageCode)) {
      return localizedMessages![languageCode]!;
    }
    return message;
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
    NotificationType? type,
    String? relatedId,
    Map<String, String>? localizedTitles,
    Map<String, String>? localizedMessages,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      relatedId: relatedId ?? this.relatedId,
      localizedTitles: localizedTitles ?? this.localizedTitles,
      localizedMessages: localizedMessages ?? this.localizedMessages,
    );
  }
}

enum NotificationType {
  salesReport,
  systemAlert,
  userActivity,
  reminder,
  general,
  newFeature,
  maintenance,
  security
}

extension NotificationTypeExtension on NotificationType {
  String get displayName {
    switch (this) {
      case NotificationType.salesReport:
        return 'Sales Report';
      case NotificationType.systemAlert:
        return 'System Alert';
      case NotificationType.userActivity:
        return 'User Activity';
      case NotificationType.reminder:
        return 'Reminder';
      case NotificationType.general:
        return 'General';
      case NotificationType.newFeature:
        return 'New Feature';
      case NotificationType.maintenance:
        return 'Maintenance';
      case NotificationType.security:
        return 'Security';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.salesReport:
        return Icons.bar_chart;
      case NotificationType.systemAlert:
        return Icons.warning;
      case NotificationType.userActivity:
        return Icons.person;
      case NotificationType.reminder:
        return Icons.notifications;
      case NotificationType.general:
        return Icons.info;
      case NotificationType.newFeature:
        return Icons.new_releases;
      case NotificationType.maintenance:
        return Icons.build;
      case NotificationType.security:
        return Icons.security;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.salesReport:
        return Colors.blue;
      case NotificationType.systemAlert:
        return Colors.orange;
      case NotificationType.userActivity:
        return Colors.green;
      case NotificationType.reminder:
        return Colors.purple;
      case NotificationType.general:
        return Colors.grey;
      case NotificationType.newFeature:
        return Colors.teal;
      case NotificationType.maintenance:
        return Colors.amber;
      case NotificationType.security:
        return Colors.red;
    }
  }
}