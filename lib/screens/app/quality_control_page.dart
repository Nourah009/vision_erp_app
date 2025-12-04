// screens/quality_control_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/screens/models/quality_control_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class QualityControlPage extends StatefulWidget {
  final UserModel? user;
  
  const QualityControlPage({super.key, this.user});

  @override
  State<QualityControlPage> createState() => _QualityControlPageState();
}

class _QualityControlPageState extends State<QualityControlPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    // Handle tab selection if needed
    setState(() {});
  }

  // Sample data
  final List<InspectionModel> _inspections = [
    InspectionModel(
      id: 'QC001',
      itemName: 'Mobile Phone X1',
      lotNumber: 'LOT2024011501',
      orderNumber: 'PO-12345',
      inspector: 'Ahmed Ali',
      warehouse: 'Main Warehouse',
      status: 'Passed',
      inspectionType: 'Final',
      date: DateTime.now().subtract(const Duration(days: 1)),
      passedItems: 950,
      failedItems: 50,
      totalItems: 1000,
      imageUrl: 'https://via.placeholder.com/150',
      defects: ['Scratch', 'Dead Pixel'],
    ),
    InspectionModel(
      id: 'QC002',
      itemName: 'Laptop Battery',
      lotNumber: 'LOT2024011402',
      orderNumber: 'PO-12346',
      inspector: 'Sarah Mohamed',
      warehouse: 'Electronics WH',
      status: 'Failed',
      inspectionType: 'Incoming',
      date: DateTime.now().subtract(const Duration(days: 2)),
      passedItems: 200,
      failedItems: 50,
      totalItems: 250,
      defects: ['Overheating', 'Low Capacity'],
    ),
    InspectionModel(
      id: 'QC003',
      itemName: 'Smart Watch',
      lotNumber: 'LOT2024011303',
      orderNumber: 'PO-12347',
      inspector: 'Yasser Khan',
      warehouse: 'Gadgets WH',
      status: 'Pending',
      inspectionType: 'InProcess',
      date: DateTime.now(),
      passedItems: 0,
      failedItems: 0,
      totalItems: 500,
    ),
    InspectionModel(
      id: 'QC004',
      itemName: 'Bluetooth Headphones',
      lotNumber: 'LOT2024011204',
      orderNumber: 'PO-12348',
      inspector: 'Nora Ahmed',
      warehouse: 'Audio WH',
      status: 'WaitingApproval',
      inspectionType: 'Random',
      date: DateTime.now().subtract(const Duration(days: 1)),
      passedItems: 980,
      failedItems: 20,
      totalItems: 1000,
    ),
    InspectionModel(
      id: 'QC005',
      itemName: 'USB-C Cable',
      lotNumber: 'LOT2024011105',
      orderNumber: 'PO-12349',
      inspector: 'Omar Hassan',
      warehouse: 'Accessories WH',
      status: 'Passed',
      inspectionType: 'Supplier',
      date: DateTime.now().subtract(const Duration(days: 3)),
      passedItems: 2000,
      failedItems: 5,
      totalItems: 2005,
    ),
  ];

  final List<DefectReport> _defectReports = [
    DefectReport(
      id: 'DF001',
      inspectionId: 'QC002',
      defectType: 'Critical',
      description: 'Battery overheating during charging',
      rootCause: 'Faulty thermal management circuit',
      images: [],
      correctiveAction: 'Replace entire batch and review supplier quality',
      assignedTo: 'Quality Manager',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      status: 'Open',
      linkedOrder: 'PO-12346',
      batchNumber: 'LOT2024011402',
    ),
    DefectReport(
      id: 'DF002',
      inspectionId: 'QC001',
      defectType: 'Minor',
      description: 'Minor scratches on screen',
      rootCause: 'Improper handling during assembly',
      images: [],
      correctiveAction: 'Retrain assembly line staff',
      assignedTo: 'Production Supervisor',
      dueDate: DateTime.now().add(const Duration(days: 14)),
      status: 'InProgress',
      linkedOrder: 'PO-12345',
      batchNumber: 'LOT2024011501',
    ),
  ];

  final List<QCPlan> _qcPlans = [
    QCPlan(
      id: 'PL001',
      productName: 'Mobile Phone X1',
      productCode: 'MP-X1',
      checklist: [
        ChecklistItem(id: '1', description: 'Visual inspection - Screen', type: 'Visual', isMandatory: true),
        ChecklistItem(id: '2', description: 'Battery life test', type: 'Functional', isMandatory: true),
        ChecklistItem(id: '3', description: 'Camera functionality', type: 'Functional', isMandatory: true),
        ChecklistItem(id: '4', description: 'WiFi connectivity', type: 'Functional', isMandatory: true),
        ChecklistItem(id: '5', description: 'Packaging integrity', type: 'Packaging', isMandatory: true),
      ],
      measurementRules: {'weight': '200g ±5g', 'dimensions': '150x75x8mm ±1mm'},
      samplingMethod: 'Statistical',
      toleranceLevel: 1.5,
      inspectorLevel: 'Senior',
      createdDate: DateTime.now().subtract(const Duration(days: 30)),
      expiryDate: DateTime.now().add(const Duration(days: 60)),
    ),
  ];

  final List<QualityAlert> _qualityAlerts = [
    QualityAlert(
      id: 'AL001',
      type: 'Inspection Due',
      title: 'Batch QC001 Due Today',
      message: 'Final inspection for batch LOT2024011501 is due today',
      date: DateTime.now(),
      severity: 'High',
    ),
    QualityAlert(
      id: 'AL002',
      type: 'Defect Alert',
      title: 'High Failure Rate Detected',
      message: 'Battery batch showing 20% failure rate',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      severity: 'Critical',
    ),
    QualityAlert(
      id: 'AL003',
      type: 'Calibration Reminder',
      title: 'Measuring Tools Calibration',
      message: 'Calibration due for digital calipers next week',
      date: DateTime.now().subtract(const Duration(days: 1)),
      severity: 'Medium',
    ),
  ];

  // Statistics
  final Map<String, double> _defectsByCategory = {
    'Visual': 35,
    'Functional': 25,
    'Electrical': 20,
    'Mechanical': 15,
    'Packaging': 5,
  };

  final Map<String, double> _inspectionsByType = {
    'Incoming': 40,
    'InProcess': 30,
    'Final': 20,
    'Random': 7,
    'Supplier': 3,
  };

  


  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Core Functions
  void _startNewInspection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => NewInspectionSheet(
        onInspectionCreated: (inspection) {
          setState(() {
            _inspections.insert(0, inspection);
          });
        },
      ),
    );
  }

  void _viewInspectionDetails(InspectionModel inspection) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InspectionDetailPage(
          inspection: inspection,
          onInspectionUpdated: (updatedInspection) {
            setState(() {
              final index = _inspections.indexWhere((i) => i.id == inspection.id);
              if (index != -1) {
                _inspections[index] = updatedInspection;
              }
            });
          },
        ),
      ),
    );
  }

  void _createDefectReport(InspectionModel inspection) {
    showDialog(
      context: context,
      builder: (context) => DefectReportDialog(
        inspection: inspection,
        onReportCreated: (report) {
          setState(() {
            _defectReports.add(report);
          });
        },
      ),
    );
  }

  void _approveInspection(int index) {
    setState(() {
      _inspections[index].status = 'Passed';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Inspection ${_inspections[index].id} approved', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectInspection(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reject Inspection', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to reject inspection ${_inspections[index].id}?', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _inspections[index].status = 'Failed';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Inspection ${_inspections[index].id} rejected', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Reject', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _scanBarcode() {
    // Simulate barcode scanning
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Scan Barcode', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 60, color: AppColors.primaryColor),
            SizedBox(height: 16),
            Text('Point camera at barcode to scan', style: TextStyle(fontFamily: 'Cairo')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              // In real app, this would return scanned data
              Navigator.pop(context);
              _startNewInspection();
            },
            child: Text('Simulate Scan', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _showQCPlans() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QCPlansPage(plans: _qcPlans),
      ),
    );
  }

  void _showReports() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ReportsSheet(
        inspections: _inspections,
        defectReports: _defectReports,
      ),
    );
  }

  void _showAlerts() {
    showDialog(
      context: context,
      builder: (context) => QualityAlertsDialog(alerts: _qualityAlerts),
    );
  }

  // Filter inspections
  List<InspectionModel> get _filteredInspections {
    List<InspectionModel> filtered = _inspections;
    
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((inspection) =>
        inspection.itemName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        inspection.lotNumber.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        inspection.orderNumber.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        inspection.inspector.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    if (_selectedFilter != 'All') {
      filtered = filtered.where((inspection) => inspection.status == _selectedFilter).toList();
    }
    
    return filtered;
  }

  // Utility functions
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Passed': return Colors.green;
      case 'Failed': return Colors.red;
      case 'Pending': return Colors.orange;
      case 'WaitingApproval': return Colors.purple;
      default: return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Passed': return Icons.check_circle;
      case 'Failed': return Icons.cancel;
      case 'Pending': return Icons.pending;
      case 'WaitingApproval': return Icons.hourglass_top;
      default: return Icons.help;
    }
  }

  Color _getDefectColor(String type) {
    switch (type) {
      case 'Critical': return Colors.red;
      case 'Major': return Colors.orange;
      case 'Minor': return Colors.yellow;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalInspections = _inspections.length;
    final pendingInspections = _inspections.where((i) => i.status == 'Pending').length;
    final passedItems = _inspections.fold(0, (sum, i) => sum + i.passedItems);
    final failedItems = _inspections.fold(0, (sum, i) => sum + i.failedItems);
    final inspectedItems = passedItems + failedItems;
    final passRate = inspectedItems > 0 ? (passedItems / inspectedItems * 100) : 0.0;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          'Quality Control',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.primaryColor.withOpacity(0.5),
          indicatorColor: AppColors.primaryColor,
          tabs: const [
            Tab(text: 'Dashboard'),
            Tab(text: 'Inspections'),
            Tab(text: 'Defects'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(totalInspections, pendingInspections, passedItems, failedItems , passRate),
          _buildInspectionsTab(),
          _buildDefectsTab(),
          _buildAnalyticsTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab(int totalInspections, int pendingInspections, int passedItems, int failedItems, double passRate) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
          Row(
            children: [
              _buildStatCard('Total Inspections', totalInspections.toString(), Colors.blue, Icons.checklist),
              SizedBox(width: 12),
              _buildStatCard('Pending', pendingInspections.toString(), Colors.orange, Icons.pending),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Passed', passedItems.toString(), Colors.green, Icons.check_circle),
              SizedBox(width: 12),
              _buildStatCard('Failed', failedItems.toString(), Colors.red, Icons.cancel),
            ],
          ),
          SizedBox(height: 12),
          _buildStatCard('Pass Rate', '${passRate.toStringAsFixed(1)}%', Colors.teal, Icons.trending_up),

          // Quick Actions
          SizedBox(height: 20),
          Text('Quick Actions', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton('New Inspection', Icons.add_circle, Colors.blue, _startNewInspection),
              _buildActionButton('Scan Barcode', Icons.qr_code_scanner, Colors.green, _scanBarcode),
              _buildActionButton('QC Plans', Icons.list_alt, Colors.orange, _showQCPlans),
              _buildActionButton('Reports', Icons.assessment, Colors.purple, _showReports),
              _buildActionButton('Alerts', Icons.notifications, Colors.red, _showAlerts),
              _buildActionButton('Camera', Icons.camera_alt, Colors.brown, () {}),
            ],
          ),

          // Recent Alerts
          SizedBox(height: 20),
          _buildRecentAlerts(),

          // Defect Categories Chart
          SizedBox(height: 20),
          _buildDefectCategoriesChart(),

          // Recent Inspections
          SizedBox(height: 20),
          _buildRecentInspections(),
        ],
      ),
    );
  }

  Widget _buildInspectionsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search inspections...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 12),
              
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All'),
                    _buildFilterChip('Pending'),
                    _buildFilterChip('Passed'),
                    _buildFilterChip('Failed'),
                    _buildFilterChip('WaitingApproval'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _filteredInspections.isEmpty
              ? Center(
                  child: Text(
                    'No inspections found',
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _filteredInspections.length,
                  itemBuilder: (context, index) {
                    final inspection = _filteredInspections[index];
                    return _buildInspectionCard(inspection, index);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDefectsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Defect Reports', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._defectReports.map((report) => _buildDefectCard(report)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_inspections.isNotEmpty) {
                _createDefectReport(_inspections.first);
              }
            },
            icon: Icon(Icons.bug_report),
            label: Text('New Defect Report', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quality Analytics', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          
          // Pass/Fail Rate Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pass/Fail Rate', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: _buildPassFailChart(),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Defects by Category
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Defects by Category', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._defectsByCategory.entries.map((entry) => _buildCategoryRow(entry.key, entry.value)),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Inspections by Type
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Inspections by Type', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._inspectionsByType.entries.map((entry) => _buildInspectionTypeRow(entry.key, entry.value)),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),
          
          // Export Button
          ElevatedButton.icon(
            onPressed: () {
              _exportReport();
            },
            icon: Icon(Icons.download),
            label: Text('Export Report', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _startNewInspection,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      icon: Icon(Icons.add),
      label: Text('New Inspection', style: TextStyle(fontFamily: 'Cairo')),
    );
  }

  // Helper Widgets
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(height: 8),
              Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAlerts() {
    final recentAlerts = _qualityAlerts.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Alerts', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${_qualityAlerts.length}', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 12),
            ...recentAlerts.map((alert) => _buildAlertItem(alert)),
            if (recentAlerts.isEmpty)
              Text('No alerts', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(QualityAlert alert) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: alert.severity == 'Critical' ? Colors.red :
                alert.severity == 'High' ? Colors.orange :
                alert.severity == 'Medium' ? Colors.blue : Colors.grey,
        ),
        title: Text(alert.title, style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Text(alert.message, style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
        trailing: Text(_formatTime(alert.date), style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      ),
    );
  }

  Widget _buildDefectCategoriesChart() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Defect Categories', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildDefectCategoryItem('Visual', 35, Colors.blue),
                        _buildDefectCategoryItem('Functional', 25, Colors.green),
                        _buildDefectCategoryItem('Electrical', 20, Colors.orange),
                        _buildDefectCategoryItem('Mechanical', 15, Colors.purple),
                        _buildDefectCategoryItem('Packaging', 5, Colors.brown),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: _buildPieChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefectCategoryItem(String category, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(category, style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ),
          Text('$percentage%', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    final data = [
      _ChartData('Visual', 35.0, Colors.blue),
      _ChartData('Functional', 25.0, Colors.green),
      _ChartData('Electrical', 20.0, Colors.orange),
      _ChartData('Mechanical', 15.0, Colors.purple),
      _ChartData('Packaging', 5.0, Colors.brown),
    ];

    return SfCircularChart(
      series: <PieSeries<_ChartData, String>>[
        PieSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.category,
          yValueMapper: (_ChartData data, _) => data.value.toDouble(),
          pointColorMapper: (_ChartData data, _) => data.color,
          dataLabelMapper: (_ChartData data, _) => '${data.category}: ${data.value.toInt()}%',
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  Widget _buildRecentInspections() {
    final recentInspections = _inspections.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Inspections', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    _tabController.animateTo(1); // Switch to inspections tab
                  },
                  child: Text('View All', style: TextStyle(fontFamily: 'Cairo', color: AppColors.primaryColor)),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...recentInspections.map((inspection) => _buildRecentInspectionItem(inspection)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentInspectionItem(InspectionModel inspection) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(_getStatusIcon(inspection.status), color: _getStatusColor(inspection.status)),
        title: Text(inspection.itemName, style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Text('${inspection.lotNumber} • ${_formatDate(inspection.date)}', style: TextStyle(fontFamily: 'Cairo')),
        trailing: Chip(
          label: Text(
            '${inspection.passedItems}/${inspection.totalItems}',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.white),
          ),
          backgroundColor: _getStatusColor(inspection.status),
        ),
        onTap: () => _viewInspectionDetails(inspection),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(filter, style: TextStyle(fontFamily: 'Cairo')),
        selected: _selectedFilter == filter,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? filter : 'All';
          });
        },
        backgroundColor: Colors.grey[200],
        selectedColor: AppColors.primaryColor.withOpacity(0.2),
        labelStyle: TextStyle(
          color: _selectedFilter == filter ? AppColors.primaryColor : Colors.black,
          fontFamily: 'Cairo',
        ),
        checkmarkColor: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildInspectionCard(InspectionModel inspection, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(inspection.status).withOpacity(0.1),
          child: Icon(_getStatusIcon(inspection.status), color: _getStatusColor(inspection.status)),
        ),
        title: Text(inspection.itemName, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lot: ${inspection.lotNumber} • Order: ${inspection.orderNumber}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Inspector: ${inspection.inspector} • Type: ${inspection.inspectionType}', 
                 style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            Text(_formatDate(inspection.date), style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(inspection.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                inspection.status,
                style: TextStyle(
                  color: _getStatusColor(inspection.status),
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (inspection.status == 'Pending' || inspection.status == 'WaitingApproval')
              SizedBox(height: 4),
            if (inspection.status == 'Pending')
              TextButton(
                onPressed: () => _viewInspectionDetails(inspection),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Text('Start', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ),
          ],
        ),
        onTap: () => _viewInspectionDetails(inspection),
        onLongPress: () {
          if (inspection.status == 'WaitingApproval') {
            _showApprovalOptions(index);
          }
        },
      ),
    );
  }

  void _showApprovalOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Approve Inspection?', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _approveInspection(index);
                    },
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text('Approve', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _rejectInspection(index);
                    },
                    icon: Icon(Icons.close, color: Colors.white),
                    label: Text('Reject', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefectCard(DefectReport report) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(report.description, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        subtitle: Text('Type: ${report.defectType} • Status: ${report.status}', style: TextStyle(fontFamily: 'Cairo')),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getDefectColor(report.defectType).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.bug_report,
            color: _getDefectColor(report.defectType),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Root Cause:', report.rootCause),
                _buildDetailRow('Corrective Action:', report.correctiveAction),
                _buildDetailRow('Assigned To:', report.assignedTo),
                _buildDetailRow('Due Date:', _formatDate(report.dueDate)),
                if (report.linkedOrder != null) _buildDetailRow('Linked Order:', report.linkedOrder!),
                if (report.batchNumber != null) _buildDetailRow('Batch:', report.batchNumber!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontFamily: 'Cairo'))),
        ],
      ),
    );
  }

  Widget _buildPassFailChart() {
    final passed = _inspections.fold(0, (sum, i) => sum + i.passedItems);
    final failed = _inspections.fold(0, (sum, i) => sum + i.failedItems);

    final data = [
      _ChartData('Passed', passed.toDouble(), Colors.green),
      _ChartData('Failed', failed.toDouble(), Colors.red),
    ];

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries<_ChartData, String>>[
        BarSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.category,
          yValueMapper: (_ChartData data, _) => data.value.toDouble(),
          pointColorMapper: (_ChartData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  Widget _buildCategoryRow(String category, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: TextStyle(fontFamily: 'Cairo')),
              Text('$percentage%', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(_getChartColor(category)),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionTypeRow(String type, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type, style: TextStyle(fontFamily: 'Cairo')),
              Text('$percentage%', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(_getInspectionTypeColor(type)),
          ),
        ],
      ),
    );
  }

  Color _getChartColor(String category) {
    switch (category) {
      case 'Visual': return Colors.blue;
      case 'Functional': return Colors.green;
      case 'Electrical': return Colors.orange;
      case 'Mechanical': return Colors.purple;
      case 'Packaging': return Colors.brown;
      default: return Colors.grey;
    }
  }

  Color _getInspectionTypeColor(String type) {
    switch (type) {
      case 'Incoming': return Colors.blue;
      case 'InProcess': return Colors.green;
      case 'Final': return Colors.orange;
      case 'Random': return Colors.purple;
      case 'Supplier': return Colors.brown;
      default: return Colors.grey;
    }
  }

  void _exportReport() async {
    // Simulate report export
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generating report...', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: AppColors.primaryColor,
      ),
    );
    
    await Future.delayed(Duration(seconds: 2));
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report Ready', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Quality control report has been generated. Where would you like to export it?', 
                     style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Report exported as PDF', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: Icon(Icons.picture_as_pdf),
            label: Text('Export as PDF', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Report exported as Excel', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: Icon(Icons.table_chart),
            label: Text('Export as Excel', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _ChartData {
  final String category;
  final double value;
  final Color color;

  _ChartData(this.category, this.value, this.color);
}

// Supporting Widgets
class NewInspectionSheet extends StatefulWidget {
  final Function(InspectionModel) onInspectionCreated;

  const NewInspectionSheet({super.key, required this.onInspectionCreated});

  @override
  State<NewInspectionSheet> createState() => _NewInspectionSheetState();
}

class _NewInspectionSheetState extends State<NewInspectionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _lotNumberController = TextEditingController();
  final _orderNumberController = TextEditingController();
  final _totalItemsController = TextEditingController();
  String _selectedType = 'Incoming';
  final String _selectedWarehouse = 'Main Warehouse';
  final String _selectedInspector = 'Ahmed Ali';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('New Inspection', style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _itemNameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _lotNumberController,
                  decoration: InputDecoration(
                    labelText: 'Lot/Batch Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _orderNumberController,
                  decoration: InputDecoration(
                    labelText: 'Order Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: _selectedType,
                  items: ['Incoming', 'InProcess', 'Final', 'Random', 'Supplier']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                  decoration: InputDecoration(labelText: 'Inspection Type'),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _totalItemsController,
                  decoration: InputDecoration(
                    labelText: 'Total Items',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final inspection = InspectionModel(
                        id: 'QC${DateTime.now().millisecondsSinceEpoch}',
                        itemName: _itemNameController.text,
                        lotNumber: _lotNumberController.text,
                        orderNumber: _orderNumberController.text,
                        inspector: _selectedInspector,
                        warehouse: _selectedWarehouse,
                        status: 'Pending',
                        inspectionType: _selectedType,
                        date: DateTime.now(),
                        totalItems: int.tryParse(_totalItemsController.text) ?? 0,
                      );
                      widget.onInspectionCreated(inspection);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('New inspection created', style: TextStyle(fontFamily: 'Cairo')),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: Text('Create', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InspectionDetailPage extends StatefulWidget {
  final InspectionModel inspection;
  final Function(InspectionModel) onInspectionUpdated;

  const InspectionDetailPage({super.key, required this.inspection, required this.onInspectionUpdated});

  @override
  State<InspectionDetailPage> createState() => _InspectionDetailPageState();
}

class _InspectionDetailPageState extends State<InspectionDetailPage> {
  late InspectionModel _inspection;
  List<ChecklistItem> _checklist = [];
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _inspection = widget.inspection;
    _loadChecklist();
  }

  void _loadChecklist() {
    // Load checklist based on inspection type
    _checklist = [
      ChecklistItem(id: '1', description: 'Visual inspection for damages', type: 'Visual', isMandatory: true),
      ChecklistItem(id: '2', description: 'Check packaging integrity', type: 'Packaging', isMandatory: true),
      ChecklistItem(id: '3', description: 'Verify product dimensions', type: 'Measurement', unit: 'mm', minValue: 100, maxValue: 110),
      ChecklistItem(id: '4', description: 'Test basic functionality', type: 'Functional', isMandatory: true),
      ChecklistItem(id: '5', description: 'Check labeling and markings', type: 'Visual', isMandatory: true),
    ];
  }

  void _completeStep(bool passed, String? notes) {
    setState(() {
      if (passed) {
        _inspection.passedItems++;
      } else {
        _inspection.failedItems++;
        _inspection.defects.add(_checklist[_currentStep].description);
      }
      
      if (_currentStep < _checklist.length - 1) {
        _currentStep++;
      } else {
        _inspection.status = 'WaitingApproval';
        widget.onInspectionUpdated(_inspection);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inspection completed. Waiting for approval.', style: TextStyle(fontFamily: 'Cairo')),
            backgroundColor: Colors.orange,
          ),
        );
      }
    });
  }

  void _takePhoto() {
    // Simulate camera functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Camera opened', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspection Details', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePhoto,
            tooltip: 'Take Photo',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inspection Info
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_inspection.itemName, style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildInfoRow('Lot Number:', _inspection.lotNumber),
                    _buildInfoRow('Order Number:', _inspection.orderNumber),
                    _buildInfoRow('Inspector:', _inspection.inspector),
                    _buildInfoRow('Type:', _inspection.inspectionType),
                    _buildInfoRow('Status:', _inspection.status),
                    SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: _inspection.totalItems > 0 ? (_inspection.passedItems + _inspection.failedItems) / _inspection.totalItems : 0,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Progress:', style: TextStyle(fontFamily: 'Cairo')),
                        Text(
                          '${_inspection.passedItems + _inspection.failedItems}/${_inspection.totalItems}',
                          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Checklist Steps
            Text('Checklist', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            
            ..._checklist.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              
              return Card(
                margin: EdgeInsets.only(bottom: 8),
                color: index == _currentStep ? AppColors.primaryColor.withOpacity(0.1) : null,
                child: ListTile(
                  leading: index < _currentStep 
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : index == _currentStep
                          ? Icon(Icons.radio_button_checked, color: AppColors.primaryColor)
                          : Icon(Icons.radio_button_unchecked, color: Colors.grey),
                  title: Text(item.description, style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: item.type == 'Measurement' 
                      ? Text('${item.minValue}-${item.maxValue} ${item.unit}', style: TextStyle(fontFamily: 'Cairo'))
                      : null,
                  trailing: index == _currentStep && _inspection.status == 'Pending'
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () => _completeStep(true, null),
                              tooltip: 'Pass',
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => _completeStep(false, null),
                              tooltip: 'Fail',
                            ),
                          ],
                        )
                      : null,
                ),
              );
            }),
            
            if (_inspection.status == 'Pending')
              SizedBox(height: 20),
            
            if (_inspection.status == 'Pending')
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _completeStep(true, null),
                      icon: Icon(Icons.check),
                      label: Text('Mark All Passed', style: TextStyle(fontFamily: 'Cairo')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _completeStep(false, null),
                      icon: Icon(Icons.close),
                      label: Text('Mark All Failed', style: TextStyle(fontFamily: 'Cairo')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            
            if (_inspection.defects.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text('Defects Found', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                  ..._inspection.defects.map((defect) => 
                    Card(
                      margin: EdgeInsets.only(top: 4),
                      color: Colors.red[50],
                      child: ListTile(
                        leading: Icon(Icons.error, color: Colors.red),
                        title: Text(defect, style: TextStyle(fontFamily: 'Cairo', color: Colors.red)),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$label ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }
}

class DefectReportDialog extends StatefulWidget {
  final InspectionModel inspection;
  final Function(DefectReport) onReportCreated;

  const DefectReportDialog({super.key, required this.inspection, required this.onReportCreated});

  @override
  State<DefectReportDialog> createState() => _DefectReportDialogState();
}

class _DefectReportDialogState extends State<DefectReportDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _rootCauseController = TextEditingController();
  final _correctiveActionController = TextEditingController();
  String _selectedDefectType = 'Minor';
  String _selectedAssignee = 'Quality Manager';
  DateTime _selectedDueDate = DateTime.now().add(Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Defect Report', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Inspection: ${widget.inspection.id}', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Defect Description'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField(
                initialValue: _selectedDefectType,
                items: ['Minor', 'Major', 'Critical']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedDefectType = value!),
                decoration: InputDecoration(labelText: 'Defect Type'),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _rootCauseController,
                decoration: InputDecoration(labelText: 'Root Cause'),
                maxLines: 2,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _correctiveActionController,
                decoration: InputDecoration(labelText: 'Corrective Action'),
                maxLines: 2,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField(
                initialValue: _selectedAssignee,
                items: ['Quality Manager', 'Production Supervisor', 'Maintenance', 'Supplier']
                    .map((person) => DropdownMenuItem(value: person, child: Text(person)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedAssignee = value!),
                decoration: InputDecoration(labelText: 'Assign To'),
              ),
              SizedBox(height: 12),
              ListTile(
                title: Text('Due Date: ${_formatDate(_selectedDueDate)}', style: TextStyle(fontFamily: 'Cairo')),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) {
                    setState(() => _selectedDueDate = date);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final report = DefectReport(
                id: 'DF${DateTime.now().millisecondsSinceEpoch}',
                inspectionId: widget.inspection.id,
                defectType: _selectedDefectType,
                description: _descriptionController.text,
                rootCause: _rootCauseController.text,
                correctiveAction: _correctiveActionController.text,
                assignedTo: _selectedAssignee,
                dueDate: _selectedDueDate,
                linkedOrder: widget.inspection.orderNumber,
                batchNumber: widget.inspection.lotNumber,
              );
              widget.onReportCreated(report);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Defect report created', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: Text('Create Report', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class QCPlansPage extends StatelessWidget {
  final List<QCPlan> plans;

  const QCPlansPage({super.key, required this.plans});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QC Plans', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(plan.productName, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              subtitle: Text('Code: ${plan.productCode}', style: TextStyle(fontFamily: 'Cairo')),
              leading: Icon(Icons.list_alt, color: AppColors.primaryColor),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Checklist:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                      ...plan.checklist.map((item) => 
                        ListTile(
                          leading: Icon(Icons.check, size: 16),
                          title: Text(item.description, style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
                          subtitle: item.type != 'Visual' 
                              ? Text('Type: ${item.type}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12))
                              : null,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Sampling Method: ${plan.samplingMethod}', style: TextStyle(fontFamily: 'Cairo')),
                      Text('Tolerance Level: ±${plan.toleranceLevel}', style: TextStyle(fontFamily: 'Cairo')),
                      if (plan.expiryDate != null)
                        Text('Expires: ${_formatDate(plan.expiryDate!)}', style: TextStyle(fontFamily: 'Cairo')),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class ReportsSheet extends StatelessWidget {
  final List<InspectionModel> inspections;
  final List<DefectReport> defectReports;

  const ReportsSheet({super.key, required this.inspections, required this.defectReports});

  @override
  Widget build(BuildContext context) {
    final passedInspections = inspections.where((i) => i.status == 'Passed').length;
    final failedInspections = inspections.where((i) => i.status == 'Failed').length;
    final totalDefects = defectReports.length;
    final criticalDefects = defectReports.where((d) => d.defectType == 'Critical').length;

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Quality Reports', style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Summary', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  _buildReportRow('Total Inspections:', inspections.length.toString()),
                  _buildReportRow('Passed Inspections:', passedInspections.toString()),
                  _buildReportRow('Failed Inspections:', failedInspections.toString()),
                  _buildReportRow('Total Defects:', totalDefects.toString()),
                  _buildReportRow('Critical Defects:', criticalDefects.toString()),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Export as PDF
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Report exported as PDF', style: TextStyle(fontFamily: 'Cairo')),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text('PDF', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Export as Excel
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Report exported as Excel', style: TextStyle(fontFamily: 'Cairo')),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: Icon(Icons.table_chart),
                  label: Text('Excel', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12),
          
          ElevatedButton.icon(
            onPressed: () {
              // Email report
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Report sent via email', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            icon: Icon(Icons.email),
            label: Text('Email Report', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Cairo')),
          Text(value, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class QualityAlertsDialog extends StatelessWidget {
  final List<QualityAlert> alerts;

  const QualityAlertsDialog({super.key, required this.alerts});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Quality Alerts', style: TextStyle(fontFamily: 'Cairo')),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return Card(
              margin: EdgeInsets.only(bottom: 8),
              color: _getAlertColor(alert.severity).withOpacity(0.1),
              child: ListTile(
                leading: Icon(Icons.notifications, color: _getAlertColor(alert.severity)),
                title: Text(alert.title, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert.message, style: TextStyle(fontFamily: 'Cairo')),
                    SizedBox(height: 4),
                    Text('${_formatTime(alert.date)} • ${alert.severity}', 
                         style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: _getAlertColor(alert.severity))),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward, size: 16),
                  onPressed: () {
                    // View alert details
                  },
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  Color _getAlertColor(String severity) {
    switch (severity) {
      case 'Critical': return Colors.red;
      case 'High': return Colors.orange;
      case 'Medium': return Colors.blue;
      case 'Low': return Colors.green;
      default: return Colors.grey;
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}