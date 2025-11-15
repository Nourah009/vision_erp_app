import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/about_us_screen.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
import 'package:vision_erp_app/screens/app/login_page.dart';
import 'package:vision_erp_app/screens/app/profile_page.dart';
import 'package:vision_erp_app/screens/app/organization.dart';
import 'package:vision_erp_app/screens/app/notifications_page.dart'; // ✅ إضافة: لصفحة الإشعارات
import 'package:vision_erp_app/screens/app/subscription_page.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/services/auth_service.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class SidebarMenu extends StatefulWidget {
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

  const SidebarMenu({
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
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  Future<void> _handleLogout() async {
    Navigator.pop(context);
    await AuthService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }

  void _handleOrganizationTap() {
    Navigator.pop(context);
    
    if (widget.user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrganizationPage(user: widget.user!)),
      );
    }
  }

  // ✅ إضافة: دالة للانتقال لصفحة الإشعارات
  void _handleNotificationsTap() {
    Navigator.pop(context); // إغلاق السايدبار أولاً
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final isDarkMode = themeNotifier.isDarkMode;

    return Drawer(
      width: 280,
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
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
            _buildUserProfile(context, appLocalizations),
            Expanded(child: _buildMenuItems(context, themeNotifier, localizationService, appLocalizations)),
            _buildLogoutButton(context, appLocalizations, _handleLogout),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, AppLocalizations appLocalizations) {
    final hasUser = widget.user != null;
    final username = hasUser ? (widget.user!.username.isNotEmpty ? widget.user!.username : 'User') : widget.userName;
    final role = hasUser ? (widget.user!.role.isNotEmpty ? widget.user!.role : 'User Role') : widget.userRole;
    final department = hasUser ? (widget.user!.department.isNotEmpty == true ? widget.user!.department : '') : '';

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        
        if (hasUser) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user!)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (hasUser) ...[
                      Text(
                        role,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.textSecondary,
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
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ] else ...[
                      Text(
                        widget.userRole,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, ThemeNotifier themeNotifier, LocalizationService localizationService, AppLocalizations appLocalizations) {
    final hasUser = widget.user != null;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMenuSectionHeader(appLocalizations.main, themeNotifier.isDarkMode),
        
        _buildMenuOption(
          Icons.dashboard, 
          appLocalizations.dashboard, 
          widget.onDashboardTap,
          themeNotifier.isDarkMode
        ),

        if (hasUser) ...[
          _buildMenuOption(
            Icons.business,
            appLocalizations.organization, 
            _handleOrganizationTap,
            themeNotifier.isDarkMode
          ),
        ],

        _buildMenuOption(
          Icons.account_circle, 
          appLocalizations.myAccount, 
          () {
            Navigator.pop(context);
            
            if (widget.user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user!)),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
          },
          themeNotifier.isDarkMode
        ),

        // ✅ التعديل: استخدام الدالة الجديدة للإشعارات
        _buildMenuOption(
          Icons.notifications, 
          appLocalizations.notification, 
          _handleNotificationsTap, // ✅ استخدام الدالة الجديدة
          themeNotifier.isDarkMode
        ),

        _buildMenuOption(
  Icons.card_membership, 
  appLocalizations.mySubscription, 
  () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SubscriptionPage()),
    );
  },
  themeNotifier.isDarkMode
),

        const SizedBox(height: 20),

        _buildMenuSectionHeader(appLocalizations.settings, themeNotifier.isDarkMode),
        
        _buildLanguageOption(context, localizationService, appLocalizations, themeNotifier.isDarkMode),
        
        _buildThemeToggle(context, themeNotifier, appLocalizations),

        _buildMenuOption(
          Icons.refresh, 
          appLocalizations.resetIntro, 
          widget.onResetIntroTap,
          themeNotifier.isDarkMode
        ),

        const SizedBox(height: 20),

        _buildMenuSectionHeader(appLocalizations.moreInfo, themeNotifier.isDarkMode),
         _buildMenuOption(
        Icons.info, 
        appLocalizations.aboutUs, 
        () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()),
          );
        },
        themeNotifier.isDarkMode
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
          color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, VoidCallback onTap, bool isDarkMode) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor, size: 20),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          color: isDarkMode ? Colors.white : AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      dense: true,
      minVerticalPadding: 10,
    );
  }

  Widget _buildLanguageOption(BuildContext context, LocalizationService localizationService, AppLocalizations appLocalizations, bool isDarkMode) {
    return ListTile(
      leading: Icon(
        Icons.language, 
        color: AppColors.primaryColor,
        size: 20
      ),
      title: Text(
        appLocalizations.language,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          color: isDarkMode ? Colors.white : AppColors.textPrimary,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
        ),
        child: Text(
          localizationService.isEnglish() ? appLocalizations.english : appLocalizations.arabic,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
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

  Widget _buildThemeToggle(BuildContext context, ThemeNotifier themeNotifier, AppLocalizations appLocalizations) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
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
                  color: Theme.of(context).textTheme.bodyLarge?.color,
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
            },
            activeThumbColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AppLocalizations appLocalizations, VoidCallback? handleLogout) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton.icon(
          onPressed: handleLogout,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.logout, size: 18),
          label: Text(
            appLocalizations.logout,
            style: TextStyle(
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