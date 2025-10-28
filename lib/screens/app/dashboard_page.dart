import 'package:flutter/material.dart';
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

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      endDrawer: _buildSidebarMenu(context),
      appBar: DashboardAppBar(responsiveValue: _responsiveValue),
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
              MaterialPageRoute(builder: (context) => const DashboardPage()),
            );
          },
          onProfileTap: () {
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
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
          // User Profile Section
          UserProfileSection(responsiveValue: _responsiveValue),

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
    return DashboardSidebarMenu(
      userName: 'Eissa Ahmed',
      userRole: 'SALES MANAGER',
      userDepartment: 'Sales Department ',
      onOrganizationTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrganizationPage()),
        );
      },
      onMyAccountTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
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
      }, 
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          'No new notifications.',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'My Subscription',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          'Subscription management is under development.',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Language Settings',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          'Language selection is under development.',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'About Us',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        content: Text(
          'Vision ERP - Powering Digital Transformation\n\nVersion 1.0.0',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
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