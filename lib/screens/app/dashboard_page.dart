import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Profile info on LEFT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  'Essa Ahmed!',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 18,
                      tablet: 20,
                      desktop: 22,
                    ),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            // Notification icon on RIGHT
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
            // User Profile Section
            _buildVisionERPSection(context),

            SizedBox(
              height: _responsiveValue(
                context,
                mobile: 20,
                tablet: 25,
                desktop: 30,
              ),
            ),

            // Recent Activity Section with 4 boxes and charts
            _buildRecentActivitySection(context),

            SizedBox(
              height: _responsiveValue(
                context,
                mobile: 20,
                tablet: 25,
                desktop: 30,
              ),
            ),

            // Task Schedule Section
            _buildTaskScheduleSection(context),
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) => _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildVisionERPSection(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User info on the left
          Expanded(
            child: Row(
              children: [
                // User icon
                Container(
                  width: _responsiveValue(
                    context,
                    mobile: 50,
                    tablet: 60,
                    desktop: 70,
                  ),
                  height: _responsiveValue(
                    context,
                    mobile: 50,
                    tablet: 60,
                    desktop: 70,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: _responsiveValue(
                      context,
                      mobile: 24,
                      tablet: 28,
                      desktop: 32,
                    ),
                  ),
                ),
                SizedBox(
                  width: _responsiveValue(
                    context,
                    mobile: 12,
                    tablet: 16,
                    desktop: 20,
                  ),
                ),
                // User name and job description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Eissa Ahmed',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(
                            context,
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Sales Manager',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(
                            context,
                            mobile: 14,
                            tablet: 15,
                            desktop: 16,
                          ),
                          fontWeight: FontWeight.normal,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Arrow icon on the right
          IconButton(
            onPressed: () {
              // Handle arrow tap for more information
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: _responsiveValue(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
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

          // Grid of 4 activity boxes
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _buildActivityBox(
                context,
                title: 'Contract duration',
                value: '25 Day-2 Years',
                icon: Icons.assignment,
                chartType: 'pie',
                chartData: [70, 30], // 70% completed, 30% remaining
                chartColor: AppColors.primaryColor,
              ),
              _buildActivityBox(
                context,
                title: 'Leave balance',
                value: '30 Day',
                icon: Icons.beach_access,
                chartType: 'line',
                chartData: [20, 35, 25, 40, 30, 45, 30], // Leave usage trend
                chartColor: AppColors.secondaryColor,
              ),
              _buildActivityBox(
                context,
                title: 'The Audience',
                value: '80%',
                icon: Icons.people,
                chartType: 'pie',
                chartData: [80, 20], // 80% reached, 20% remaining
                chartColor: AppColors.accentBlue,
              ),
              _buildActivityBox(
                context,
                title: 'Tasks',
                value: '3/7 Tasks',
                icon: Icons.task,
                chartType: 'line',
                chartData: [1, 2, 1, 3, 2, 3, 3], // Task completion trend
                chartColor: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBox(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required String chartType,
    required List<double> chartData,
    required Color chartColor,
  }) {
    return Container(
      padding: EdgeInsets.all(
        _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top row with icon and title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 12,
                      tablet: 14,
                      desktop: 16,
                    ),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                icon,
                color: AppColors.primaryColor,
                size: _responsiveValue(
                  context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                ),
              ),
            ],
          ),

          // Middle section - chart
          Expanded(
            child: Center(
              child: chartType == 'pie'
                  ? _buildPieChart(context, chartData, chartColor)
                  : _buildLineChart(context, chartData, chartColor),
            ),
          ),

          // Bottom section - value and progress indicator
          Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(
                    context,
                    mobile: 12,
                    tablet: 13,
                    desktop: 14,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              _buildProgressIndicator(chartData, chartType, chartColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(BuildContext context, List<double> data, Color color) {
    return SizedBox(
      width: _responsiveValue(context, mobile: 50, tablet: 60, desktop: 70),
      height: _responsiveValue(context, mobile: 50, tablet: 60, desktop: 70),
      child: CustomPaint(
        painter: _PieChartPainter(
          data: data,
          colors: [color, color.withOpacity(0.3)],
        ),
      ),
    );
  }

  Widget _buildLineChart(BuildContext context, List<double> data, Color color) {
    return SizedBox(
      width: _responsiveValue(context, mobile: 70, tablet: 80, desktop: 90),
      height: _responsiveValue(context, mobile: 40, tablet: 45, desktop: 50),
      child: CustomPaint(
        painter: _LineChartPainter(data: data, color: color),
      ),
    );
  }

  Widget _buildProgressIndicator(
    List<double> data,
    String chartType,
    Color color,
  ) {
    double progress = 0.0;

    if (chartType == 'pie') {
      // For pie charts, progress is the first data point percentage
      progress = data[0] / 100;
    } else {
      // For line charts, calculate average progress
      double maxValue = data.reduce((a, b) => a > b ? a : b);
      double lastValue = data.last;
      progress = lastValue / maxValue;
    }

    return Container(
      width: double.infinity,
      height: 4,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: progress * 100, // Convert to percentage width
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskScheduleSection(BuildContext context) {
    final List<Map<String, dynamic>> tasks = [
      {
        'title': 'Visual & Auditory Check',
        'description': 'Listen for operation. Check for error lights.',
        'time': '10:00 AM',
        'status': 'done', // done, in-progress, todo
      },
      {
        'title': 'Feel the Author',
        'description': 'Confirm airflow from fresh air supply vents.',
        'time': '12:00 PM',
        'status': 'in-progress',
      },
      {
        'title': 'Check the Control Setting',
        'description': 'Ensure unit is on in "Auto" or desired mode.',
        'time': '07:00 PM',
        'status': 'todo',
      },
      {
        'title': 'Check Exterior Vents',
        'description': 'Ensure outdoor intake/exhaust hoods are not blocked.',
        'time': '07:00 PM',
        'status': 'todo',
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
          Text(
            'Task schedule',
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

          // Task List - Each task in separate white box
          Column(
            children: [
              for (var task in tasks)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(
                    _responsiveValue(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side - Task details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              task['title'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: _responsiveValue(
                                  context,
                                  mobile: 14,
                                  tablet: 16,
                                  desktop: 18,
                                ),
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(height: 4),

                            // Description
                            Text(
                              task['description'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: _responsiveValue(
                                  context,
                                  mobile: 12,
                                  tablet: 14,
                                  desktop: 16,
                                ),
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 8),

                            // Time (moved below the texts)
                            Text(
                              task['time'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: _responsiveValue(
                                  context,
                                  mobile: 12,
                                  tablet: 13,
                                  desktop: 14,
                                ),
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 12),

                      // Right side - Status indicator
                      _buildTaskStatus(task['status']),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStatus(String status) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'done':
        statusColor = Colors.green;
        statusText = 'Done';
        statusIcon = Icons.check_circle;
        break;
      case 'in-progress':
        statusColor = Colors.orange;
        statusText = 'In Progress';
        statusIcon = Icons.access_time;
        break;
      case 'todo':
        statusColor = Colors.grey;
        statusText = 'To Do';
        statusIcon = Icons.radio_button_unchecked;
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'To Do';
        statusIcon = Icons.radio_button_unchecked;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 16),
          SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: statusColor,
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
          currentIndex: 1, // Dashboard is selected
          type: BottomNavigationBarType
              .fixed, // This ensures labels are always visible
          onTap: (index) {
            if (index == 0) {
              // Navigate to Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
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
    width: 280, // Increased from 200 to 280
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
            padding: EdgeInsets.all(20), // Increased padding
            child: Container(
              padding: EdgeInsets.all(20), // Increased padding
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50, // Increased size
                    height: 50, // Increased size
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 24), // Increased icon size
                  ),
                  SizedBox(width: 12), // Increased spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Eissa Ahmed',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          'SALES MANAGER',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12, // Increased font size
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
              padding: EdgeInsets.all(16), // Increased padding
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

                SizedBox(height: 20), // Increased spacing

                // SETTINGS section
                _buildMenuSectionHeader('SETTINGS'),
                _buildMenuOption(context, Icons.language, 'Language', () {
                  Navigator.pop(context);
                }),

                SizedBox(height: 20), // Increased spacing

                _buildMenuSectionHeader('MORE INFO'),
                _buildMenuOption(context, Icons.info, 'About Us', () {
                  Navigator.pop(context);
                }),

                SizedBox(height: 180), // Increased spacing

                // Light Mode toggle
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10), // Increased padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.light_mode,
                            color: AppColors.primaryColor,
                            size: 20, // Increased icon size
                          ),
                          SizedBox(width: 10), // Increased spacing
                          Text(
                            'Light Mode ON',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14, // Increased font size
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
                ),
              ],
            ),
          ),

          // Logout button
          Container(
            padding: EdgeInsets.all(16), // Increased padding
            child: SizedBox(
              width: double.infinity,
              height: 44, // Increased button height
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Increased padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Slightly larger radius
                  ),
                ),
                icon: Icon(Icons.logout, size: 18), // Increased icon size
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14, // Increased font size
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
    padding: EdgeInsets.only(bottom: 8, top: 8), // Increased padding
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 12, // Increased from 10
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
        letterSpacing: 1.2, // Increased letter spacing
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
      size: 20, // Increased from 18
    ),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14, // Increased from 12
        color: AppColors.textPrimary,
      ),
    ),
    onTap: onTap,
    contentPadding: EdgeInsets.zero,
    minLeadingWidth: 0,
    dense: true,
    minVerticalPadding: 10, // Increased vertical padding
  );
}
}

class _PieChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;

  _PieChartPainter({required this.data, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    double total = data.reduce((a, b) => a + b);
    double startAngle = -0.5; // Start from top

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i] / total) * (2 * 3.14159);

      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

      startAngle += sweepAngle;
    }

    // Draw center circle for donut effect
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final centerRadius = radius * 0.5;
    canvas.drawCircle(center, centerRadius, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _LineChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double maxValue = data.reduce((a, b) => a > b ? a : b);
    double minValue = data.reduce((a, b) => a < b ? a : b);
    double valueRange = maxValue - minValue;

    if (valueRange == 0) valueRange = 1; // Avoid division by zero

    double xStep = size.width / (data.length - 1);
    double yScale = size.height / valueRange;

    // Draw line
    final path = Path();
    for (int i = 0; i < data.length; i++) {
      double x = i * xStep;
      double y = size.height - ((data[i] - minValue) * yScale);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw data points
      if (i == data.length - 1) {
        // Make last point more visible
        canvas.drawCircle(Offset(x, y), 3, dotPaint);
      } else {
        canvas.drawCircle(Offset(x, y), 2, dotPaint);
      }
    }

    canvas.drawPath(path, paint);

    // Draw area under line
    final areaPath = Path()..addPath(path, Offset.zero);
    areaPath.lineTo(size.width, size.height);
    areaPath.lineTo(0, size.height);
    areaPath.close();

    final areaPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawPath(areaPath, areaPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
