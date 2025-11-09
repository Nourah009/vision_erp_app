import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/demo_system_page.dart';
import 'package:vision_erp_app/screens/app/dashboard_page.dart';
import 'package:vision_erp_app/screens/app/login_page.dart';
import 'package:vision_erp_app/screens/app/notification_dropdown.dart';
import 'package:vision_erp_app/screens/app/notifications_page.dart';
import 'package:vision_erp_app/screens/app/profile_page.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/bottom_navigation_bar.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/plan_pricing_section.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/recommendations_section.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/vision_erp_section.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/auth_service.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/services/shared_preferences_service.dart';
import 'package:vision_erp_app/screens/app/sidebar_menu.dart';
// إضافة خدمات الإشعارات
import 'package:vision_erp_app/services/notification_service.dart';
import 'package:vision_erp_app/services/auto_notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;
  bool _showNotifications = false;
  String _currentLanguage = 'en';
  UserModel? _currentUser;
  int _unreadNotificationsCount = 0; // عداد الإشعارات غير المقروءة

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _loadUnreadNotificationsCount();
    _startAutoNotifications();
  }

  @override
  void dispose() {
    // إيقاف الإشعارات التلقائية عند إغلاق الصفحة
    AutoNotificationService.stopAutoNotifications();
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    final user = await AuthService.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  // تحميل عدد الإشعارات غير المقروءة
  Future<void> _loadUnreadNotificationsCount() async {
    final count = await NotificationService.getUnreadCount();
    setState(() {
      _unreadNotificationsCount = count;
    });
  }

  // بدء الإشعارات التلقائية
  void _startAutoNotifications() {
    AutoNotificationService.startAutoNotifications(
      onNewNotification: (count) {
        setState(() {
          _unreadNotificationsCount = count;
        });
      },
    );
  }

  // التعامل مع فتح/إغلاق قائمة الإشعارات
  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  // تحديث عداد الإشعارات عند قراءة إشعار

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

  void _handleThemeChanged(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
    print('Theme changed to: ${isDarkMode ? 'Dark' : 'Light'}');
  }

  void _handleLanguageChanged(String languageCode) {
    // الحصول على خدمة الترجمة من الـ Provider
    final localizationService = Provider.of<LocalizationService>(context, listen: false);
    
    // تغيير اللغة فورياً
    localizationService.setLocale(Locale(languageCode, languageCode == 'en' ? 'US' : 'SA'));
    
    setState(() {
      _currentLanguage = languageCode;
    });
    
    print('Language changed to: $languageCode');
    
    // لا حاجة لحوار التأكيد مع التغيير الفوري
    _showLanguageChangeSuccessDialog();
  }

  void _showLanguageChangeSuccessDialog() {
    final isEnglish = _currentLanguage == 'en';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEnglish ? 'Language Changed' : 'تم تغيير اللغة',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          isEnglish 
            ? 'The language has been changed successfully!'
            : 'تم تغيير اللغة بنجاح!',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'OK' : 'موافق',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // دالة الانتقال لصفحة جميع الإشعارات
void _navigateToAllNotifications() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const NotificationsPage(),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    return Scaffold(
      backgroundColor:  isDarkMode ? Colors.grey[900] : AppColors.backgroundColor,
      endDrawer: _buildSidebarMenu(context),
      appBar: _buildAppBar(context),
      body: 
      Stack(
  children: [
    _buildBody(context),
    if (_showNotifications)
      NotificationDropdown(
        onClose: () {
          if (mounted) {
            setState(() {
              _showNotifications = false;
            });
          }
        },
        onNotificationRead: () {
          if (mounted) {
            _loadUnreadNotificationsCount();
          }
        },
        onViewAll: _navigateToAllNotifications, // ✅ استخدام الدالة الجديدة
      ),
  ],
),
      bottomNavigationBar: Builder(
        builder: (context) => CustomBottomNavigationBar(
          currentIndex: 0,
          onHomeTap: () {
            // Already on home page
          },
          onDemoTap: _currentUser != null ? null : () {
            // زر الديمو يظهر فقط عند عدم تسجيل الدخول
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DemoSystemPage()),
            );
          },
          onDashboardTap: _currentUser != null ? () {
            // زر الداشبورد يظهر فقط عند تسجيل الدخول
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage(user: _currentUser!)),
            );
          } : null,
          onProfileTap: _currentUser != null ? () {
            // زر البروفايل ينتقل لصفحة البروفايل إذا كان المستخدم مسجل الدخول
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: _currentUser!)),
            );
          } : () {
            // إذا لم يكن مسجل الدخول، ينتقل لصفحة تسجيل الدخول
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }, 
          onMenuTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          // تمرير حالة المستخدم للبوتوم نافيغيشن
          isUserLoggedIn: _currentUser != null,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Welcome text on LEFT - ديناميكي بناءً على حالة المستخدم
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 14,
                    tablet: 16,
                    desktop: 18,
                  ),
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                _currentUser != null ? _currentUser!.username : 'To vision ERP',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 16,
                    tablet: 18,
                    desktop: 20,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
