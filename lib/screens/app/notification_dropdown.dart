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
  final VoidCallback? onViewAll;

  const NotificationDropdown({
    super.key, 
    required this.onClose, 
    required this.onNotificationRead,
    this.onViewAll,
  });

  @override
  State<NotificationDropdown> createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  bool _isDisposed = false;
  LocalizationService? _localizationService;

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
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 16), // ✅ تصغير الخط
        ),
        content: Text(
          notification.message,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 14), // ✅ تصغير الخط
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Done',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 14), // ✅ تصغير الخط
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
            Icon(notification.type.icon, color: AppColors.primaryColor, size: 20), // ✅ تصغير الأيقونة
            const SizedBox(width: 8),
            Text(
              notification.title,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 16), // ✅ تصغير الخط
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14), // ✅ تصغير الخط
            ),
            const SizedBox(height: 8),
            Text(
              _formatDate(notification.timestamp),
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[600],
                fontSize: 12, // ✅ تصغير الخط
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'إغلاق',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 14), // ✅ تصغير الخط
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _handleViewAll() {
    if (_isDisposed || !mounted) return;
    
    widget.onClose();
    
    if (widget.onViewAll != null) {
      widget.onViewAll!();
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
          top: 4,
          right: 15,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 320, // ✅ تصغير العرض من 350 إلى 320
              height: 400, // ✅ تصغير الارتفاع من 500 إلى 400
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
                    padding: const EdgeInsets.all(12), // ✅ تصغير padding
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
                            fontSize: 16, // ✅ تصغير حجم الخط
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
                                fontSize: 10, // ✅ تصغير حجم الخط
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
                                      size: 48, // ✅ تصغير حجم الأيقونة
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 12), // ✅ تصغير المسافة
                                    Text(
                                      isEnglish ? 'No notifications' : 'لا توجد إشعارات',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: Colors.grey[600],
                                        fontSize: 14, // ✅ تصغير حجم الخط
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

                  // زر "View All" في الأسفل
                  if (_notifications.isNotEmpty) _buildViewAllButton(isEnglish),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllButton(bool isEnglish) {
    return Container(
      padding: const EdgeInsets.all(8), // ✅ تصغير padding
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // ✅ تصغير padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          icon: const Icon(
            Icons.list_alt,
            size: 16, // ✅ تصغير حجم الأيقونة
          ),
          label: Text(
            isEnglish ? 'View All Notifications' : 'عرض جميع الإشعارات',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12, // ✅ تصغير حجم الخط
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
        padding: const EdgeInsets.only(right: 12), // ✅ تصغير padding
        child: const Icon(Icons.delete, color: Colors.white, size: 18), // ✅ تصغير الأيقونة
      ),
      onDismissed: (direction) => _deleteNotification(notification.id),
      child: ListTile(
        dense: true, // ✅ جعل الـ ListTile أكثر كثافة
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // ✅ تصغير padding
        leading: Container(
          width: 32, // ✅ تصغير الحجم
          height: 32, // ✅ تصغير الحجم
          decoration: BoxDecoration(
            color: notification.type.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.type.icon,
            color: notification.type.color,
            size: 16, // ✅ تصغير حجم الأيقونة
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
            color: notification.isRead ? Colors.grey[600] : Colors.black,
            fontSize: 12, // ✅ تصغير حجم الخط
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10, // ✅ تصغير حجم الخط
                color: notification.isRead ? Colors.grey[500] : Colors.grey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2), // ✅ تصغير المسافة
            Text(
              _formatDate(notification.timestamp),
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 8, // ✅ تصغير حجم الخط
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? Container(
                width: 6, // ✅ تصغير الحجم
                height: 6, // ✅ تصغير الحجم
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