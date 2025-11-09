// screens/app/notifications_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/notification_model.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/services/notification_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with SingleTickerProviderStateMixin {
  
  late TabController _tabController;
  List<NotificationModel> _allNotifications = [];
  List<NotificationModel> _unreadNotifications = [];
  List<NotificationModel> _readNotifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    try {
      final notifications = await NotificationService.getNotifications();
      
      setState(() {
        _allNotifications = notifications;
        _unreadNotifications = notifications.where((n) => !n.isRead).toList();
        _readNotifications = notifications.where((n) => n.isRead).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading notifications: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    await NotificationService.markAsRead(notificationId);
    _loadNotifications(); // إعادة تحميل البيانات
  }

  Future<void> _markAllAsRead() async {
    await NotificationService.markAllAsRead();
    _loadNotifications(); // إعادة تحميل البيانات
  }

  Future<void> _deleteNotification(String notificationId) async {
    await NotificationService.deleteNotification(notificationId);
    _loadNotifications(); // إعادة تحميل البيانات
  }

  void _handleNotificationTap(NotificationModel notification) {
    if (!notification.isRead) {
      _markAsRead(notification.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final isEnglish = localizationService.isEnglish();

    return Scaffold(
      backgroundColor: Colors.white,
       // screens/app/notifications_page.dart
appBar: AppBar(
  backgroundColor: AppColors.primaryColor,
  foregroundColor: Colors.white,
  elevation: 0,
  automaticallyImplyLeading: true,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    color: AppColors.secondaryColor,
    onPressed: () {
      Navigator.pop(context); // ✅ الرجوع فقط للصفحة السابقة
    },
  ),
  title: Text(
    isEnglish ? 'Notifications' : 'الإشعارات',
    style: const TextStyle(
      fontFamily: 'Cairo',
      color: Colors.white,
    ),
  ),
  actions: [
    if (_unreadNotifications.isNotEmpty)
      IconButton(
        icon: const Icon(Icons.check_circle_outline),
        onPressed: _markAllAsRead,
        tooltip: isEnglish ? 'Mark all as read' : 'تعيين الكل كمقروء',
      ),
  ],
),
      body: Column(
        children: [
          // تبويبات الأعلى
          Container(
            color: AppColors.primaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.white
              ),
              tabs: [
                Tab(
                  text: isEnglish ? 
                    'Unread (${_unreadNotifications.length})' : 
                    'غير مقروء (${_unreadNotifications.length})',
                ),
                Tab(
                  text: isEnglish ? 
                    'Read (${_readNotifications.length})' : 
                    'مقروء (${_readNotifications.length})',
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // تبويب الإشعارات غير المقروءة
                _buildNotificationsList(_unreadNotifications, isEnglish, false),
                
                // تبويب الإشعارات المقروءة
                _buildNotificationsList(_readNotifications, isEnglish, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationModel> notifications, bool isEnglish, bool isReadTab) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isReadTab ? Icons.mark_email_read : Icons.notifications_none,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isReadTab ? 
                (isEnglish ? 'No read notifications' : 'لا توجد إشعارات مقروءة') :
                (isEnglish ? 'No unread notifications' : 'لا توجد إشعارات غير مقروءة'),
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isEnglish ? 
                'All notifications are up to date' : 
                'جميع الإشعارات محدثة',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNotifications,
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationItem(notification, isEnglish, isReadTab);
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification, bool isEnglish, bool isReadTab) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: notification.type.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.type.icon,
            color: notification.type.color,
            size: 24,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: isReadTab ? FontWeight.normal : FontWeight.bold,
            color: isReadTab ? Colors.grey[600] : Colors.black,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: isReadTab ? Colors.grey[500] : Colors.grey[700],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDate(notification.timestamp),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Colors.grey[400],
                  ),
                ),
                const Spacer(),
                Text(
                  _getTypeText(notification.type, isEnglish),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: notification.type.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isReadTab)
              IconButton(
                icon: const Icon(Icons.mark_as_unread, size: 20),
                onPressed: () => _markAsRead(notification.id),
                color: AppColors.primaryColor,
                tooltip: isEnglish ? 'Mark as read' : 'تعيين كمقروء',
              ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () => _showDeleteDialog(notification, isEnglish),
              color: Colors.red,
              tooltip: isEnglish ? 'Delete' : 'حذف',
            ),
          ],
        ),
        onTap: () => _handleNotificationTap(notification),
      ),
    );
  }

  void _showDeleteDialog(NotificationModel notification, bool isEnglish) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEnglish ? 'Delete Notification' : 'حذف الإشعار',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          isEnglish ? 
            'Are you sure you want to delete this notification?' : 
            'هل أنت متأكد من أنك تريد حذف هذا الإشعار؟',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'Cancel' : 'إلغاء',
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteNotification(notification.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isEnglish ? 'Notification deleted' : 'تم حذف الإشعار',
                  ),
                  backgroundColor: AppColors.secondaryColor,
                ),
              );
            },
            child: Text(
              isEnglish ? 'Delete' : 'حذف',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} min ago';
      }
      return '${difference.inHours} h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _getTypeText(NotificationType type, bool isEnglish) {
    switch (type) {
      case NotificationType.salesReport:
        return isEnglish ? 'Sales' : 'مبيعات';
      case NotificationType.systemAlert:
        return isEnglish ? 'System' : 'النظام';
      case NotificationType.userActivity:
        return isEnglish ? 'User' : 'مستخدم';
      case NotificationType.reminder:
        return isEnglish ? 'Reminder' : 'تذكير';
      case NotificationType.general:
        return isEnglish ? 'General' : 'عام';
      case NotificationType.newFeature:
        return isEnglish ? 'New Feature' : 'ميزة جديدة';
      case NotificationType.maintenance:
        return isEnglish ? 'Maintenance' : 'صيانة';
      case NotificationType.security:
        return isEnglish ? 'Security' : 'أمان';
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<NotificationModel>('_allNotifications', _allNotifications));
  }
}