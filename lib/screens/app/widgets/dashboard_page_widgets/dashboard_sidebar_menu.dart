import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
import 'package:vision_erp_app/screens/app/login_page.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/services/auth_service.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class DashboardSidebarMenu extends StatefulWidget {
  final UserModel? user;
  final String userName;
  final String userRole;
  final VoidCallback onMyAccountTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onMySubscriptionTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onAboutUsTap;
  final VoidCallback onResetIntroTap;
  final VoidCallback onDashboardTap;
  final VoidCallback onOrganizationTap;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;

  const DashboardSidebarMenu({
    super.key,
    this.user,
    required this.userName,
    required this.userRole,
    required this.onMyAccountTap,
    required this.onNotificationTap,
    required this.onMySubscriptionTap,
    required this.onLanguageTap,
    required this.onAboutUsTap,
    required this.onResetIntroTap,
    required this.onDashboardTap,
    required this.onOrganizationTap,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<DashboardSidebarMenu> createState() => _DashboardSidebarMenuState();
}

class _DashboardSidebarMenuState extends State<DashboardSidebarMenu> {
  Future<void> _handleLogout() async {
    // إغلاق السايدبار أولاً
    Navigator.pop(context);
    
    // تسجيل الخروج من الخدمة
    await AuthService.logout();
    
    // الانتقال إلى صفحة الهوم بيج
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false, // إزالة جميع الصفحات من الستاك
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localizationService = Provider.of<LocalizationService>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final isDarkMode = themeNotifier.isDarkMode;

    return Drawer(
      width: 280,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserProfile(context, appLocalizations, isDarkMode),
            Expanded(child: _buildMenuItems(context, themeNotifier, localizationService, appLocalizations, isDarkMode)),
            _buildLogoutButton(context, appLocalizations, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, AppLocalizations appLocalizations, bool isDarkMode) {
    // التحقق الآمن من وجود المستخدم
    final hasUser = widget.user != null;
    final username = hasUser ? (widget.user!.username.isNotEmpty ? widget.user!.username : 'User') : widget.userName;
    final role = hasUser ? (widget.user!.role.isNotEmpty ? widget.user!.role : 'User Role') : widget.userRole;
    final department = hasUser ? (widget.user!.department.isNotEmpty == true ? widget.user!.department : '') : '';

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (hasUser) {
          // إذا كان مسجل الدخول، انتقل للبروفايل
          widget.onMyAccountTap();
        } else {
          // إذا لم يكن مسجل الدخول، انتقل لتسجيل الدخول
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عرض اسم المستخدم
                    Text(
                      username,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // عرض الرتبة والقسم إذا كان مسجل الدخول
                    if (hasUser) ...[
                      Text(
                        role,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // ignore: unnecessary_null_comparison
                      if (department != null && department.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          department,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ] else ...[
                      // إذا لم يكن مسجل الدخول، عرض النص الافتراضي
                      Text(
                        widget.userRole,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, ThemeNotifier themeNotifier, 
      LocalizationService localizationService, AppLocalizations appLocalizations, bool isDarkMode) {
    final hasUser = widget.user != null;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMenuSectionHeader(appLocalizations.main, isDarkMode),
        
        // Dashboard option - show for all users
        _buildMenuOption(
          Icons.dashboard, 
          appLocalizations.dashboard, 
          widget.onDashboardTap,
          isDarkMode
        ),

        // Organization option - only for logged in users
        if (hasUser) ...[
          _buildMenuOption(
            Icons.business, 
            appLocalizations.organization, 
            widget.onOrganizationTap,
            isDarkMode
          ),
        ],

        _buildMenuOption(
          Icons.account_circle, 
          appLocalizations.myAccount, 
          widget.onMyAccountTap,
          isDarkMode
        ),
        _buildMenuOption(
          Icons.notifications, 
          appLocalizations.notification, 
          widget.onNotificationTap,
          isDarkMode
        ),
        _buildMenuOption(
          Icons.card_membership, 
          appLocalizations.mySubscription, 
          widget.onMySubscriptionTap,
          isDarkMode
        ),

        const SizedBox(height: 20),

        _buildMenuSectionHeader(appLocalizations.settings, isDarkMode),
        _buildLanguageOption(context, localizationService, appLocalizations, isDarkMode),
        _buildThemeToggle(context, themeNotifier, appLocalizations, isDarkMode),

        _buildMenuOption(
          Icons.refresh, 
          appLocalizations.resetIntro, 
          widget.onResetIntroTap,
          isDarkMode
        ),

        const SizedBox(height: 20),

        _buildMenuSectionHeader(appLocalizations.moreInfo, isDarkMode),
        _buildMenuOption(
          Icons.info, 
          appLocalizations.aboutUs, 
          widget.onAboutUsTap,
          isDarkMode
        ),
      ],
    );
  }

  Widget _buildMenuSectionHeader(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, VoidCallback onTap, bool isDarkMode) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      dense: true,
      minVerticalPadding: 10,
    );
  }

  Widget _buildLanguageOption(BuildContext context, LocalizationService localizationService, 
      AppLocalizations appLocalizations, bool isDarkMode) {
    return ListTile(
      leading: Icon(
        Icons.language, 
        color: Theme.of(context).primaryColor,
        size: 20
      ),
      title: Text(
        appLocalizations.language,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
          ),
        ),
        child: Text(
          localizationService.isEnglish() ? appLocalizations.english : appLocalizations.arabic,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      onTap: () {
        widget.onLanguageChanged(localizationService.isEnglish() ? 'ar' : 'en');
      },
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      dense: true,
      minVerticalPadding: 10,
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeNotifier themeNotifier, 
      AppLocalizations appLocalizations, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                themeNotifier.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                themeNotifier.isDarkMode ? appLocalizations.darkMode : appLocalizations.lightMode,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          Switch(
            value: themeNotifier.isDarkMode,
            onChanged: (value) {
              if (value) {
                themeNotifier.setDarkTheme();
              } else {
                themeNotifier.setLightTheme();
              }
              widget.onThemeChanged(value);
            },
            activeColor: Theme.of(context).primaryColor,
            activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AppLocalizations appLocalizations, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton.icon(
          onPressed: _handleLogout,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.logout, size: 18),
          label: Text(
            appLocalizations.logout,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}