import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

// Data models for charts
class SalesData {
  final String month;
  final double sales;
  final double target;

  SalesData(this.month, this.sales, this.target);
}

class PieData {
  final String category;
  final double percentage;
  final Color color;

  PieData(this.category, this.percentage, this.color);
}

class AnalysisReportsPage extends StatefulWidget {
  const AnalysisReportsPage({super.key, UserModel? user});

  @override
  State<AnalysisReportsPage> createState() => _AnalysisReportsPageState();
}

class _AnalysisReportsPageState extends State<AnalysisReportsPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Enhanced sample data
  final List<Map<String, dynamic>> _kpiData = [
    {
      'title': 'Total Revenue', 
      'value': '\$1.2M', 
      'change': '+12%', 
      'icon': Icons.attach_money, 
      'color': Colors.green,
      'trend': 'up'
    },
    {
      'title': 'Active Customers', 
      'value': '2,847', 
      'change': '+5%', 
      'icon': Icons.people, 
      'color': Colors.blue,
      'trend': 'up'
    },
    {
      'title': 'Inventory Value', 
      'value': '\$845K', 
      'change': '-3%', 
      'icon': Icons.inventory, 
      'color': Colors.orange,
      'trend': 'down'
    },
    {
      'title': 'Pending Orders', 
      'value': '156', 
      'change': '+8%', 
      'icon': Icons.shopping_cart, 
      'color': Colors.purple,
      'trend': 'up'
    },
  ];

  final List<SalesData> _monthlySales = [
    SalesData('Jan', 35000, 28000),
    SalesData('Feb', 42000, 32000),
    SalesData('Mar', 38000, 35000),
    SalesData('Apr', 51000, 42000),
    SalesData('May', 48000, 39000),
    SalesData('Jun', 55000, 45000),
  ];

  final List<PieData> _salesByCategory = [
    PieData('Electronics', 35, Colors.blue),
    PieData('Clothing', 25, Colors.green),
    PieData('Home Goods', 20, Colors.orange),
    PieData('Sports', 15, Colors.purple),
    PieData('Other', 5, Colors.grey),
  ];

  final List<Map<String, dynamic>> _topProducts = [
    {'name': 'Smartphone X', 'sales': 1250, 'revenue': 125000, 'growth': 15},
    {'name': 'Laptop Pro', 'sales': 890, 'revenue': 890000, 'growth': 8},
    {'name': 'Wireless Headphones', 'sales': 2150, 'revenue': 322500, 'growth': 22},
    {'name': 'Smart Watch', 'sales': 980, 'revenue': 294000, 'growth': 12},
    {'name': 'Tablet Mini', 'sales': 760, 'revenue': 228000, 'growth': 5},
  ];

  // Filters
  DateTime _selectedFromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _selectedToDate = DateTime.now();
  String _selectedDepartment = 'All';
  String _selectedReportType = 'Sales';
  String _selectedChartType = 'Bar';
  bool _autoRefresh = true;

  // Report categories
  final List<String> _reportCategories = [
    'General Dashboard',
    'Sales Analysis',
    'Purchase Analysis',
    'Inventory Reports',
    'Financial Reports',
    'HR & Payroll',
    'Fixed Assets',
    'CRM Reports',
    'Manufacturing',
    'Business Intelligence'
  ];

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _reportCategories.length, vsync: this);
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    if (_autoRefresh) {
      Future.delayed(const Duration(seconds: 30), () {
        if (mounted && _autoRefresh) {
          setState(() {
            _refreshData(silent: true);
          });
          _startAutoRefresh();
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Enhanced reporting functions
  void _exportReport(String format) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Export Report', 
          style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download_rounded, size: 48, color: ThemeCollection.matisse.withOpacity(0.7)),
            const SizedBox(height: 16),
            Text('Exporting report as $format format...', 
              style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.mako)),
            const SizedBox(height: 8),
            Text('This may take a few moments.', 
              style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo, fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', 
              style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showExportProgress(format);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeCollection.matisse,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Export', 
              style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showExportProgress(String format) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeCollection.matisse)),
              const SizedBox(height: 20),
              Text('Exporting $format...', 
                style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Preparing your report for download', 
                style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo, fontSize: 12)),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Text('Report exported as $format successfully!', 
                style: TextStyle(fontFamily: 'Cairo')),
            ],
          ),
          backgroundColor: ThemeCollection.matisse,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    });
  }

  void _showDateRangePicker() {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _selectedFromDate, end: _selectedToDate),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ThemeCollection.matisse,
            colorScheme: ColorScheme.light(primary: ThemeCollection.matisse),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedFromDate = value.start;
          _selectedToDate = value.end;
        });
      }
    });
  }

  void _toggleAutoRefresh() {
    setState(() {
      _autoRefresh = !_autoRefresh;
    });
    if (_autoRefresh) {
      _startAutoRefresh();
    }
  }

  void _showReportSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Report Settings', 
          style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Auto Refresh', style: TextStyle(fontFamily: 'Cairo')),
              value: _autoRefresh,
              onChanged: (value) => setState(() => _autoRefresh = value),
              activeThumbColor: ThemeCollection.matisse,
            ),
            SwitchListTile(
              title: Text('Show Annotations', style: TextStyle(fontFamily: 'Cairo')),
              value: true,
              onChanged: (value) {},
              activeThumbColor: ThemeCollection.matisse,
            ),
            SwitchListTile(
              title: Text('Data Labels', style: TextStyle(fontFamily: 'Cairo')),
              value: true,
              onChanged: (value) {},
              activeThumbColor: ThemeCollection.matisse,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: ThemeCollection.matisse),
            child: Text('Save', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAdvancedFiltersSheet(),
    );
  }

  void _saveDashboard() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Save Dashboard', 
          style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Dashboard Name',
                labelStyle: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ThemeCollection.matisse),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ThemeCollection.matisse, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: ThemeCollection.jumbo),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('This will save your current dashboard configuration',
                    style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo, fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', 
              style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.bookmark_added_rounded, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Dashboard saved successfully!', 
                        style: TextStyle(fontFamily: 'Cairo')),
                    ],
                  ),
                  backgroundColor: ThemeCollection.matisse,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeCollection.matisse,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Save', 
              style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFullScreenChart(Widget chart) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Chart View', 
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ThemeCollection.matisse.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.close, color: ThemeCollection.matisse),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(child: chart),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildChartActionButton('Export', Icons.download, () => _exportReport('PDF')),
                    _buildChartActionButton('Share', Icons.share, () {}),
                    _buildChartActionButton('Save', Icons.bookmark_border, _saveDashboard),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartActionButton(String text, IconData icon, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ThemeCollection.matisse.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: ThemeCollection.matisse),
          ),
          onPressed: onPressed,
        ),
        const SizedBox(height: 4),
        Text(text, style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: ThemeCollection.matisse)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeCollection.whiteSmoke,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: ThemeCollection.matisse,
        elevation: 2,
        shadowColor: ThemeCollection.matisse.withOpacity(0.1),
        title: Text(
          'Analysis & Reports',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ThemeCollection.matisse,
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ThemeCollection.matisse.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_back, color: ThemeCollection.matisse, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _autoRefresh ? ThemeCollection.matisse.withOpacity(0.2) : ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_autoRefresh ? Icons.autorenew : Icons.autorenew_outlined, 
                color: ThemeCollection.matisse, size: 20),
            ),
            onPressed: _toggleAutoRefresh,
            tooltip: _autoRefresh ? 'Auto-refresh ON' : 'Auto-refresh OFF',
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.bookmark_border, color: ThemeCollection.matisse, size: 20),
            ),
            onPressed: _saveDashboard,
            tooltip: 'Save Dashboard',
          ),
          PopupMenuButton<String>(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.more_vert, color: ThemeCollection.matisse, size: 20),
            ),
            onSelected: (value) {
              if (value == 'export_pdf') {
                _exportReport('PDF');
              } else if (value == 'export_excel') _exportReport('Excel');
              else if (value == 'export_csv') _exportReport('CSV');
              else if (value == 'settings') _showReportSettings();
            },
            itemBuilder: (context) => [
              _buildPopupMenuItem('Export as PDF', 'export_pdf', Icons.picture_as_pdf),
              _buildPopupMenuItem('Export as Excel', 'export_excel', Icons.table_chart),
              _buildPopupMenuItem('Export as CSV', 'export_csv', Icons.grid_on),
              const PopupMenuDivider(),
              _buildPopupMenuItem('Report Settings', 'settings', Icons.settings),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ThemeCollection.matisse.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeCollection.matisse.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search reports...',
                      hintStyle: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: ThemeCollection.matisse),
                      suffixIcon: _searchQuery.isNotEmpty ? IconButton(
                        icon: Icon(Icons.clear, color: ThemeCollection.matisse),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      ) : null,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
              // Tab Bar
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: ThemeCollection.matisse,
                unselectedLabelColor: ThemeCollection.matisse.withOpacity(0.5),
                indicatorColor: ThemeCollection.matisse,
                indicatorWeight: 3,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
                labelStyle: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontFamily: 'Cairo'),
                tabs: _reportCategories.map((category) => Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(category),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Bar
          _buildFilterBar(),
          
          // Main Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGeneralDashboard(),
                _buildSalesAnalysis(),
                _buildPurchaseAnalysis(),
                _buildInventoryReports(),
                _buildFinancialReports(),
                _buildHRReports(),
                _buildFixedAssetsReports(),
                _buildCRMReports(),
                _buildManufacturingReports(),
                _buildBusinessIntelligence(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String text, String value, IconData icon) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: ThemeCollection.matisse, size: 20),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
        ],
      ),
    );
  }

  // Enhanced Filter Bar
  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: ThemeCollection.matisse.withOpacity(0.1)),
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeCollection.matisse.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date Range with improved styling
          Expanded(
            child: InkWell(
              onTap: _showDateRangePicker,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: ThemeCollection.whiteSmoke,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date Range', 
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: ThemeCollection.jumbo)),
                        Text(
                          '${_selectedFromDate.day}/${_selectedFromDate.month}/${_selectedFromDate.year} - ${_selectedToDate.day}/${_selectedToDate.month}/${_selectedToDate.year}',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: ThemeCollection.matisse, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: ThemeCollection.matisse.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.calendar_today, size: 16, color: ThemeCollection.matisse),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Department Filter with improved styling
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ThemeCollection.whiteSmoke,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
              ),
              child: DropdownButtonFormField<String>(
                initialValue: _selectedDepartment,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  border: InputBorder.none,
                  isDense: true,
                ),
                dropdownColor: Colors.white,
                style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: ThemeCollection.matisse, fontWeight: FontWeight.w600),
                items: ['All', 'Sales', 'Marketing', 'Finance', 'HR', 'IT', 'Operations'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value!;
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Advanced Filters with improved styling
          Container(
            decoration: BoxDecoration(
              color: ThemeCollection.matisse.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
            ),
            child: IconButton(
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.filter_alt, color: ThemeCollection.matisse),
                  const SizedBox(width: 4),
                  Text('Filters', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: ThemeCollection.matisse)),
                ],
              ),
              onPressed: _showAdvancedFilters,
              tooltip: 'Advanced Filters',
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced General Dashboard
  Widget _buildGeneralDashboard() {
    return RefreshIndicator(
      onRefresh: () async => _refreshData(),
      backgroundColor: ThemeCollection.matisse,
      color: Colors.white,
      displacement: 40,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Enhanced KPI Cards
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: _kpiData.length,
              itemBuilder: (context, index) => _buildEnhancedKPICard(_kpiData[index]),
            ),
            const SizedBox(height: 24),

            // Enhanced Charts Section
            _buildChartsSection(),

            const SizedBox(height: 24),

            // Enhanced Top Products Table
            _buildEnhancedTopProductsTable(),

            const SizedBox(height: 24),

            // Quick Actions
            _buildQuickActions(),

            const SizedBox(height: 24),

            // Recent Activity
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedKPICard(Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ThemeCollection.matisse.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: data['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(data['icon'] as IconData, color: data['color'], size: 24),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: data['trend'] == 'up' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        data['trend'] == 'up' ? Icons.trending_up : Icons.trending_down,
                        size: 14,
                        color: data['trend'] == 'up' ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(data['change'], 
                        style: TextStyle(
                          color: data['trend'] == 'up' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          fontSize: 12,
                        )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(data['title'], 
              style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: ThemeCollection.jumbo, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(data['value'], 
              style: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: ThemeCollection.whiteSmoke,
              valueColor: AlwaysStoppedAnimation<Color>(data['color']),
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ThemeCollection.matisse.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Performance Overview', 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
                Row(
                  children: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: ThemeCollection.matisse.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.fullscreen, color: ThemeCollection.matisse, size: 18),
                      ),
                      onPressed: () => _showFullScreenChart(_buildSalesChartContent()),
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: ThemeCollection.matisse.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.download, color: ThemeCollection.matisse, size: 18),
                      ),
                      onPressed: () => _exportReport('PNG'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildSalesChart(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: _buildPieChart(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesChart() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: ThemeCollection.whiteSmoke.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: _buildSalesChartContent(),
    );
  }

  Widget _buildSalesChartContent() {
    return SfCartesianChart(
      margin: const EdgeInsets.all(16),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.mako),
        axisLine: AxisLine(color: ThemeCollection.matisse.withOpacity(0.3)),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.mako),
        axisLine: AxisLine(color: ThemeCollection.matisse.withOpacity(0.3)),
        numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
      ),
      series: <CartesianSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          dataSource: _monthlySales,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.sales,
          name: 'Actual Sales',
          color: ThemeCollection.matisse,
          markerSettings: const MarkerSettings(isVisible: true),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto,
            textStyle: TextStyle(fontFamily: 'Cairo', fontSize: 10),
          ),
        ),
        LineSeries<SalesData, String>(
          dataSource: _monthlySales,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.target,
          name: 'Target',
          color: ThemeCollection.diSerria,
          markerSettings: const MarkerSettings(isVisible: true),
          dashArray: <double>[5, 5],
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top,
        textStyle: TextStyle(fontFamily: 'Cairo'),
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: ThemeCollection.whiteSmoke.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: SfCircularChart(
        margin: const EdgeInsets.all(16),
        series: <CircularSeries>[
          PieSeries<PieData, String>(
            dataSource: _salesByCategory,
            xValueMapper: (PieData data, _) => data.category,
            yValueMapper: (PieData data, _) => data.percentage,
            dataLabelMapper: (PieData data, _) => '${data.percentage}%',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(fontFamily: 'Cairo', fontSize: 10),
            ),
            pointColorMapper: (PieData data, _) => data.color,
            explode: true,
            explodeIndex: 0,
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          textStyle: TextStyle(fontFamily: 'Cairo'),
        ),
      ),
    );
  }

  Widget _buildEnhancedTopProductsTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ThemeCollection.matisse.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Top Selling Products', 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ThemeCollection.matisse.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.download, color: ThemeCollection.matisse, size: 18),
                  ),
                  onPressed: () => _exportReport('CSV'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(ThemeCollection.matisse.withOpacity(0.05)),
                headingTextStyle: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: ThemeCollection.matisse),
                dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return ThemeCollection.matisse.withOpacity(0.1);
                    }
                    return Colors.transparent;
                  },
                ),
                columns: [
                  DataColumn(label: Text('Product', style: TextStyle(fontFamily: 'Cairo'))),
                  DataColumn(label: Text('Units Sold', style: TextStyle(fontFamily: 'Cairo'))),
                  DataColumn(label: Text('Revenue', style: TextStyle(fontFamily: 'Cairo'))),
                  DataColumn(label: Text('Growth %', style: TextStyle(fontFamily: 'Cairo'))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontFamily: 'Cairo'))),
                ],
                rows: _topProducts.map((product) => DataRow(
                  cells: [
                    DataCell(Text(product['name'], style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse))),
                    DataCell(Text(product['sales'].toString(), style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse))),
                    DataCell(Text('\$${product['revenue']}', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: product['growth'] > 10 ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${product['growth']}%', 
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: product['growth'] > 10 ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          )),
                      ),
                    ),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.analytics, size: 18, color: ThemeCollection.matisse),
                          onPressed: () => _showProductAnalysis(product),
                        ),
                        IconButton(
                          icon: Icon(Icons.trending_up, size: 18, color: ThemeCollection.diSerria),
                          onPressed: () => _viewProductTrends(product),
                        ),
                      ],
                    )),
                  ],
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final List<Map<String, dynamic>> quickActions = [
      {'title': 'Generate Report', 'icon': Icons.assignment, 'color': Colors.blue},
      {'title': 'Schedule Export', 'icon': Icons.schedule, 'color': Colors.green},
      {'title': 'Share Dashboard', 'icon': Icons.share, 'color': Colors.purple},
      {'title': 'Print Report', 'icon': Icons.print, 'color': Colors.orange},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ThemeCollection.matisse.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Actions', 
              style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: quickActions.length,
              itemBuilder: (context, index) => _buildQuickActionCard(quickActions[index]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return InkWell(
      onTap: () {
        switch (action['title']) {
          case 'Generate Report':
            _exportReport('PDF');
            break;
          case 'Schedule Export':
            _showScheduleDialog();
            break;
          case 'Share Dashboard':
            _shareDashboard();
            break;
          case 'Print Report':
            _printReport();
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: action['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: action['color'].withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action['icon'] as IconData, color: action['color'], size: 32),
            const SizedBox(height: 8),
            Text(action['title'], 
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: ThemeCollection.matisse, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    final List<Map<String, dynamic>> activities = [
      {'action': 'Report Generated', 'details': 'Sales Analysis Q2', 'time': '2 hours ago', 'icon': Icons.description, 'color': Colors.green},
      {'action': 'Data Exported', 'details': 'Inventory Report', 'time': '5 hours ago', 'icon': Icons.download, 'color': Colors.blue},
      {'action': 'Dashboard Saved', 'details': 'Executive Overview', 'time': '1 day ago', 'icon': Icons.bookmark, 'color': Colors.purple},
      {'action': 'Filter Applied', 'details': 'Date Range Updated', 'time': '2 days ago', 'icon': Icons.filter_alt, 'color': Colors.orange},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ThemeCollection.matisse.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activity', 
              style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
            const SizedBox(height: 16),
            ...activities.map((activity) => _buildActivityItem(activity)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeCollection.whiteSmoke.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(activity['icon'] as IconData, color: activity['color'], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity['action'], 
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
                Text(activity['details'], 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: ThemeCollection.jumbo)),
              ],
            ),
          ),
          Text(activity['time'], 
            style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: ThemeCollection.jumbo)),
        ],
      ),
    );
  }

  // Other report sections
  Widget _buildSalesAnalysis() {
    return _buildReportList([
      'Total Sales by Month',
      'Sales by Product Category',
      'Customer Sales Analysis',
      'Sales Team Performance',
      'Revenue vs Target',
      'Sales Funnel Analysis',
      'Regional Sales Performance'
    ]);
  }

  Widget _buildPurchaseAnalysis() {
    return _buildReportList([
      'Purchases by Vendor',
      'Product Cost Trends',
      'Vendor Performance',
      'PO Lead Time Analysis',
      'Purchase Order Status'
    ]);
  }

  Widget _buildInventoryReports() {
    return _buildReportList([
      'Stock Valuation',
      'Stock Aging Report',
      'Fast/Slow Moving Items',
      'Reorder Point Alerts',
      'Inventory Turnover'
    ]);
  }

  Widget _buildFinancialReports() {
    return _buildReportList([
      'Profit & Loss Statement',
      'Balance Sheet',
      'Cash Flow Statement',
      'Budget vs Actual',
      'Financial Ratios'
    ]);
  }

  Widget _buildHRReports() {
    return _buildReportList([
      'Employee Attendance',
      'Payroll Analysis',
      'Performance Reviews',
      'Turnover Rate',
      'Training & Development'
    ]);
  }

  Widget _buildFixedAssetsReports() {
    return _buildReportList([
      'Asset Register',
      'Depreciation Schedule',
      'Asset Value by Category',
      'Maintenance Schedule'
    ]);
  }

  Widget _buildCRMReports() {
    return _buildReportList([
      'Leads by Source',
      'Conversion Rate',
      'Sales Pipeline',
      'Customer Lifetime Value',
      'Customer Segmentation'
    ]);
  }

  Widget _buildManufacturingReports() {
    return _buildReportList([
      'Production Efficiency',
      'Work Order Performance',
      'Scrap Rate Analysis',
      'Quality Control Metrics'
    ]);
  }

  Widget _buildBusinessIntelligence() {
    return _buildReportList([
      'Pivot Tables',
      'Custom Report Builder',
      'AI Trend Analysis',
      'Multi-Company Reports',
      'Predictive Analytics'
    ]);
  }

  Widget _buildReportList(List<String> reports) {
    final filteredReports = reports.where((report) => 
      report.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (_searchQuery.isNotEmpty) ...[
            Text('${filteredReports.length} reports found for "$_searchQuery"',
              style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo)),
            const SizedBox(height: 16),
          ],
          ...filteredReports.map((report) => _buildReportSection(report, _getIconForReport(report))),
        ],
      ),
    );
  }

  IconData _getIconForReport(String report) {
    if (report.contains('Sales')) return Icons.trending_up;
    if (report.contains('Customer')) return Icons.people;
    if (report.contains('Inventory')) return Icons.inventory;
    if (report.contains('Financial')) return Icons.attach_money;
    if (report.contains('HR')) return Icons.people_alt;
    if (report.contains('Asset')) return Icons.business;
    if (report.contains('Manufacturing')) return Icons.build;
    if (report.contains('AI') || report.contains('Predictive')) return Icons.psychology;
    return Icons.analytics;
  }

  Widget _buildReportSection(String title, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ThemeCollection.matisse.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: ThemeCollection.matisse),
        ),
        title: Text(title, style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.w500)),
        subtitle: Text('Last updated: ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
          style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo, fontSize: 12)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ThemeCollection.diSerria.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: IconButton(
                icon: Icon(Icons.visibility, size: 20, color: ThemeCollection.diSerria),
                onPressed: () => _viewReport(title),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              decoration: BoxDecoration(
                color: ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: IconButton(
                icon: Icon(Icons.download, size: 20, color: ThemeCollection.matisse),
                onPressed: () => _exportReport('PDF'),
              ),
            ),
          ],
        ),
        onTap: () => _viewReport(title),
      ),
    );
  }

  Widget _buildAdvancedFiltersSheet() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: ThemeCollection.matisse.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text('Advanced Filters', 
            style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
          const SizedBox(height: 16),
          
          // Chart Type
          DropdownButtonFormField(
            initialValue: _selectedChartType,
            decoration: InputDecoration(
              labelText: 'Chart Type',
              labelStyle: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ThemeCollection.matisse),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ThemeCollection.matisse, width: 2),
              ),
            ),
            dropdownColor: Colors.white,
            style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse),
            items: ['Bar', 'Line', 'Pie', 'Area', 'Scatter'].map((type) => 
              DropdownMenuItem(value: type, child: Text(type, style: TextStyle(fontFamily: 'Cairo')))).toList(),
            onChanged: (value) => setState(() => _selectedChartType = value!),
          ),
          const SizedBox(height: 12),
          
          // Report Type
          DropdownButtonFormField(
            initialValue: _selectedReportType,
            decoration: InputDecoration(
              labelText: 'Report Type',
              labelStyle: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ThemeCollection.matisse),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ThemeCollection.matisse, width: 2),
              ),
            ),
            dropdownColor: Colors.white,
            style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse),
            items: ['Sales', 'Financial', 'Inventory', 'HR', 'CRM', 'Manufacturing'].map((type) => 
              DropdownMenuItem(value: type, child: Text(type, style: TextStyle(fontFamily: 'Cairo')))).toList(),
            onChanged: (value) => setState(() => _selectedReportType = value!),
          ),
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ThemeCollection.matisse),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _applyAdvancedFilters();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeCollection.matisse,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Apply Filters', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action methods
  void _refreshData({bool silent = false}) {
    if (!silent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.refresh, color: Colors.white),
              const SizedBox(width: 8),
              Text('Data refreshed successfully!', style: TextStyle(fontFamily: 'Cairo')),
            ],
          ),
          backgroundColor: ThemeCollection.matisse,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _viewReport(String reportName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportDetailPage(reportName: reportName),
      ),
    );
  }

  void _showProductAnalysis(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Product Analysis: ${product['name']}', 
          style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.shopping_cart, color: ThemeCollection.matisse),
              title: Text('Units Sold', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
              trailing: Text(product['sales'].toString(), style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.attach_money, color: ThemeCollection.matisse),
              title: Text('Total Revenue', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
              trailing: Text('\$${product['revenue']}', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.trending_up, color: ThemeCollection.matisse),
              title: Text('Average Price', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
              trailing: Text('\$${(product['revenue'] / product['sales']).toStringAsFixed(2)}', 
                style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.analytics, color: ThemeCollection.matisse),
              title: Text('Growth Rate', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: product['growth'] > 10 ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${product['growth']}%', 
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: product['growth'] > 10 ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  )),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.jumbo)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _viewReport('${product['name']} Analysis');
            },
            style: ElevatedButton.styleFrom(backgroundColor: ThemeCollection.matisse),
            child: Text('View Full Report', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _viewProductTrends(Map<String, dynamic> product) {
    // Implementation for viewing product trends
  }

  void _showScheduleDialog() {
    // Implementation for schedule dialog
  }

  void _shareDashboard() {
    // Implementation for sharing dashboard
  }

  void _printReport() {
    // Implementation for printing report
  }

  void _applyAdvancedFilters() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.filter_alt, color: Colors.white),
            const SizedBox(width: 8),
            Text('Advanced filters applied!', style: TextStyle(fontFamily: 'Cairo')),
          ],
        ),
        backgroundColor: ThemeCollection.matisse,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Supporting page for report details