// Bell icon on RIGHT مع عداد الإشعارات
Stack(
  children: [
    IconButton(
      icon: Icon(
        Icons.notifications_outlined,
        color: AppColors.secondaryColor,
      ),
      onPressed: _toggleNotifications, // فتح/إغلاق قائمة الإشعارات
    ),
    if (_unreadNotificationsCount > 0)
      Positioned(
        right: 8,  // مسافة من الحافة اليمنى
        top: 8,    // مسافة من الحافة العلوية للأيقونة - ليست kToolbarHeight!
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recommendations Section
          RecommendationsSection(responsiveValue: _responsiveValue),

          SizedBox(
            height: _responsiveValue(
              context,
              mobile: 20,
              tablet: 25,
              desktop: 30,
            ),
          ),

          // "Move towards a better future" text
          Padding(
            padding: EdgeInsets.only(
              left: _responsiveValue(
                context,
                mobile: 16,
                tablet: 20,
                desktop: 24,
              ),
            ),
            child: Text(
              'Move towards a better future',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: _responsiveValue(
                  context,
                  mobile: 18,
                  tablet: 20,
                  desktop: 22,
                ),
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          SizedBox(
            height: _responsiveValue(
              context,
              mobile: 8,
              tablet: 10,
              desktop: 12,
            ),
          ),

          // Vision ERP Section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _responsiveValue(
                context,
                mobile: 16,
                tablet: 20,
                desktop: 24,
              ),
            ),
            child: VisionERPSection(responsiveValue: _responsiveValue),
          ),

          SizedBox(
            height: _responsiveValue(
              context,
              mobile: 20,
              tablet: 25,
              desktop: 30,
            ),
          ),

          // Plan and Pricing Section
          PlanPricingSection(responsiveValue: _responsiveValue),
        ],
      ),
    );
  }

  Widget _buildSidebarMenu(BuildContext context) {
    return SidebarMenu(
      user: _currentUser,
      userName: _currentUser != null ? _currentUser!.username : 'Welcome',
      userRole: _currentUser != null ? _currentUser!.role : 'to Vision ERP',
      onMyAccountTap: () {
        Navigator.pop(context);
        if (_currentUser != null) {
          // الانتقال لصفحة البروفايل إذا كان مسجل الدخول
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(user: _currentUser!)),
          );
        } else {
          // الانتقال لتسجيل الدخول إذا لم يكن مسجل الدخول
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      onNotificationTap: () {
        Navigator.pop(context);
        _toggleNotifications(); // فتح قائمة الإشعارات من السايدبار
      },
      onMySubscriptionTap: () {
        Navigator.pop(context);
      },
      onLanguageTap: () {
        Navigator.pop(context);
      },
      onAboutUsTap: () {
        Navigator.pop(context);
      },
      onResetIntroTap: () async {
        Navigator.pop(context);
        await SharedPreferencesService.resetIntroShown();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Intro reset - restart app to see intro again'),
            backgroundColor: AppColors.secondaryColor,
          ),
        );
      }, 
      onDashboardTap: () {
        Navigator.pop(context);
        if (_currentUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage(user: _currentUser!)),
          );
        }
      },
      onThemeChanged: _handleThemeChanged,
      onLanguageChanged: _handleLanguageChanged, 
      onOrganizationTap: () {  },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_isDarkMode', _isDarkMode));
    properties.add(DiagnosticsProperty<String>('_currentLanguage', _currentLanguage));
    properties.add(DiagnosticsProperty<UserModel?>('_currentUser', _currentUser));
    properties.add(DiagnosticsProperty<int>('_unreadNotificationsCount', _unreadNotificationsCount));
  }
}