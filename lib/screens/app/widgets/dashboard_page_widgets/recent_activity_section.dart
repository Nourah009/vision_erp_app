import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class RecentActivitySection extends StatelessWidget {
  final Function(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) responsiveValue;

  const RecentActivitySection({
    super.key,
    required this.responsiveValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        responsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: responsiveValue(
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
                chartData: [70, 30],
                chartColor: AppColors.primaryColor,
              ),
              _buildActivityBox(
                context,
                title: 'Leave balance',
                value: '30 Day',
                icon: Icons.beach_access,
                chartType: 'line',
                chartData: [20, 35, 25, 40, 30, 45, 30],
                chartColor: AppColors.secondaryColor,
              ),
              _buildActivityBox(
                context,
                title: 'The Audience',
                value: '80%',
                icon: Icons.people,
                chartType: 'pie',
                chartData: [80, 20],
                chartColor: AppColors.accentBlue,
              ),
              _buildActivityBox(
                context,
                title: 'Tasks',
                value: '3/7 Tasks',
                icon: Icons.task,
                chartType: 'line',
                chartData: [1, 2, 1, 3, 2, 3, 3],
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
        responsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
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
                    fontSize: responsiveValue(
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
                size: responsiveValue(
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
                  fontSize: responsiveValue(
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
      width: responsiveValue(context, mobile: 50, tablet: 60, desktop: 70),
      height: responsiveValue(context, mobile: 50, tablet: 60, desktop: 70),
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
      width: responsiveValue(context, mobile: 70, tablet: 80, desktop: 90),
      height: responsiveValue(context, mobile: 40, tablet: 45, desktop: 50),
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
      progress = data[0] / 100;
    } else {
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
          width: progress * 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
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
    double startAngle = -0.5;

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

    if (valueRange == 0) valueRange = 1;

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