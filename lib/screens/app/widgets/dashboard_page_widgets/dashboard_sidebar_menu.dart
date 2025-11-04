import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
import 'package:vision_erp_app/screens/app/profile_page.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/services/auth_service.dart';

class DashboardSidebarMenu extends StatelessWidget {
  final UserModel user;
  final VoidCallback onOrganizationTap;
  final VoidCallback onMyAccountTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onMySubscriptionTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onAboutUsTap;

  const DashboardSidebarMenu({
    super.key,
    required this.user,
    required this.onOrganizationTap,
    required this.onMyAccountTap,
    required this.onNotificationTap,
    required this.onMySubscriptionTap,
    required this.onLanguageTap,
    required this.onAboutUsTap,
  });

  Future<void> _handleLogout(BuildContext context) async {
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
    return Drawer(
      width: 280,
      backgroundColor: Colors.white,
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
            _buildUserProfile(context),
            Expanded(child: _buildMenuItems()),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
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
                      user.username, // استخدام اسم المستخدم الحقيقي
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      user.role, // استخدام الدور الحقيقي
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      user.department, // استخدام القسم الحقيقي
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        color: AppColors.textSecondary.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
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

  Widget _buildMenuItems() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildMenuSectionHeader('MAIN'),
        _buildMenuOption(Icons.business, 'Organization', onOrganizationTap),
        _buildMenuOption(Icons.account_circle, 'My Account', onMyAccountTap),
        _buildMenuOption(Icons.notifications, 'Notification', onNotificationTap),
        _buildMenuOption(Icons.card_membership, 'My Subscription', onMySubscriptionTap),

        SizedBox(height: 20),

        _buildMenuSectionHeader('SETTINGS'),
        _buildMenuOption(Icons.language, 'Language', onLanguageTap),

        SizedBox(height: 20),

        _buildMenuSectionHeader('MORE INFO'),
        _buildMenuOption(Icons.info, 'About Us', onAboutUsTap),

        SizedBox(height: 180),

        _buildThemeToggle(),
      ],
    );
  }

  Widget _buildMenuSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon, 
        color: AppColors.primaryColor,
        size: 20
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      dense: true,
      minVerticalPadding: 10,
    );
  }

  Widget _buildThemeToggle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.light_mode, color: AppColors.primaryColor, size: 20),
              SizedBox(width: 10),
              Text(
                'Light Mode ON',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          Switch(
            value: true,
            onChanged: (value) {},
            activeThumbColor: AppColors.primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton.icon(
          onPressed: () => _handleLogout(context), // استخدام الدالة الجديدة
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
            'Logout',
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