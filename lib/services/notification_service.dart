// services/notification_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vision_erp_app/screens/models/notification_model.dart';


class NotificationService {
  static const String _notificationsKey = 'user_notifications';

  static Future<List<NotificationModel>> getNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notificationsJson = prefs.getString(_notificationsKey);
      
      if (notificationsJson == null) {
        return _getDefaultNotifications();
      }
      
      final List<dynamic> notificationsList = json.decode(notificationsJson);
      return notificationsList.map((item) {
      // ✅ تحويل Map إلى Map<String, String> للترجمات
      Map<String, String>? localizedTitles;
      if (item['localizedTitles'] != null) {
        localizedTitles = Map<String, String>.from(item['localizedTitles']);
      }
      
      Map<String, String>? localizedMessages;
      if (item['localizedMessages'] != null) {
        localizedMessages = Map<String, String>.from(item['localizedMessages']);
      }
      
      return NotificationModel(
        id: item['id'],
        title: item['title'],
        message: item['message'],
        timestamp: DateTime.parse(item['timestamp']),
        isRead: item['isRead'],
        type: NotificationType.values[item['type']],
        relatedId: item['relatedId'],
        localizedTitles: localizedTitles,
        localizedMessages: localizedMessages,
      );
    }).toList();
  } catch (e) {
    print('Error getting notifications: $e');
    return _getDefaultNotifications();
  }
}

  static Future<void> saveNotifications(List<NotificationModel> notifications) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notificationsJson = json.encode(notifications.map((notification) => {
        'id': notification.id,
        'title': notification.title,
        'message': notification.message,
        'timestamp': notification.timestamp.toIso8601String(),
        'isRead': notification.isRead,
        'type': notification.type.index,
        'relatedId': notification.relatedId,
        'localizedTitles': notification.localizedTitles, // ✅ حفظ الترجمات
        'localizedMessages': notification.localizedMessages, // ✅ حفظ الترجمات
      }).toList());
      
      await prefs.setString(_notificationsKey, notificationsJson);
    } catch (e) {
      print('Error saving notifications: $e');
    }
  }

  static Future<void> addNotification(NotificationModel notification) async {
    final notifications = await getNotifications();
    notifications.insert(0, notification);
    await saveNotifications(notifications);
  }

  static Future<void> markAsRead(String notificationId) async {
    final notifications = await getNotifications();
    final index = notifications.indexWhere((n) => n.id == notificationId);
    
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      await saveNotifications(notifications);
    }
  }

  static Future<void> markAllAsRead() async {
    final notifications = await getNotifications();
    final updatedNotifications = notifications.map((notification) 
      => notification.copyWith(isRead: true)).toList();
    await saveNotifications(updatedNotifications);
  }

  static Future<void> deleteNotification(String notificationId) async {
    final notifications = await getNotifications();
    notifications.removeWhere((n) => n.id == notificationId);
    await saveNotifications(notifications);
  }

  static Future<int> getUnreadCount() async {
    final notifications = await getNotifications();
    return notifications.where((n) => !n.isRead).length;
  }

  static Future<void> clearAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationsKey);
  }

  // ✅ إشعارات افتراضية مع الترجمات
  static List<NotificationModel> _getDefaultNotifications() {
    return [
      NotificationModel(
        id: '1',
        title: 'Welcome to Vision ERP',
        message: 'Your account has been successfully setup. Explore all features now.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.general,
        localizedTitles: {
          'en': 'Welcome to Vision ERP',
          'ar': 'مرحباً بك في Vision ERP',
        },
        localizedMessages: {
          'en': 'Your account has been successfully setup. Explore all features now.',
          'ar': 'تم إعداد حسابك بنجاح. استكشف جميع الميزات الآن.',
        },
      ),
      NotificationModel(
        id: '2',
        title: 'Weekly Sales Report Ready',
        message: 'Last week sales report is ready for review. Check your performance metrics.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.salesReport,
        relatedId: 'weekly_sales_1',
        localizedTitles: {
          'en': 'Weekly Sales Report Ready',
          'ar': 'تقرير المبيعات الأسبوعي جاهز',
        },
        localizedMessages: {
          'en': 'Last week sales report is ready for review. Check your performance metrics.',
          'ar': 'تقرير مبيعات الأسبوع الماضي جاهز للمراجعة. تحقق من مؤشرات أدائك.',
        },
      ),
      NotificationModel(
        id: '3',
        title: 'System Update Available',
        message: 'New system version 2.1.0 is available with enhanced features.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: NotificationType.systemAlert,
        localizedTitles: {
          'en': 'System Update Available',
          'ar': 'تحديث النظام متاح',
        },
        localizedMessages: {
          'en': 'New system version 2.1.0 is available with enhanced features.',
          'ar': 'الإصدار الجديد 2.1.0 من النظام متاح بميزات محسنة.',
        },
      ),
      NotificationModel(
        id: '4',
        title: 'New Feature: Advanced Analytics',
        message: 'Check out the new advanced analytics dashboard for better insights.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        type: NotificationType.newFeature,
        localizedTitles: {
          'en': 'New Feature: Advanced Analytics',
          'ar': 'ميزة جديدة: التحليلات المتقدمة',
        },
        localizedMessages: {
          'en': 'Check out the new advanced analytics dashboard for better insights.',
          'ar': 'تحقق من لوحة تحليلات متقدمة جديدة للحصول على رؤى أفضل.',
        },
      ),
      NotificationModel(
        id: '5',
        title: 'Scheduled Maintenance',
        message: 'System maintenance scheduled for Saturday 10:00 PM - 2:00 AM.',
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        type: NotificationType.maintenance,
        localizedTitles: {
          'en': 'Scheduled Maintenance',
          'ar': 'الصيانة المجدولة',
        },
        localizedMessages: {
          'en': 'System maintenance scheduled for Saturday 10:00 PM - 2:00 AM.',
          'ar': 'تم جدولة صيانة النظام يوم السبت من 10:00 مساءً إلى 2:00 صباحًا.',
        },
      ),
    ];
  }

  static final List<Map<String, dynamic>> _autoNotifications = [
    {
      'title': 'New Sales Data Available',
      'message': 'Fresh sales data has been synchronized. Check your dashboard for updates.',
      'type': NotificationType.salesReport,
      'localizedTitles': {
        'en': 'New Sales Data Available',
        'ar': 'بيانات مبيعات جديدة متاحة',
      },
      'localizedMessages': {
        'en': 'Fresh sales data has been synchronized. Check your dashboard for updates.',
        'ar': 'تم مزامنة بيانات المبيعات الجديدة. تحقق من لوحة التحكم للتحديثات.',
      },
    },
    {
      'title': 'System Performance',
      'message': 'System running optimally. All services are operational.',
      'type': NotificationType.systemAlert,
      'localizedTitles': {
        'en': 'System Performance',
        'ar': 'أداء النظام',
      },
      'localizedMessages': {
        'en': 'System running optimally. All services are operational.',
        'ar': 'النظام يعمل بشكل مثالي. جميع الخدمات قيد التشغيل.',
      },
    },
    {
      'title': 'Daily Summary Ready',
      'message': 'Your daily business summary is ready for review.',
      'type': NotificationType.general,
      'localizedTitles': {
        'en': 'Daily Summary Ready',
        'ar': 'ملخص اليوم جاهز',
      },
      'localizedMessages': {
        'en': 'Your daily business summary is ready for review.',
        'ar': 'ملخص أعمالك اليوم جاهز للمراجعة.',
      },
    },
    {
      'title': 'Inventory Update',
      'message': 'Inventory levels have been updated with latest stock counts.',
      'type': NotificationType.systemAlert,
      'localizedTitles': {
        'en': 'Inventory Update',
        'ar': 'تحديث المخزون',
      },
      'localizedMessages': {
        'en': 'Inventory levels have been updated with latest stock counts.',
        'ar': 'تم تحديث مستويات المخزون بأحدث أعداد المخزون.',
      },
    },
    {
      'title': 'User Activity Report',
      'message': 'Weekly user activity report generated successfully.',
      'type': NotificationType.userActivity,
      'localizedTitles': {
        'en': 'User Activity Report',
        'ar': 'تقرير نشاط المستخدم',
      },
      'localizedMessages': {
        'en': 'Weekly user activity report generated successfully.',
        'ar': 'تم إنشاء تقرير نشاط المستخدم الأسبوعي بنجاح.',
      },
    },
    {
      'title': 'Data Backup Completed',
      'message': 'Automatic data backup completed successfully.',
      'type': NotificationType.security,
      'localizedTitles': {
        'en': 'Data Backup Completed',
        'ar': 'اكتمل نسخ البيانات احتياطيًا',
      },
      'localizedMessages': {
        'en': 'Automatic data backup completed successfully.',
        'ar': 'تم الانتهاء من النسخ الاحتياطي التلقائي للبيانات بنجاح.',
      },
    },
    {
      'title': 'New Features Available',
      'message': 'Check out the latest features added to Vision ERP system.',
      'type': NotificationType.newFeature,
      'localizedTitles': {
        'en': 'New Features Available',
        'ar': 'ميزات جديدة متاحة',
      },
      'localizedMessages': {
        'en': 'Check out the latest features added to Vision ERP system.',
        'ar': 'تحقق من أحدث الميزات المضافة إلى نظام Vision ERP.',
      },
    },
    {
      'title': 'Performance Tips',
      'message': 'Tip: Use keyboard shortcuts to navigate faster in the system.',
      'type': NotificationType.reminder,
      'localizedTitles': {
        'en': 'Performance Tips',
        'ar': 'نصائح الأداء',
      },
      'localizedMessages': {
        'en': 'Tip: Use keyboard shortcuts to navigate faster in the system.',
        'ar': 'نصيحة: استخدم اختصارات لوحة المفاتيح للتنقل بشكل أسرع في النظام.',
      },
    },
  ];

  // ✅ إنشاء إشعار عشوائي تلقائي مع الترجمات
  static Future<void> generateAutoNotification() async {
    final random = Random();
    final notificationData = _autoNotifications[random.nextInt(_autoNotifications.length)];
    
    final notification = NotificationModel(
      id: 'auto_${DateTime.now().millisecondsSinceEpoch}',
      title: notificationData['title'] as String,
      message: notificationData['message'] as String,
      timestamp: DateTime.now(),
      type: notificationData['type'] as NotificationType,
      localizedTitles: notificationData['localizedTitles'] as Map<String, String>?,
      localizedMessages: notificationData['localizedMessages'] as Map<String, String>?,
    );

    await addNotification(notification);
    print('Auto notification generated: ${notification.title}');
  }

  // ✅ دالة الحصول على الإشعارات مع الترجمة
  static Future<List<NotificationModel>> getTranslatedNotifications(String languageCode) async {
    final notifications = await getNotifications();
    
    // إذا كانت اللغة الإنجليزية، لا داعي للترجمة
    if (languageCode == 'en') {
      return notifications;
    }
    
    // إرجاع الإشعارات مع النصوص المترجمة
    return notifications.map((notification) {
      final translatedTitle = notification.getTranslatedTitle(languageCode);
      final translatedMessage = notification.getTranslatedMessage(languageCode);
      
      return notification.copyWith(
        title: translatedTitle,
        message: translatedMessage,
      );
    }).toList();
  }

  // إنشاء إشعارات خاصة بالمبيعات
  static Future<void> generateSalesNotification() async {
    final salesMessages = [
      {
      'en': 'New sales order #${Random().nextInt(1000) + 1000} has been created.',
      'ar': 'تم إنشاء طلب مبيعات جديد #${Random().nextInt(1000) + 1000}.'
    },
    {
      'en': 'Monthly sales target achieved: ${Random().nextInt(30) + 70}% completed.',
      'ar': 'تم تحقيق هدف المبيعات الشهري: ${Random().nextInt(30) + 70}% مكتمل.'
    },
    {
      'en': 'Customer payment received for invoice #INV-${DateTime.now().month}${Random().nextInt(100)}.',
      'ar': 'تم استلام دفعة العميل للفاتورة #INV-${DateTime.now().month}${Random().nextInt(100)}.'
    },
    {
      'en': 'Sales team performance: ${Random().nextInt(40) + 60}% of weekly goal reached.',
      'ar': 'أداء فريق المبيعات: ${Random().nextInt(40) + 60}% من الهدف الأسبوعي تم تحقيقه.'
    },
    {
      'en': 'New customer registered in the system. Welcome to Vision ERP!',
      'ar': 'تم تسجيل عميل جديد في النظام. مرحباً بك في Vision ERP!'
    },
    ];

     final random = Random();
  final messageData = salesMessages[random.nextInt(salesMessages.length)];
  
  final notification = NotificationModel(
    id: 'sales_${DateTime.now().millisecondsSinceEpoch}',
    title: 'Sales Update',
    message: messageData['en']!,
    timestamp: DateTime.now(),
    type: NotificationType.salesReport,
    localizedTitles: {
      'en': 'Sales Update',
      'ar': 'تحديث المبيعات',
    },
    localizedMessages: {
      'en': messageData['en']!,
      'ar': messageData['ar']!,
    },
  );

  await addNotification(notification);
}

  // إنشاء إشعارات تنبيه النظام
  static Future<void> generateSystemNotification() async {
    final systemMessages = [
      {
      'en': 'System maintenance completed successfully.',
      'ar': 'تم الانتهاء من صيانة النظام بنجاح.'
    },
    {
      'en': 'New update available for Vision ERP mobile app.',
      'ar': 'تحديث جديد متاح لتطبيق Vision ERP للجوال.'
    },
    {
      'en': 'Database optimization completed. Performance improved.',
      'ar': 'تم الانتهاء من تحسين قاعدة البيانات. تحسن الأداء.'
    },
    {
      'en': 'Security scan completed. No threats detected.',
      'ar': 'تم الانتهاء من فحص الأمان. لم يتم اكتشاف أي تهديدات.'
    },
    {
      'en': 'Cloud sync completed. All data synchronized.',
      'ar': 'تم الانتهاء من مزامنة السحابة. جميع البيانات متزامنة.'
    },
    ];

   final random = Random();
  final messageData = systemMessages[random.nextInt(systemMessages.length)];
  
  final notification = NotificationModel(
    id: 'system_${DateTime.now().millisecondsSinceEpoch}',
    title: 'System Alert',
    message: messageData['en']!,
    timestamp: DateTime.now(),
    type: NotificationType.systemAlert,
    localizedTitles: {
      'en': 'System Alert',
      'ar': 'تنبيه النظام',
    },
    localizedMessages: {
      'en': messageData['en']!,
      'ar': messageData['ar']!,
    },
  );

  await addNotification(notification);
}

  // إنشاء إشعارات تجريبية خاصة بالتطبيق
  static Future<void> generateSampleAppNotifications() async {
    final sampleNotifications = [
      NotificationModel(
        id: 'app_${DateTime.now().millisecondsSinceEpoch}',
        title: 'Monthly Performance Report',
        message: 'Your monthly performance report shows 25% growth in sales. Great job!',
        timestamp: DateTime.now(),
        type: NotificationType.salesReport,
        localizedTitles: {
        'en': 'Monthly Performance Report',
        'ar': 'تقرير الأداء الشهري',
      },
      localizedMessages: {
        'en': 'Your monthly performance report shows 25% growth in sales. Great job!',
        'ar': 'يظهر تقرير أدائك الشهري نمواً بنسبة 25% في المبيعات. عمل رائع!',
      },
      ),
      NotificationModel(
        id: 'app_${DateTime.now().millisecondsSinceEpoch + 1}',
        title: 'New Dashboard Features',
        message: 'Enhanced dashboard with real-time analytics and custom widgets available.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        type: NotificationType.newFeature,
         localizedTitles: {
        'en': 'New Dashboard Features',
        'ar': 'ميزات لوحة التحكم الجديدة',
      },
      localizedMessages: {
        'en': 'Enhanced dashboard with real-time analytics and custom widgets available.',
        'ar': 'لوحة تحكم محسنة مع تحليلات فورية وودجات مخصصة متاحة.',
      },
      ),
      NotificationModel(
        id: 'app_${DateTime.now().millisecondsSinceEpoch + 2}',
        title: 'Security Update',
        message: 'Important security update installed. Your data is now more secure.',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        type: NotificationType.security,
        localizedTitles: {
        'en': 'Security Update',
        'ar': 'تحديث الأمان',
      },
      localizedMessages: {
        'en': 'Important security update installed. Your data is now more secure.',
        'ar': 'تم تثبيت تحديث أمان مهم. بياناتك الآن أكثر أماناً.',
      },
      ),
      NotificationModel(
        id: 'app_${DateTime.now().millisecondsSinceEpoch + 3}',
        title: 'Inventory Alert',
        message: 'Low stock alert for 5 products. Please review inventory levels.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.systemAlert,
        localizedTitles: {
        'en': 'Inventory Alert',
        'ar': 'تنبيه المخزون',
      },
      localizedMessages: {
        'en': 'Low stock alert for 5 products. Please review inventory levels.',
        'ar': 'تنبيه بمخزون منخفض لـ 5 منتجات. يرجى مراجعة مستويات المخزون.',
      },
      ),
      NotificationModel(
        id: 'app_${DateTime.now().millisecondsSinceEpoch + 4}',
        title: 'Backup Completed',
        message: 'Automatic system backup completed successfully at 2:00 AM.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: NotificationType.general,
        localizedTitles: {
        'en': 'Backup Completed',
        'ar': 'اكتمل النسخ الاحتياطي',
      },
      localizedMessages: {
        'en': 'Automatic system backup completed successfully at 2:00 AM.',
        'ar': 'تم الانتهاء من النسخ الاحتياطي التلقائي للنظام بنجاح الساعة 2:00 صباحاً.',
      },
      ),
    ];

    for (final notification in sampleNotifications) {
      await addNotification(notification);
    }
  }
}