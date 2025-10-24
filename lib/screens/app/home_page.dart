import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/dashboard_page.dart';
import 'package:vision_erp_app/screens/app/login_page.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

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
      appBar: AppBar(
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
                  'Hello',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor, // Dark blue text
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
                    color: AppColors.primaryColor, // Dark blue text
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recommendations Section
            _buildRecommendationsSection(context),

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
            ), // Small space between text and box
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
              child: _buildVisionERPSection(context),
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
            _buildPlanPricingSection(context),
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) => _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildRecommendationsSection(BuildContext context) {
    // List of all 14 categories with their icons
    final List<Map<String, dynamic>> categories = [
      {'title': 'Human Resources', 'icon': Icons.people},
      {'title': 'Materials and\nwarehouse', 'icon': Icons.warehouse},
      {'title': 'Fixed assets', 'icon': Icons.business},
      {'title': 'Customer\nRelations', 'icon': Icons.person},
      {'title': 'Analysis and\nreports', 'icon': Icons.analytics},
      {'title': 'Value Added\nTax', 'icon': Icons.attach_money},
      {'title': 'Projects', 'icon': Icons.assignment},
      {'title': 'Website', 'icon': Icons.language},
      {'title': 'Manufacturing', 'icon': Icons.build},
      {'title': 'Sales', 'icon': Icons.shopping_cart},
      {'title': 'Purchasing', 'icon': Icons.shopping_bag},
      {'title': 'Accounting', 'icon': Icons.account_balance},
      {'title': 'Inventory', 'icon': Icons.inventory},
      {'title': 'Quality\nControl', 'icon': Icons.verified},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommendations for you',
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
          SizedBox(height: 16),

          // Horizontal scrolling categories - FIXED SCROLLING
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    right: index == categories.length - 1 ? 0 : 12,
                    left: index == 0 ? 0 : 0,
                  ),
                  child: _buildCategoryBox(
                    context,
                    categories[index]['title'],
                    categories[index]['icon'] as IconData,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBox(BuildContext context, String title, IconData icon) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisionERPSection(BuildContext context) {
    return Container(
      width: double
          .infinity, // This will now take the constrained width from Padding
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.accentBlue],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vision ERP',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(
                context,
                mobile: 20,
                tablet: 24,
                desktop: 28,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Integrating every department for seamless data flow and clarity',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(
                context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              fontWeight: FontWeight.normal,
              color: Colors.white,
              height: 1.4,
            ),
          ),

          // Divider line
          Container(
            margin: EdgeInsets.symmetric(
              vertical: _responsiveValue(
                context,
                mobile: 12,
                tablet: 14,
                desktop: 16,
              ),
            ),
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),

          // Date and Time row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date on the left
              Text(
                'Sunday, 12 June',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 14,
                    tablet: 16,
                    desktop: 18,
                  ),
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),

              // Time on the right
              Text(
                '11:00 – 12:00 AM',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 14,
                    tablet: 16,
                    desktop: 18,
                  ),
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanPricingSection(BuildContext context) {
    // List of pricing plans
    final List<Map<String, dynamic>> plans = [
      {
        'title': 'Master',
        'subtitle': 'Ideal for small projects',
        'price': 'Free',
        'features': [
          'Unlimited personal files',
          'Email support',
          'CSV data export',
          'Basic analytics dashboard',
          '1,000 API calls per month',
        ],
        'isPopular': false,
        'buttonText': 'Get started',
        'buttonColor': AppColors.secondaryColor,
      },
      {
        'title': 'Project plan',
        'subtitle': 'All starter features +',
        'price': '',
        'features': [
          'Up to 5 user accounts',
          'Team collaboration tools',
          'Custom dashboards',
          'Multiple data export formats',
          'Basic custom integrations',
        ],
        'isPopular': true,
        'buttonText': 'Select plan',
        'buttonColor': AppColors.primaryColor,
      },
      {
        'title': 'Organization',
        'subtitle': 'For fast-growing businesses',
        'price': '\$30 /per user',
        'features': [
          'All professional features +',
          'Enterprise security suite',
          'Single Sign-On (SSO)',
          'Custom contract terms',
          'Dedicated phone support',
          'Custom integration support',
          'Compliance tools',
        ],
        'isPopular': false,
        'buttonText': 'Select plan',
        'buttonColor': AppColors.secondaryColor,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plan and Pricing title - centered
          Center(
            child: Text(
              'Plan and Pricing',
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
              // Increased space between text and boxes
              context,
              mobile: 24,
              tablet: 28,
              desktop: 32,
            ),
          ),

          // Horizontal scrolling plans
          SizedBox(
            height: _responsiveValue(
              context,
              mobile: 500, // Reduced height
              tablet: 400,
              desktop: 380,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plans.length,
              itemBuilder: (context, index) {
                return Container(
                  width: _responsiveValue(
                    context,
                    mobile: 280,
                    tablet: 300,
                    desktop: 320,
                  ),
                  margin: EdgeInsets.only(
                    right: index == plans.length - 1 ? 0 : 16,
                    left: index == 0 ? 0 : 0,
                  ),
                  child: _buildPlanCard(context, plans[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, Map<String, dynamic> plan) {
    return Container(
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: plan['isPopular']
              ? AppColors.primaryColor
              : AppColors.primaryColor.withOpacity(0.2),
          width: plan['isPopular'] ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: plan['isPopular']
            ? AppColors.primaryColor.withOpacity(0.05)
            : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular badge - centered at top
          if (plan['isPopular'])
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _responsiveValue(
                    context,
                    mobile: 8,
                    tablet: 10,
                    desktop: 12,
                  ),
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'MOST POPULAR PLAN',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 10,
                      tablet: 11,
                      desktop: 12,
                    ),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          if (plan['isPopular']) SizedBox(height: 12),

          // Plan title
          Text(
            plan['title'],
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

          SizedBox(height: 4),

          // Plan subtitle
          Text(
            plan['subtitle'],
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(
                context,
                mobile: 13,
                tablet: 14,
                desktop: 15,
              ),
              color: AppColors.textSecondary,
            ),
          ),

          SizedBox(height: 12),

          // Price
          if (plan['price'].isNotEmpty)
            Text(
              plan['price'],
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: _responsiveValue(
                  context,
                  mobile: 15,
                  tablet: 16,
                  desktop: 17,
                ),
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

          SizedBox(height: 12),

          // Features list with reduced spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var feature in plan['features'])
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 6,
                    ), // Reduced padding
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.primaryColor,
                          size: 14, // Smaller icon
                        ),
                        SizedBox(width: 6), // Reduced spacing
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: _responsiveValue(
                                context,
                                mobile: 12,
                                tablet: 13,
                                desktop: 14,
                              ),
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Select plan button
          SizedBox(
            width: double.infinity,
            height: _responsiveValue(
              context,
              mobile: 40, // Reduced button height
              tablet: 45,
              desktop: 50,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: plan['buttonColor'],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                plan['buttonText'],
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 13,
                    tablet: 14,
                    desktop: 15,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.textSecondary,
          currentIndex: 0, // Home is selected
          type: BottomNavigationBarType
              .fixed, // This ensures labels are always visible
          onTap: (index) {
            if (index == 1) {
              // Navigate to Dashboard
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
              );
            } else if (index == 2) {
              // Navigate to Profile (you'll need to create this)
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfilePage()),
              // );
            } else if (index == 3) {
              // Handle Menu tap - open sidebar
              Scaffold.of(context).openEndDrawer();
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home', // Label is back
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard', // Label is back
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile', // Label is back
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu', // Label is back
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarMenu(BuildContext context) {
    return Drawer(
      width: 200,
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Eissa Ahmed',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            'SALES MANAGER',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.all(12),
                children: [
                  // MAIN section
                  _buildMenuSectionHeader('MAIN'),
                  _buildMenuOption(context, Icons.dashboard, 'Dashboard', () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  }),
                  _buildMenuOption(
                    context,
                    Icons.account_circle,
                    'My Account',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                  _buildMenuOption(
                    context,
                    Icons.notifications,
                    'Notification',
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildMenuOption(
                    context,
                    Icons.card_membership,
                    'My Subscription',
                    () {
                      Navigator.pop(context);
                    },
                  ),

                  SizedBox(height: 16),

                  // SETTINGS section
                  _buildMenuSectionHeader('SETTINGS'),
                  _buildMenuOption(context, Icons.language, 'Language', () {
                    Navigator.pop(context);
                  }),

                  SizedBox(height: 16),

                  // MONGE INFO section
                  _buildMenuSectionHeader('MONGE INFO'),
                  _buildMenuOption(context, Icons.info, 'About Us', () {
                    Navigator.pop(context);
                  }),

                  SizedBox(height: 165),

                  // Light Mode toggle
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.light_mode,
                              color: AppColors.primaryColor,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Light Mode ON',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: true,
                          onChanged: (value) {},
                          activeThumbColor: AppColors.primaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Logout button
            Container(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  icon: Icon(Icons.logout, size: 16),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6, top: 6), // Reduced padding
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 10, // Reduced from 12
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.0, // Reduced letter spacing
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primaryColor,
        size: 18, // Reduced from 20
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12, // Reduced from 14
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      dense: true, // Added this to make ListTile more compact
      minVerticalPadding: 8, // Reduced vertical padding
    );
  }
}
