// services/auto_notification_service.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'notification_service.dart';

class AutoNotificationService {
  static Timer? _notificationTimer;
  static bool _isRunning = false;
  static ValueChanged<int>? _onNewNotification;

  // بدء المؤقت التلقائي
  static void startAutoNotifications({ValueChanged<int>? onNewNotification}) {
    if (_isRunning) return;
    
    _onNewNotification = onNewNotification;
    _isRunning = true;
    
    // بدء المؤقت كل دقيقتين (120 ثانية)
    _notificationTimer = Timer.periodic(const Duration(minutes: 2), (timer) async {
      await _generateRandomNotification();
    });

    print('Auto notifications started - generating every 2 minutes');
  }

  // إيقاف المؤقت التلقائي
  static void stopAutoNotifications() {
    _notificationTimer?.cancel();
    _notificationTimer = null;
    _isRunning = false;
    _onNewNotification = null;
    print('Auto notifications stopped');
  }

  // التحقق إذا كان المؤقت يعمل
  static bool get isRunning => _isRunning;

  // توليد إشعار عشوائي
  static Future<void> _generateRandomNotification() async {
    try {
      final random = Random().nextInt(3);
      
      switch (random) {
        case 0:
          await NotificationService.generateAutoNotification();
          break;
        case 1:
          await NotificationService.generateSalesNotification();
          break;
        case 2:
          await NotificationService.generateSystemNotification();
          break;
      }

      // إشعار الـ UI بتحديث العداد
      final unreadCount = await NotificationService.getUnreadCount();
      _onNewNotification?.call(unreadCount);
      
    } catch (e) {
      print('Error generating auto notification: $e');
    }
  }

  // تبديل حالة المؤقت
  static void toggleAutoNotifications({ValueChanged<int>? onNewNotification}) {
    if (_isRunning) {
      stopAutoNotifications();
    } else {
      startAutoNotifications(onNewNotification: onNewNotification);
    }
  }

  // توليد إشعار فوري للاختبار
  static Future<void> generateTestNotification() async {
    await NotificationService.generateAutoNotification();
    final unreadCount = await NotificationService.getUnreadCount();
    _onNewNotification?.call(unreadCount);
  }
}