class ReportDetailPage extends StatelessWidget {
  final String reportName;

  const ReportDetailPage({super.key, required this.reportName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeCollection.whiteSmoke,
      appBar: AppBar(
        title: Text(reportName, style: TextStyle(fontFamily: 'Cairo', color: ThemeCollection.matisse)),
        backgroundColor: Colors.white,
        foregroundColor: ThemeCollection.matisse,
        elevation: 2,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ThemeCollection.matisse.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_back, color: ThemeCollection.matisse),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.download, color: ThemeCollection.matisse),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.share, color: ThemeCollection.matisse),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ThemeCollection.matisse.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Detailed $reportName', 
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: ThemeCollection.matisse)),
                    const SizedBox(height: 20),
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: ThemeCollection.whiteSmoke,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.2)),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.analytics, size: 64, color: ThemeCollection.matisse.withOpacity(0.5)),
                            const SizedBox(height: 16),
                            Text('Detailed Report Content', 
                              style: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: ThemeCollection.matisse)),
                            Text('Charts, Tables, Analysis', 
                              style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: ThemeCollection.matisse.withOpacity(0.7))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeCollection.matisse,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export PDF', style: TextStyle(fontFamily: 'Cairo')),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeCollection.diSerria,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(Icons.table_chart),
                  label: const Text('Export Excel', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}