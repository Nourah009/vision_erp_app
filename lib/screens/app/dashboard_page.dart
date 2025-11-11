import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/floating_messages_button.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
import 'package:vision_erp_app/screens/app/notification_dropdown.dart';
import 'package:vision_erp_app/screens/app/organization.dart';
import 'package:vision_erp_app/screens/app/profile_page.dart';
import 'package:vision_erp_app/screens/app/sidebar_menu.dart';
import 'package:vision_erp_app/screens/app/notifications_page.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/dashboard_bottom_navigation_bar.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/recent_activity_section.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/task_schedule_section.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/user_profile_section.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/notification_service.dart';
import 'package:vision_erp_app/services/auto_notification_service.dart';

class DashboardPage extends StatefulWidget {
  final UserModel user;
  
  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _showNotifications = false;
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUnreadNotificationsCount();
    _startAutoNotifications();
  }

  @override
  void dispose() {
    AutoNotificationService.stopAutoNotifications();
    super.dispose();
  }

  Future<void> _loadUnreadNotificationsCount() async {
    final count = await NotificationService.getUnreadCount();
    setState(() {
      _unreadNotificationsCount = count;
    });
  }

  void _startAutoNotifications() {
    AutoNotificationService.startAutoNotifications(
      onNewNotification: (count) {
        setState(() {
          _unreadNotificationsCount = count;
        });
      },
    );
  }

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  void _onNotificationRead() {
    _loadUnreadNotificationsCount();
  }

  void _navigateToAllNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
  }

  // Responsive value calculator
  double _responsiveValue(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200 && desktop != null) {
      return desktop;
    } else if (width >= 600 && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    final AppLocalizations() = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : AppColors.backgroundColor,
      endDrawer: _buildSidebarMenu(context),
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildBody(context),
          // ✅ إضافة: NotificationDropdown هنا
          if (_showNotifications)
            NotificationDropdown(
              onClose: () {
                setState(() {
                  _showNotifications = false;
                });
              },
              onNotificationRead: _onNotificationRead,
              onViewAll: _navigateToAllNotifications,
            ),
            const FloatingMessagesButton(),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (context) => DashboardBottomNavigationBar(
          currentIndex: 1,
          onHomeTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          onDashboardTap: () {
            // Already on dashboard page
          },
          onProfileTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final AppLocalizations() = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile info on LEFT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isEnglish ? 'Hello,' : 'مرحباً،',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 16,
                    tablet: 18,
                    desktop: 20,
                  ),
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                '${widget.user.username}!',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 18,
                    tablet: 20,
                    desktop: 22,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          // جرس الإشعارات مع العداد
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.secondaryColor,
                ),
                onPressed: _toggleNotifications,
              ),
              if (_unreadNotificationsCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _unreadNotificationsCount > 99 
                          ? '99+' 
                          : _unreadNotificationsCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final AppLocalizations() = AppLocalizations.of(context)!;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Profile Section
          UserProfileSection(
            responsiveValue: _responsiveValue,
            user: widget.user,
          ),

          SizedBox(
            height: _responsiveValue(
              context,
              mobile: 20,
              tablet: 25,
              desktop: 30,
            ),
          ),

          // Recent Activity Section with 4 boxes and charts
          RecentActivitySection(responsiveValue: _responsiveValue),

          SizedBox(
            height: _responsiveValue(
              context,
              mobile: 20,
              tablet: 25,
              desktop: 30,
            ),
          ),

          // Task Schedule Section
          TaskScheduleSection(responsiveValue: _responsiveValue),
        ],
      ),
    );
  }

  Widget _buildSidebarMenu(BuildContext context) {
    final AppLocalizations() = AppLocalizations.of(context)!;
    
    return SidebarMenu(
      user: widget.user,
      userName: widget.user.username,
      userRole: widget.user.role,
      onOrganizationTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrganizationPage(user: widget.user)),
        );
      },
      onMyAccountTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)),
        );
      },
      onNotificationTap: () {
        Navigator.pop(context);
        _navigateToAllNotifications();
      },
      onMySubscriptionTap: () {
        Navigator.pop(context);
        _showSubscriptionDialog(context);
      },
      onLanguageTap: () {
        Navigator.pop(context);
        _showLanguageDialog(context);
      },
      onAboutUsTap: () {
        Navigator.pop(context);
        _showAboutUsDialog(context);
      },
      onResetIntroTap: () {
        Navigator.pop(context);
      },
      onDashboardTap: () {
        Navigator.pop(context);
      },
      onThemeChanged: (bool isDarkMode) {
        // يمكن إضافة تغيير الثيم هنا
      },
      onLanguageChanged: (String languageCode) {
        // يمكن إضافة تغيير اللغة هنا
      },
    );
  }

  void _showSubscriptionDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          appLocalizations.mySubscription,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          isEnglish 
            ? 'Subscription management is under development.'
            : 'إدارة الاشتراك قيد التطوير.',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'OK' : 'موافق',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          appLocalizations.language,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          isEnglish 
            ? 'Language selection is under development.'
            : 'اختيار اللغة قيد التطوير.',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'OK' : 'موافق',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutUsDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          appLocalizations.aboutUs,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          isEnglish
            ? 'Vision ERP - Powering Digital Transformation\n\nVersion 1.0.0'
            : 'Vision ERP - دفع التحول الرقمي\n\nالإصدار 1.0.0',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'OK' : 'موافق',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}