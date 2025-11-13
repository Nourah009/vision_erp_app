// screens/app/notifications_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/models/notification_model.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
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
      final appLocalizations = AppLocalizations.of(context);
      if (appLocalizations == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      
      final languageCode = appLocalizations.locale.languageCode;
      final notifications = await NotificationService.getTranslatedNotifications(languageCode);
      
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
    _loadNotifications();
  }

  Future<void> _markAllAsRead() async {
    await NotificationService.markAllAsRead();
    _loadNotifications();
    
    final appLocalizations = AppLocalizations.of(context);
    final isEnglish = appLocalizations?.locale.languageCode == 'en';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEnglish ? 'All notifications marked as read' : 'تم تعيين جميع الإشعارات كمقروءة'
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  Future<void> _deleteNotification(String notificationId) async {
    await NotificationService.deleteNotification(notificationId);
    _loadNotifications();
    
    final appLocalizations = AppLocalizations.of(context);
    final isEnglish = appLocalizations?.locale.languageCode == 'en';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEnglish ? 'Notification deleted' : 'تم حذف الإشعار'
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }

  void _handleNotificationTap(NotificationModel notification) {
    if (!notification.isRead) {
      _markAsRead(notification.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    if (appLocalizations == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isEnglish = appLocalizations.locale.languageCode == 'en';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          isEnglish ? 'Notifications' : 'الإشعارات',
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_unreadNotifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              onPressed: _markAllAsRead,
              tooltip: isEnglish ? 'Mark all as read' : 'تعيين الكل كمقروء',
              color: Colors.white,
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadNotifications,
            tooltip: isEnglish ? 'Refresh' : 'تحديث',
            color: Colors.white,
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
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
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
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
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
                fontWeight: FontWeight.bold,
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
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadNotifications,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: Text(
                isEnglish ? 'Refresh' : 'تحديث',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNotifications,
      backgroundColor: AppColors.primaryColor,
      color: Colors.white,
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
                  _formatDate(notification.timestamp, isEnglish),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Colors.grey[400],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: notification.type.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getTypeText(notification.type, isEnglish),
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      color: notification.type.color,
                      fontWeight: FontWeight.w600,
                    ),
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
                icon: Icon(
                  Icons.mark_email_read,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
                onPressed: () => _markAsRead(notification.id),
                tooltip: isEnglish ? 'Mark as read' : 'تعيين كمقروء',
              ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                size: 20,
                color: Colors.red,
              ),
              onPressed: () => _showDeleteDialog(notification, isEnglish),
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
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
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
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteNotification(notification.id);
            },
            child: Text(
              isEnglish ? 'Delete' : 'حذف',
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date, bool isEnglish) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes < 1) {
          return isEnglish ? 'Just now' : 'الآن';
        }
        return isEnglish 
          ? '${difference.inMinutes} min ago'
          : 'منذ ${difference.inMinutes} دقيقة';
      }
      return isEnglish
        ? '${difference.inHours} h ago'
        : 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays == 1) {
      return isEnglish ? 'Yesterday' : 'أمس';
    } else if (difference.inDays < 7) {
      return isEnglish
        ? '${difference.inDays} days ago'
        : 'منذ ${difference.inDays} يوم';
    } else {
      return isEnglish
        ? '${date.day}/${date.month}/${date.year}'
        : '${date.day}/${date.month}/${date.year}';
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
    properties.add(IterableProperty<NotificationModel>('_unreadNotifications', _unreadNotifications));
    properties.add(IterableProperty<NotificationModel>('_readNotifications', _readNotifications));
    properties.add(DiagnosticsProperty<bool>('_isLoading', _isLoading));
  }
}