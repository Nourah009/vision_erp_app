// screens/app/widgets/notification_dropdown.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/notification_model.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/services/notification_service.dart';

class NotificationDropdown extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onNotificationRead;
  final VoidCallback? onViewAll; // ✅ إضافة: معامل اختياري لزر View All

  const NotificationDropdown({
    super.key, 
    required this.onClose, 
    required this.onNotificationRead,
    this.onViewAll, // ✅ إضافة: معامل اختياري
  });

  @override
  State<NotificationDropdown> createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  bool _isDisposed = false;
  LocalizationService? _localizationService; // ✅ تخزين الـ Provider

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizationService ??= Provider.of<LocalizationService>(context, listen: false);
    _localizationService?.addListener(_loadNotifications);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _localizationService?.removeListener(_loadNotifications);
    super.dispose();
  }

  void _safeSetState(VoidCallback fn) {
    if (!_isDisposed && mounted) {
      setState(fn);
    }
  }

  Future<void> _loadNotifications() async {
    if (_isDisposed || !mounted) return;
    
    try {
      final languageCode = _localizationService?.currentLocale.languageCode ?? 'en';
      final notifications = await NotificationService.getTranslatedNotifications(languageCode);
      
      _safeSetState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading notifications: $e');
      _safeSetState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    if (_isDisposed || !mounted) return;
    
    await NotificationService.markAsRead(notificationId);
    _loadNotifications();
    
    if (!_isDisposed && mounted) {
      widget.onNotificationRead();
    }
  }

  Future<void> _markAllAsRead() async {
    if (_isDisposed || !mounted) return;
    
    await NotificationService.markAllAsRead();
    _loadNotifications();
    
    if (!_isDisposed && mounted) {
      widget.onNotificationRead();
    }
  }

  Future<void> _deleteNotification(String notificationId) async {
    if (_isDisposed || !mounted) return;
    
    await NotificationService.deleteNotification(notificationId);
    _loadNotifications();
    
    if (!_isDisposed && mounted) {
      widget.onNotificationRead();
    }
  }

  void _handleNotificationTap(NotificationModel notification) {
    if (_isDisposed || !mounted) return;
    
    _markAsRead(notification.id);
    
    switch (notification.type) {
      case NotificationType.salesReport:
        _handleSalesReportNotification(notification);
        break;
      case NotificationType.systemAlert:
        _handleSystemAlertNotification(notification);
        break;
      default:
        _showNotificationDetails(notification);
    }
  }

  void _handleSalesReportNotification(NotificationModel notification) {
    if (_isDisposed || !mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('فتح تقرير المبيعات: ${notification.title}'),
        backgroundColor: AppColors.primaryColor,
      ),
    );
    
    if (!_isDisposed && mounted) {
      widget.onClose();
    }
  }

  void _handleSystemAlertNotification(NotificationModel notification) {
    if (_isDisposed || !mounted) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          notification.title,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          notification.message,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Done',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
    if (_isDisposed || !mounted) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(notification.type.icon, color: AppColors.primaryColor),
            const SizedBox(width: 8),
            Text(
              notification.title,
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 8),
            Text(
              _formatDate(notification.timestamp),
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'إغلاق',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  // ✅ إضافة: دالة للتعامل مع زر "View All"
  void _handleViewAll() {
    if (_isDisposed || !mounted) return;
    
    widget.onClose(); // إغلاق dropdown أولاً
    
    if (widget.onViewAll != null) {
      widget.onViewAll!(); // الانتقال لصفحة جميع الإشعارات
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final isEnglish = localizationService.isEnglish();

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              if (!_isDisposed && mounted) {
                widget.onClose();
              }
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        
        Positioned(
          top: kToolbarHeight - 10,
          right: 16,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 350,
              height: 500, // ✅ زيادة الارتفاع لاستيعاب الزر الجديد
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEnglish ? 'Notifications' : 'الإشعارات',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_notifications.any((n) => !n.isRead))
                          TextButton(
                            onPressed: _markAllAsRead,
                            child: Text(
                              isEnglish ? 'Mark all as read' : 'تعيين الكل كمقروء',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // قائمة الإشعارات
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _notifications.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.notifications_none,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      isEnglish ? 'No notifications' : 'لا توجد إشعارات',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _notifications.length,
                                itemBuilder: (context, index) {
                                  final notification = _notifications[index];
                                  return _buildNotificationItem(notification, isEnglish);
                                },
                              ),
                  ),

                  // ✅ إضافة: زر "View All" في الأسفل
                  if (_notifications.isNotEmpty) _buildViewAllButton(isEnglish),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ إضافة: ويدجت زر "View All"
  Widget _buildViewAllButton(bool isEnglish) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _handleViewAll,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          icon: const Icon(
            Icons.list_alt,
            size: 18,
          ),
          label: Text(
            isEnglish ? 'View All Notifications' : 'عرض جميع الإشعارات',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification, bool isEnglish) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => _deleteNotification(notification.id),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.type.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.type.icon,
            color: notification.type.color,
            size: 20,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
            color: notification.isRead ? Colors.grey[600] : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: notification.isRead ? Colors.grey[500] : Colors.grey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(notification.timestamp),
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () => _handleNotificationTap(notification),
      ),
    );
  }
}