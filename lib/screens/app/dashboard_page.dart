import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
import 'package:vision_erp_app/screens/app/organization.dart';
import 'package:vision_erp_app/screens/app/profile_page.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/dashboard_app_bar.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/dashboard_bottom_navigation_bar.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/dashboard_sidebar_menu.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/recent_activity_section.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/task_schedule_section.dart';
import 'package:vision_erp_app/screens/app/widgets/dashboard_page_widgets/user_profile_section.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class DashboardPage extends StatelessWidget {
  final UserModel user;
  
  const DashboardPage({super.key, required this.user});

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
      appBar: DashboardAppBar(
        responsiveValue: _responsiveValue,
        user: user,
      ),
      body: _buildBody(context),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
            );
          },
          onProfileTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
            );
          },
        ),
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
            user: user,
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
    
    return DashboardSidebarMenu(
      user: user,
      onOrganizationTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrganizationPage(user: user,)),
        );
      },
      onMyAccountTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
        );
      },
      onNotificationTap: () {
        Navigator.pop(context);
        _showNotificationDialog(context);
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
      }, userName: '', userRole: '', onResetIntroTap: () {  }, onDashboardTap: () {  }, onThemeChanged: (bool p1) {  }, onLanguageChanged: (String p1) {  }, 
    );
  }

  void _showNotificationDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          appLocalizations.notification,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          isEnglish ? 'No new notifications.' : 'لا توجد إشعارات جديدة.',
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