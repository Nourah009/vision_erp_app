import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/dashboard_page.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class OrganizationPage extends StatelessWidget {
  final UserModel user;
  final bool fromDashboard;
  
  const OrganizationPage({
    super.key, 
    required this.user,
    this.fromDashboard = true,
  });

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

  void _handleBackButton(BuildContext context) {
    if (fromDashboard) {
      // إذا كان من الداشبورد، ارجع للداشبورد
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
      );
    } else {
      // إذا كان من مكان آخر، استخدم التنقل العادي
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.secondaryColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.secondaryColor,
          onPressed: () => _handleBackButton(context),
        ),
        centerTitle: true,
        title: Text(
          'Organization',
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
          horizontal: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
          vertical: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern Company Header
            _buildModernHeader(context),
            SizedBox(height: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
            
            // Quick Stats Section
            _buildStatsGrid(context),
            SizedBox(height: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
            
            // Company Overview
            _buildSectionHeader('Company Overview', context),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
            _buildOverviewCard(context),
            SizedBox(height: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
            
            // Key Information
            _buildSectionHeader('Key Information', context),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
            _buildKeyInfoCard(context),
            SizedBox(height: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
            
            // Contact & Location
            _buildSectionHeader('Contact & Location', context),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
            _buildContactCard(context),
            SizedBox(height: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
            
            // Departments
            _buildSectionHeader('Our Teams', context),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
            _buildTeamsCard(context),
          ],
        ),
      ),
    );
  }

  // باقي الدوال تبقى كما هي...
  Widget _buildModernHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.accentBlue],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Company Logo
          Container(
            width: _responsiveValue(context, mobile: 80, tablet: 90, desktop: 100),
            height: _responsiveValue(context, mobile: 80, tablet: 90, desktop: 100),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 3,
              ),
            ),
            child: Icon(
              Icons.rocket_launch,
              color: Colors.white,
              size: _responsiveValue(context, mobile: 40, tablet: 45, desktop: 50),
            ),
          ),
          SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
          // Company Name
          Text(
            'VISION ERP',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 8),
          // Tagline
          Text(
            'Digital Transformation Leaders',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 17, desktop: 18),
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Active • Since 2018',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 13, desktop: 14),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
      mainAxisSpacing: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          context,
          title: 'Employees',
          value: '150+',
          icon: Icons.people_alt,
          color: AppColors.primaryColor,
        ),
        _buildStatCard(
          context,
          title: 'Projects',
          value: '240+',
          icon: Icons.work,
          color: AppColors.secondaryColor,
        ),
        _buildStatCard(
          context,
          title: 'Clients',
          value: '85+',
          icon: Icons.business_center,
          color: AppColors.accentBlue,
        ),
        _buildStatCard(
          context,
          title: 'Countries',
          value: '12',
          icon: Icons.public,
          color: AppColors.secondaryColor,
        ),
      ],
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: AppColors.primaryColor,
                size: _responsiveValue(context, mobile: 20, tablet: 22, desktop: 24),
              ),
              SizedBox(width: 12),
              Text(
                'Company Overview',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Vision ERP is a leading technology company specializing in enterprise resource planning solutions. '
            'We empower businesses with cutting-edge software that streamlines operations, enhances productivity, '
            'and drives digital transformation across various industries.',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
              color: AppColors.textPrimary,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildKeyInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildModernInfoItem(
            context,
            icon: Icons.business,
            title: 'Company Type',
            value: 'Technology Solutions',
            color: AppColors.primaryColor,
          ),
          _buildDivider(context),
          _buildModernInfoItem(
            context,
            icon: Icons.location_city,
            title: 'Headquarters',
            value: 'Riyadh, Saudi Arabia',
            color: AppColors.accentBlue,
          ),
          _buildDivider(context),
          _buildModernInfoItem(
            context,
            icon: Icons.flag,
            title: 'Operating In',
            value: '12 Countries',
            color: AppColors.secondaryColor,
          ),
          _buildDivider(context),
          _buildModernInfoItem(
            context,
            icon: Icons.verified,
            title: 'Certifications',
            value: 'ISO 9001, ISO 27001',
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildModernContactItem(
            context,
            icon: Icons.email,
            title: 'Email',
            value: 'contact@visionerp.com',
            onTap: () {},
          ),
          _buildDivider(context),
          _buildModernContactItem(
            context,
            icon: Icons.phone,
            title: 'Phone',
            value: '+966 11 123 4567',
            onTap: () {},
          ),
          _buildDivider(context),
          _buildModernContactItem(
            context,
            icon: Icons.language,
            title: 'Website',
            value: 'www.visionerp.com',
            onTap: () {},
          ),
          _buildDivider(context),
          _buildModernContactItem(
            context,
            icon: Icons.access_time,
            title: 'Business Hours',
            value: 'Sun - Thu: 8:00 AM - 6:00 PM',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Teams',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildTeamChip('Engineering', Icons.engineering, AppColors.primaryColor),
              _buildTeamChip('Product', Icons.design_services, AppColors.secondaryColor),
              _buildTeamChip('Sales', Icons.shopping_cart, AppColors.accentBlue),
              _buildTeamChip('Marketing', Icons.campaign, Colors.purple),
              _buildTeamChip('Support', Icons.support_agent, Colors.green),
              _buildTeamChip('Finance', Icons.attach_money, Colors.orange),
              _buildTeamChip('HR', Icons.people_alt, Colors.pink),
              _buildTeamChip('Operations', Icons.settings, Colors.teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _responsiveValue(context, mobile: 50, tablet: 55, desktop: 60),
            height: _responsiveValue(context, mobile: 50, tablet: 55, desktop: 60),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: _responsiveValue(context, mobile: 24, tablet: 26, desktop: 28),
            ),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 20, tablet: 22, desktop: 24),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 12, tablet: 13, desktop: 14),
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInfoItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _responsiveValue(context, mobile: 14, tablet: 16, desktop: 18)),
      child: Row(
        children: [
          Container(
            width: _responsiveValue(context, mobile: 44, tablet: 48, desktop: 52),
            height: _responsiveValue(context, mobile: 44, tablet: 48, desktop: 52),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: _responsiveValue(context, mobile: 22, tablet: 24, desktop: 26),
            ),
          ),
          SizedBox(width: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 15, tablet: 16, desktop: 17),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _responsiveValue(context, mobile: 14, tablet: 16, desktop: 18)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              width: _responsiveValue(context, mobile: 44, tablet: 48, desktop: 52),
              height: _responsiveValue(context, mobile: 44, tablet: 48, desktop: 52),
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.accentBlue,
                size: _responsiveValue(context, mobile: 22, tablet: 24, desktop: 26),
              ),
            ),
            SizedBox(width: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(context, mobile: 14, tablet: 15, desktop: 16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(context, mobile: 15, tablet: 16, desktop: 17),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary.withOpacity(0.5),
              size: _responsiveValue(context, mobile: 16, tablet: 17, desktop: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamChip(String team, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            team,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
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
          fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          letterSpacing: 0.5,
        ),
      )
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColors.borderColor.withOpacity(0.2),
    );
  }
}