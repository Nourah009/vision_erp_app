import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/demo_system_page.dart';
import 'package:vision_erp_app/screens/app/login_page.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/bottom_navigation_bar.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/plan_pricing_section.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/recommendations_section.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/sidebar_menu.dart';
import 'package:vision_erp_app/screens/app/widgets/home_page_widgets/vision_erp_section.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/shared_preferences_service.dart';




class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: Builder(
        builder: (context) => CustomBottomNavigationBar(
          currentIndex: 0,
          onHomeTap: () {
            // Already on home page
          },
          onDemoTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DemoSystemPage()),
            );
          },
          onProfileTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
            // Navigate to Profile (you'll need to create this)
          }, onDashboardTap: () {  }, onMenuTap: () {  },
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
          // Welcome text on LEFT
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
                'To vision ERP',
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

          // Bell icon on RIGHT
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.secondaryColor,
            ),
            onPressed: () {
              // Handle notification tap
            },
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
      userName: 'Welcome',
      userRole: 'to Vision ERP',
      onMyAccountTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      onNotificationTap: () {
        Navigator.pop(context);
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
      }, onDashboardTap: () {  },
    );
  }
}