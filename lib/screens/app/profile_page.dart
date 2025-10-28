import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.secondaryColor, // Changed to secondary color
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.secondaryColor, // Changed to secondary color
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
          vertical: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header Section - Like the image
            _buildUserHeader(context),
            SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
            
            // PROFILE Section
            _buildSectionHeader('PROFILE', context),
            SizedBox(height: _responsiveValue(context, mobile: 6, tablet: 8, desktop: 10)),
            _buildProfileOptions(context),
            SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
            
            // BANK DETAIL Section
            _buildSectionHeader('BANK DETAIL', context),
            SizedBox(height: _responsiveValue(context, mobile: 6, tablet: 8, desktop: 10)),
            _buildBankDetailOption(context),
            SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
            
            // NOTIFICATIONS Section
            _buildSectionHeader('NOTIFICATIONS', context),
            SizedBox(height: _responsiveValue(context, mobile: 6, tablet: 8, desktop: 10)),
            _buildNotificationOptions(context),
            SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
            
            // SECURITY Section
            _buildSectionHeader('SECURITY', context),
            SizedBox(height: _responsiveValue(context, mobile: 6, tablet: 8, desktop: 10)),
            _buildSecurityOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.accentBlue],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User Avatar
          Container(
            width: _responsiveValue(context, mobile: 70, tablet: 80, desktop: 90),
            height: _responsiveValue(context, mobile: 70, tablet: 80, desktop: 90),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: _responsiveValue(context, mobile: 35, tablet: 40, desktop: 45),
            ),
          ),
          SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
          // User Name
          Text(
            'Essa Ahmed',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 20, tablet: 22, desktop: 24),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: _responsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
          // User Role and Department
          Text(
            'Sales Manager - Sales Department',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: _responsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.99, // Reduced width
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildOptionItem(
            context: context,
            icon: Icons.account_circle_outlined,
            title: 'Account details',
            hasSwitch: false,
          ),
          _buildDivider(context),
          _buildOptionItem(
            context: context,
            icon: Icons.description_outlined,
            title: 'Documents',
            hasSwitch: false,
          ),
          _buildDivider(context),
          _buildOptionItem(
            context: context,
            icon: Icons.location_on_outlined,
            title: 'Turn your location',
            subtitle: 'This will expose face of target',
            hasSwitch: true,
            switchValue: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailOption(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.99, // Reduced width
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: _buildOptionItem(
        context: context,
        icon: Icons.account_balance_outlined,
        title: 'Bank Account',
        hasSwitch: false,
      ),
    );
  }

  Widget _buildNotificationOptions(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.99, // Reduced width
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildOptionItem(
            context: context,
            icon: Icons.notifications_active_outlined,
            title: 'Activities notifications',
            subtitle: 'Payment facades, links and other activities',
            hasSwitch: true,
            switchValue: true,
          ),
          _buildDivider(context),
          _buildOptionItem(
            context: context,
            icon: Icons.email_outlined,
            title: 'Email notification',
            hasSwitch: true,
            switchValue: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOptions(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.99, // Reduced width
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildOptionItem(
            context: context,
            icon: Icons.fingerprint_outlined,
            title: 'Sign in with touch ID',
            hasSwitch: true,
            switchValue: true,
          ),
          _buildDivider(context),
          _buildOptionItem(
            context: context,
            icon: Icons.lock_outlined,
            title: 'Change password',
            hasSwitch: false,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    required bool hasSwitch,
    bool switchValue = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
        vertical: _responsiveValue(context, mobile: 10, tablet: 12, desktop: 14),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: _responsiveValue(context, mobile: 32, tablet: 34, desktop: 36),
            height: _responsiveValue(context, mobile: 32, tablet: 34, desktop: 36),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: _responsiveValue(context, mobile: 16, tablet: 17, desktop: 18),
            ),
          ),
          SizedBox(width: _responsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 13, desktop: 14),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(context, mobile: 10, tablet: 11, desktop: 12),
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Switch or Arrow
          if (hasSwitch)
            Transform.scale(
              scale: 0.7,
              child: Switch(
                value: switchValue,
                onChanged: (value) {
                  // Handle switch toggle
                },
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
          else
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary.withOpacity(0.5),
              size: _responsiveValue(context, mobile: 12, tablet: 13, desktop: 14),
            ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
      child: Divider(
        height: 1,
        color: AppColors.borderColor.withOpacity(0.2),
      ),
    );
  }
}