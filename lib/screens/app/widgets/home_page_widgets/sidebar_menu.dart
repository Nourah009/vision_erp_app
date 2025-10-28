import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/login_page.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class SidebarMenu extends StatefulWidget {
  final VoidCallback onMyAccountTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onMySubscriptionTap;
  final VoidCallback onAboutUsTap;
  final VoidCallback onResetIntroTap;

  const SidebarMenu({
    Key? key,
    required this.onMyAccountTap,
    required this.onNotificationTap,
    required this.onMySubscriptionTap,
    required this.onAboutUsTap,
    required this.onResetIntroTap, required String userName, required String userRole, required Null Function() onLanguageTap, required Null Function() onDashboardTap, required void Function(bool isDarkMode) onThemeChanged, required void Function(String languageCode) onLanguageChanged,
  }) : super(key: key);

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localizationService = Provider.of<LocalizationService>(context);
    final appLocalizations = AppLocalizations.of(context);

    return Drawer(
      width: 280,
      backgroundColor: themeNotifier.isDarkMode ? Colors.grey[900] : Colors.white,
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
            _buildLogoutButton(context, appLocalizations),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, AppLocalizations appLocalizations) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
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
                child: Icon(Icons.person, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.welcome,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      appLocalizations.toVisionERP,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
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
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildMenuSectionHeader('MAIN', themeNotifier.isDarkMode),
        _buildMenuOption(
          Icons.account_circle, 
          appLocalizations.myAccount, 
          widget.onMyAccountTap,
          themeNotifier.isDarkMode
        ),
        _buildMenuOption(
          Icons.notifications, 
          appLocalizations.notification, 
          widget.onNotificationTap,
          themeNotifier.isDarkMode
        ),
        _buildMenuOption(
          Icons.card_membership, 
          appLocalizations.mySubscription, 
          widget.onMySubscriptionTap,
          themeNotifier.isDarkMode
        ),

        SizedBox(height: 20),

        _buildMenuSectionHeader('SETTINGS', themeNotifier.isDarkMode),
        _buildLanguageOption(context, localizationService, appLocalizations, themeNotifier.isDarkMode),
        _buildThemeToggle(context, themeNotifier, appLocalizations),

        _buildMenuOption(
          Icons.refresh, 
          appLocalizations.resetIntro, 
          widget.onResetIntroTap,
          themeNotifier.isDarkMode
        ),

        SizedBox(height: 20),

        _buildMenuSectionHeader('MORE INFO', themeNotifier.isDarkMode),
        _buildMenuOption(
          Icons.info, 
          appLocalizations.aboutUs, 
          widget.onAboutUsTap,
          themeNotifier.isDarkMode
        ),
      ],
    );
  }

  Widget _buildMenuSectionHeader(String title, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, top: 8),
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
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
      onTap: () async {
        await localizationService.toggleLanguage();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              localizationService.isEnglish() 
                ? 'Language changed to English' 
                : 'تم تغيير اللغة إلى العربية',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            backgroundColor: AppColors.secondaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      dense: true,
      minVerticalPadding: 10,
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeNotifier themeNotifier, AppLocalizations appLocalizations) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                themeNotifier.isDarkMode ? Icons.dark_mode : Icons.light_mode, 
                color: AppColors.primaryColor, 
                size: 20
              ),
              SizedBox(width: 10),
              Text(
                themeNotifier.isDarkMode ? appLocalizations.darkMode : appLocalizations.lightMode,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: themeNotifier.isDarkMode ? Colors.white : AppColors.textPrimary,
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
            activeThumbColor: AppColors.primaryColor,
            activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AppLocalizations appLocalizations) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Icon(Icons.logout, size: 18),
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
