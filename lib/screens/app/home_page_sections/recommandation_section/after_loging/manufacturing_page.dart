import 'package:flutter/material.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';


class ManufacturingPage extends StatefulWidget {
  final UserModel? user;
  
  const ManufacturingPage({super.key, this.user});

  @override
  State<ManufacturingPage> createState() => _ManufacturingPageState();
}

class _ManufacturingPageState extends State<ManufacturingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Sample data for demonstration
  final List<Map<String, dynamic>> _bomList = [
    {'id': 'BOM001', 'product': 'Smartphone X1', 'version': '1.0', 'components': 15, 'cost': 450.0, 'status': 'Active'},
    {'id': 'BOM002', 'product': 'Laptop Pro', 'version': '2.1', 'components': 28, 'cost': 1200.0, 'status': 'Active'},
    {'id': 'BOM003', 'product': 'Tablet Mini', 'version': '1.2', 'components': 12, 'cost': 320.0, 'status': 'Draft'},
  ];

  final List<Map<String, dynamic>> _manufacturingOrders = [
    {'id': 'MO001', 'product': 'Smartphone X1', 'quantity': 100, 'plannedDate': '2024-02-15', 'deadline': '2024-02-20', 'status': 'In Progress', 'progress': 65},
    {'id': 'MO002', 'product': 'Laptop Pro', 'quantity': 50, 'plannedDate': '2024-02-10', 'deadline': '2024-02-25', 'status': 'Confirmed', 'progress': 0},
    {'id': 'MO003', 'product': 'Tablet Mini', 'quantity': 200, 'plannedDate': '2024-02-05', 'deadline': '2024-02-12', 'status': 'Done', 'progress': 100},
  ];

  final List<Map<String, dynamic>> _workCenters = [
    {'id': 'WC001', 'name': 'Assembly Line 1', 'type': 'Assembly', 'status': 'Running', 'efficiency': 85, 'load': 75, 'oee': 78},
    {'id': 'WC002', 'name': 'Testing Station', 'type': 'Quality', 'status': 'Running', 'efficiency': 92, 'load': 60, 'oee': 88},
    {'id': 'WC003', 'name': 'Packaging Line', 'type': 'Packaging', 'status': 'Maintenance', 'efficiency': 0, 'load': 0, 'oee': 0},
  ];

  final List<Map<String, dynamic>> _qualityChecks = [
    {'id': 'QC001', 'product': 'Smartphone X1', 'checkType': 'Final Inspection', 'inspector': 'Ahmed Ali', 'result': 'Pass', 'date': '2024-02-14'},
    {'id': 'QC002', 'product': 'Laptop Pro', 'checkType': 'In-Process', 'inspector': 'Sarah Mohamed', 'result': 'Fail', 'date': '2024-02-13'},
    {'id': 'QC003', 'product': 'Tablet Mini', 'checkType': 'Raw Material', 'inspector': 'Yasser Khan', 'result': 'Pass', 'date': '2024-02-12'},
  ];

  final List<Map<String, dynamic>> _maintenanceRequests = [
    {'id': 'MT001', 'machine': 'Packaging Line', 'type': 'Preventive', 'priority': 'High', 'status': 'In Progress', 'assignedTo': 'Maintenance Team'},
    {'id': 'MT002', 'machine': 'Assembly Robot', 'type': 'Corrective', 'priority': 'Medium', 'status': 'Scheduled', 'assignedTo': 'Tech Ahmed'},
  ];

  // Dashboard KPIs
  final Map<String, dynamic> _dashboardData = {
    'totalOrders': 15,
    'inProgress': 8,
    'delayed': 2,
    'completedToday': 25,
    'efficiencyRate': 87.5,
    'scrapRate': 2.3,
    'oee': 82.1,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Core Manufacturing Functions
  void _showBomDetails(Map<String, dynamic> bom) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('BOM Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('BOM ID', bom['id']),
              _buildDetailRow('Product', bom['product']),
              _buildDetailRow('Version', bom['version']),
              _buildDetailRow('Components', bom['components'].toString()),
              _buildDetailRow('Cost', '\$${bom['cost']}'),
              _buildDetailRow('Status', bom['status']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _editBom(bom),
            child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _editBom(Map<String, dynamic> bom) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => BomManagementDialog(
        bom: bom,
        onBomUpdated: (updatedBom) {
          setState(() {
            final index = _bomList.indexWhere((b) => b['id'] == bom['id']);
            if (index != -1) {
              _bomList[index] = {..._bomList[index], ...updatedBom};
            }
          });
        },
      ),
    );
  }

  void _createManufacturingOrder() {
    showDialog(
      context: context,
      builder: (context) => ManufacturingOrderDialog(
        onOrderCreated: (order) {
          setState(() {
            _manufacturingOrders.insert(0, order);
          });
        },
      ),
    );
  }

  void _updateOrderStatus(int index, String status) {
    setState(() {
      _manufacturingOrders[index]['status'] = status;
      if (status == 'Done') {
        _manufacturingOrders[index]['progress'] = 100;
      } else if (status == 'In Progress') {
        _manufacturingOrders[index]['progress'] = 50;
      }
    });
  }

  void _showWorkOrderDetails(Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkOrderDetailPage(
          order: order,
          onStatusUpdated: (updatedOrder) {
            setState(() {
              final index = _manufacturingOrders.indexWhere((o) => o['id'] == order['id']);
              if (index != -1) {
                _manufacturingOrders[index] = updatedOrder;
              }
            });
          },
        ),
      ),
    );
  }

  void _showQualityControl() {
    showDialog(
      context: context,
      builder: (context) => QualityControlDialog(
        onCheckAdded: (check) {
          setState(() {
            _qualityChecks.insert(0, check);
          });
        },
      ),
    );
  }

  void _showMaintenanceRequest() {
    showDialog(
      context: context,
      builder: (context) => MaintenanceRequestDialog(
        workCenters: _workCenters,
        onRequestCreated: (request) {
          setState(() {
            _maintenanceRequests.insert(0, request);
          });
        },
      ),
    );
  }

  void _showProductionScheduling() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductionSchedulingPage(
          orders: _manufacturingOrders,
          workCenters: _workCenters,
        ),
      ),
    );
  }

  // Utility Functions
  

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Done': return Colors.green;
      case 'In Progress': return Colors.blue;
      case 'Confirmed': return Colors.orange;
      case 'Draft': return Colors.grey;
      case 'Running': return Colors.green;
      case 'Maintenance': return Colors.red;
      case 'Pass': return Colors.green;
      case 'Fail': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          'Manufacturing Management',
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
            Tab(text: 'BOM'),
            Tab(text: 'Production'),
            Tab(text: 'Work Centers'),
            Tab(text: 'Quality'),
            Tab(text: 'Maintenance'),
            Tab(text: 'Planning'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildBomTab(),
          _buildProductionTab(),
          _buildWorkCentersTab(),
          _buildQualityTab(),
          _buildMaintenanceTab(),
          _buildPlanningTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
          Row(
            children: [
              _buildStatCard('Total Orders', _dashboardData['totalOrders'].toString(), Colors.blue, Icons.assignment),
              SizedBox(width: 12),
              _buildStatCard('In Progress', _dashboardData['inProgress'].toString(), Colors.orange, Icons.build),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Delayed', _dashboardData['delayed'].toString(), Colors.red, Icons.warning),
              SizedBox(width: 12),
              _buildStatCard('Efficiency', '${_dashboardData['efficiencyRate']}%', Colors.green, Icons.trending_up),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('OEE', '${_dashboardData['oee']}%', Colors.teal, Icons.assessment),
              SizedBox(width: 12),
              _buildStatCard('Scrap Rate', '${_dashboardData['scrapRate']}%', Colors.purple, Icons.warning_amber),
            ],
          ),

          SizedBox(height: 20),

          // Quick Actions
          Text('Quick Actions', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton('Create MO', Icons.add_circle, Colors.blue, _createManufacturingOrder),
              _buildActionButton('BOM Management', Icons.list_alt, Colors.green, () => _editBom({})),
              _buildActionButton('Quality Check', Icons.verified, Colors.orange, _showQualityControl),
              _buildActionButton('Maintenance', Icons.build_circle, Colors.red, _showMaintenanceRequest),
              _buildActionButton('Schedule', Icons.schedule, Colors.purple, _showProductionScheduling),
              _buildActionButton('Reports', Icons.analytics, Colors.teal, () {}),
            ],
          ),

          // Recent Manufacturing Orders
          SizedBox(height: 20),
          _buildRecentOrders(),

          // Work Center Status
          SizedBox(height: 20),
          _buildWorkCenterStatus(),
        ],
      ),
    );
  }

  Widget _buildBomTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search BOM...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _editBom({}),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _bomList.length,
            itemBuilder: (context, index) {
              final bom = _bomList[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.list_alt, color: AppColors.primaryColor),
                  ),
                  title: Text(bom['product'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('Version: ${bom['version']} • Components: ${bom['components']}', 
                    style: TextStyle(fontFamily: 'Cairo')),
                  trailing: Chip(
                    label: Text(bom['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: _getStatusColor(bom['status']),
                  ),
                  onTap: () => _showBomDetails(bom),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductionTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text('Manufacturing Orders', 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton.icon(
                onPressed: _createManufacturingOrder,
                icon: Icon(Icons.add),
                label: Text('New Order', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _manufacturingOrders.length,
            itemBuilder: (context, index) {
              final order = _manufacturingOrders[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(order['status']).withOpacity(0.1),
                    child: Icon(Icons.build, color: _getStatusColor(order['status'])),
                  ),
                  title: Text(order['product'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Qty: ${order['quantity']} • ${order['deadline']}', style: TextStyle(fontFamily: 'Cairo')),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: order['progress'] / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(order['status'])),
                      ),
                      Text('Progress: ${order['progress']}%', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('View Details', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showWorkOrderDetails(order),
                      ),
                      PopupMenuItem(
                        child: Text('Start Production', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _updateOrderStatus(index, 'In Progress'),
                      ),
                      PopupMenuItem(
                        child: Text('Mark Complete', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _updateOrderStatus(index, 'Done'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWorkCentersTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ..._workCenters.map((center) => Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(center['status']).withOpacity(0.1),
              child: Icon(Icons.engineering, color: _getStatusColor(center['status'])),
            ),
            title: Text(center['name'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(center['type'], style: TextStyle(fontFamily: 'Cairo')),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.trending_up, size: 16, color: Colors.green),
                    SizedBox(width: 4),
                    Text('Efficiency: ${center['efficiency']}%', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                    SizedBox(width: 12),
                    Icon(Icons.work, size: 16, color: Colors.blue),
                    SizedBox(width: 4),
                    Text('Load: ${center['load']}%', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  ],
                ),
              ],
            ),
            trailing: Chip(
              label: Text(center['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
              backgroundColor: _getStatusColor(center['status']),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildQualityTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text('Quality Control', 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton.icon(
                onPressed: _showQualityControl,
                icon: Icon(Icons.add),
                label: Text('New Check', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _qualityChecks.length,
            itemBuilder: (context, index) {
              final check = _qualityChecks[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(check['result']).withOpacity(0.1),
                    child: Icon(Icons.verified, color: _getStatusColor(check['result'])),
                  ),
                  title: Text(check['product'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('${check['checkType']} • ${check['inspector']}', style: TextStyle(fontFamily: 'Cairo')),
                  trailing: Chip(
                    label: Text(check['result'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: _getStatusColor(check['result']),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMaintenanceTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text('Maintenance', 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton.icon(
                onPressed: _showMaintenanceRequest,
                icon: Icon(Icons.add),
                label: Text('New Request', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _maintenanceRequests.length,
            itemBuilder: (context, index) {
              final request = _maintenanceRequests[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withOpacity(0.1),
                    child: Icon(Icons.build, color: Colors.orange),
                  ),
                  title: Text(request['machine'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('${request['type']} • ${request['assignedTo']}', style: TextStyle(fontFamily: 'Cairo')),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        label: Text(request['priority'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                        backgroundColor: request['priority'] == 'High' ? Colors.red : Colors.orange,
                      ),
                      SizedBox(height: 4),
                      Text(request['status'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlanningTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Production Planning', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          
          // Gantt Chart Simulation
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Production Schedule - Next 7 Days', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._manufacturingOrders.map((order) => _buildScheduleItem(order)),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),
          
          // Capacity Planning
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Work Center Capacity', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._workCenters.map((center) => _buildCapacityItem(center)),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: _showProductionScheduling,
              icon: Icon(Icons.calendar_today),
              label: Text('Open Scheduling View', style: TextStyle(fontFamily: 'Cairo')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 1: // BOM
        return FloatingActionButton(
          onPressed: () => _editBom({}),
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.list_alt, color: Colors.white),
        );
      case 2: // Production
        return FloatingActionButton(
          onPressed: _createManufacturingOrder,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 4: // Quality
        return FloatingActionButton(
          onPressed: _showQualityControl,
          backgroundColor: Colors.orange,
          child: Icon(Icons.verified, color: Colors.white),
        );
      case 5: // Maintenance
        return FloatingActionButton(
          onPressed: _showMaintenanceRequest,
          backgroundColor: Colors.red,
          child: Icon(Icons.build, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: _createManufacturingOrder,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
    }
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

  Widget _buildRecentOrders() {
    final recentOrders = _manufacturingOrders.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Manufacturing Orders', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${_manufacturingOrders.length} total', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 12),
            ...recentOrders.map((order) => _buildOrderItem(order)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(Icons.build, color: _getStatusColor(order['status'])),
        title: Text(order['product'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Text('Qty: ${order['quantity']} • ${order['deadline']}', style: TextStyle(fontFamily: 'Cairo')),
        trailing: Chip(
          label: Text(order['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          backgroundColor: _getStatusColor(order['status']),
        ),
        onTap: () => _showWorkOrderDetails(order),
      ),
    );
  }

  Widget _buildWorkCenterStatus() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Work Center Status', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ..._workCenters.map((center) => _buildWorkCenterItem(center)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkCenterItem(Map<String, dynamic> center) {
    return ListTile(
      leading: Icon(Icons.engineering, color: _getStatusColor(center['status'])),
      title: Text(center['name'], style: TextStyle(fontFamily: 'Cairo')),
      subtitle: Text('${center['type']} • OEE: ${center['oee']}%', style: TextStyle(fontFamily: 'Cairo')),
      trailing: Chip(
        label: Text(center['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
        backgroundColor: _getStatusColor(center['status']),
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> order) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(order['product'], style: TextStyle(fontFamily: 'Cairo')),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: order['progress'] / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(order['status'])),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('${order['progress']}%', textAlign: TextAlign.right, style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityItem(Map<String, dynamic> center) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(center['name'], style: TextStyle(fontFamily: 'Cairo')),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: center['load'] / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                center['load'] > 80 ? Colors.red : 
                center['load'] > 60 ? Colors.orange : Colors.green
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('${center['load']}%', textAlign: TextAlign.right, style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}

// Dialog Classes
class BomManagementDialog extends StatefulWidget {
  final Map<String, dynamic>? bom;
  final Function(Map<String, dynamic>) onBomUpdated;

  const BomManagementDialog({super.key, this.bom, required this.onBomUpdated});

  @override
  State<BomManagementDialog> createState() => _BomManagementDialogState();
}

class _BomManagementDialogState extends State<BomManagementDialog> {
  final _formKey = GlobalKey<FormState>();
  final _productController = TextEditingController();
  final _versionController = TextEditingController();
  final _componentsController = TextEditingController();
  final _costController = TextEditingController();
  String _selectedStatus = 'Active';

  @override
  void initState() {
    super.initState();
    if (widget.bom != null && widget.bom!.isNotEmpty) {
      _productController.text = widget.bom!['product'];
      _versionController.text = widget.bom!['version'];
      _componentsController.text = widget.bom!['components'].toString();
      _costController.text = widget.bom!['cost'].toString();
      _selectedStatus = widget.bom!['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.bom == null ? 'Create New BOM' : 'Edit BOM', 
                style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _productController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Please enter product name' : null,
              ),
              TextFormField(
                controller: _versionController,
                decoration: InputDecoration(labelText: 'Version'),
                validator: (value) => value!.isEmpty ? 'Please enter version' : null,
              ),
              TextFormField(
                controller: _componentsController,
                decoration: InputDecoration(labelText: 'Number of Components'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter components count' : null,
              ),
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter cost' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedStatus,
                items: ['Active', 'Draft', 'Obsolete']
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
                decoration: InputDecoration(labelText: 'Status'),
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
              widget.onBomUpdated({
                'id': widget.bom?['id'] ?? 'BOM${DateTime.now().millisecondsSinceEpoch}',
                'product': _productController.text,
                'version': _versionController.text,
                'components': int.parse(_componentsController.text),
                'cost': double.parse(_costController.text),
                'status': _selectedStatus,
              });
              Navigator.pop(context);
            }
          },
          child: Text(widget.bom == null ? 'Create BOM' : 'Update BOM', 
                    style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class ManufacturingOrderDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onOrderCreated;

  const ManufacturingOrderDialog({super.key, required this.onOrderCreated});

  @override
  State<ManufacturingOrderDialog> createState() => _ManufacturingOrderDialogState();
}

class _ManufacturingOrderDialogState extends State<ManufacturingOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? _plannedDate;
  DateTime? _deadlineDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Manufacturing Order', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _productController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Please enter product name' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter quantity' : null,
              ),
              ListTile(
                title: Text(_plannedDate == null ? 'Select Planned Date' : 'Planned: ${_formatDate(_plannedDate!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _plannedDate = date);
                },
              ),
              ListTile(
                title: Text(_deadlineDate == null ? 'Select Deadline' : 'Deadline: ${_formatDate(_deadlineDate!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _plannedDate ?? DateTime.now().add(Duration(days: 7)),
                    firstDate: _plannedDate ?? DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _deadlineDate = date);
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
            if (_formKey.currentState!.validate() && _plannedDate != null && _deadlineDate != null) {
              widget.onOrderCreated({
                'id': 'MO${DateTime.now().millisecondsSinceEpoch}',
                'product': _productController.text,
                'quantity': int.parse(_quantityController.text),
                'plannedDate': _formatDate(_plannedDate!),
                'deadline': _formatDate(_deadlineDate!),
                'status': 'Confirmed',
                'progress': 0,
              });
              Navigator.pop(context);
            }
          },
          child: Text('Create Order', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

// Additional Pages and Dialogs
class WorkOrderDetailPage extends StatefulWidget {
  final Map<String, dynamic> order;
  final Function(Map<String, dynamic>) onStatusUpdated;

  const WorkOrderDetailPage({super.key, required this.order, required this.onStatusUpdated});

  @override
  State<WorkOrderDetailPage> createState() => _WorkOrderDetailPageState();
}

class _WorkOrderDetailPageState extends State<WorkOrderDetailPage> {
  late Map<String, dynamic> _order;

  @override
  void initState() {
    super.initState();
    _order = Map.from(widget.order);
  }

  void _updateProgress(int progress) {
    setState(() {
      _order['progress'] = progress;
      if (progress == 100) {
        _order['status'] = 'Done';
      } else if (progress > 0) {
        _order['status'] = 'In Progress';
      }
    });
    widget.onStatusUpdated(_order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Order Details', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_order['product'], style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildDetailRow('Order ID', _order['id']),
                    _buildDetailRow('Quantity', _order['quantity'].toString()),
                    _buildDetailRow('Planned Date', _order['plannedDate']),
                    _buildDetailRow('Deadline', _order['deadline']),
                    _buildDetailRow('Status', _order['status']),
                    SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: _order['progress'] / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(_order['status'])),
                    ),
                    SizedBox(height: 8),
                    Text('Progress: ${_order['progress']}%', style: TextStyle(fontFamily: 'Cairo')),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            Text('Update Progress', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProgressButton('Start', 0, Colors.blue),
                _buildProgressButton('25%', 25, Colors.blue),
                _buildProgressButton('50%', 50, Colors.orange),
                _buildProgressButton('75%', 75, Colors.orange),
                _buildProgressButton('Complete', 100, Colors.green),
              ],
            ),
            
            SizedBox(height: 20),
            
            Text('Operations', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildOperationItem('Material Preparation', true),
            _buildOperationItem('Assembly', _order['progress'] >= 25),
            _buildOperationItem('Testing', _order['progress'] >= 50),
            _buildOperationItem('Quality Check', _order['progress'] >= 75),
            _buildOperationItem('Packaging', _order['progress'] >= 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  Widget _buildProgressButton(String label, int progress, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          radius: 24,
          child: IconButton(
            icon: Icon(Icons.play_arrow, color: color),
            onPressed: () => _updateProgress(progress),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      ],
    );
  }

  Widget _buildOperationItem(String operation, bool completed) {
    return ListTile(
      leading: Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked, 
                   color: completed ? Colors.green : Colors.grey),
      title: Text(operation, style: TextStyle(fontFamily: 'Cairo')),
      trailing: completed ? Text('Completed', style: TextStyle(fontFamily: 'Cairo', color: Colors.green)) : null,
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Done': return Colors.green;
      case 'In Progress': return Colors.blue;
      case 'Confirmed': return Colors.orange;
      default: return Colors.grey;
    }
  }
}

class QualityControlDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onCheckAdded;

  const QualityControlDialog({super.key, required this.onCheckAdded});

  @override
  State<QualityControlDialog> createState() => _QualityControlDialogState();
}

class _QualityControlDialogState extends State<QualityControlDialog> {
  final _formKey = GlobalKey<FormState>();
  final _productController = TextEditingController();
  final _inspectorController = TextEditingController();
  String _selectedType = 'Final Inspection';
  String _selectedResult = 'Pass';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Quality Control Check', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _productController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Please enter product name' : null,
              ),
              TextFormField(
                controller: _inspectorController,
                decoration: InputDecoration(labelText: 'Inspector Name'),
                validator: (value) => value!.isEmpty ? 'Please enter inspector name' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedType,
                items: ['Final Inspection', 'In-Process', 'Raw Material', 'Sampling']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(labelText: 'Check Type'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedResult,
                items: ['Pass', 'Fail', 'Pending']
                    .map((result) => DropdownMenuItem(value: result, child: Text(result)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedResult = value!),
                decoration: InputDecoration(labelText: 'Result'),
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
              widget.onCheckAdded({
                'id': 'QC${DateTime.now().millisecondsSinceEpoch}',
                'product': _productController.text,
                'checkType': _selectedType,
                'inspector': _inspectorController.text,
                'result': _selectedResult,
                'date': _formatDate(DateTime.now()),
              });
              Navigator.pop(context);
            }
          },
          child: Text('Add Check', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class MaintenanceRequestDialog extends StatefulWidget {
  final List<Map<String, dynamic>> workCenters;
  final Function(Map<String, dynamic>) onRequestCreated;

  const MaintenanceRequestDialog({super.key, required this.workCenters, required this.onRequestCreated});

  @override
  State<MaintenanceRequestDialog> createState() => _MaintenanceRequestDialogState();
}

class _MaintenanceRequestDialogState extends State<MaintenanceRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMachine;
  String _selectedType = 'Preventive';
  String _selectedPriority = 'Medium';
  final _assignedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Maintenance Request', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                initialValue: _selectedMachine,
                items: widget.workCenters
                    .map((center) => DropdownMenuItem(
                          value: center['name'],
                          child: Text(center['name'], style: TextStyle(fontFamily: 'Cairo')),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedMachine = value as String?),
                decoration: InputDecoration(labelText: 'Machine/Equipment'),
                validator: (value) => value == null ? 'Please select a machine' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedType,
                items: ['Preventive', 'Corrective', 'Breakdown']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(labelText: 'Maintenance Type'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedPriority,
                items: ['Low', 'Medium', 'High', 'Critical']
                    .map((priority) => DropdownMenuItem(value: priority, child: Text(priority)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedPriority = value!),
                decoration: InputDecoration(labelText: 'Priority'),
              ),
              TextFormField(
                controller: _assignedController,
                decoration: InputDecoration(labelText: 'Assigned To'),
                validator: (value) => value!.isEmpty ? 'Please enter assignee' : null,
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
              widget.onRequestCreated({
                'id': 'MT${DateTime.now().millisecondsSinceEpoch}',
                'machine': _selectedMachine!,
                'type': _selectedType,
                'priority': _selectedPriority,
                'status': 'Scheduled',
                'assignedTo': _assignedController.text,
              });
              Navigator.pop(context);
            }
          },
          child: Text('Create Request', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class ProductionSchedulingPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final List<Map<String, dynamic>> workCenters;

  const ProductionSchedulingPage({super.key, required this.orders, required this.workCenters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Production Scheduling', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(child: Text('Gantt Chart', style: TextStyle(fontFamily: 'Cairo'))),
                Tab(child: Text('Calendar View', style: TextStyle(fontFamily: 'Cairo'))),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildGanttChart(),
                  _buildCalendarView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGanttChart() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Production Gantt Chart', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ...orders.map((order) => Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order['product'], style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: order['progress'] / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(order['status'])),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Planned: ${order['plannedDate']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                      Text('Deadline: ${order['deadline']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Production Calendar', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ..._generateCalendarDays().map((day) => _buildCalendarDay(day)),
        ],
      ),
    );
  }

  List<DateTime> _generateCalendarDays() {
    final now = DateTime.now();
    return List.generate(7, (index) => now.add(Duration(days: index)));
  }

  Widget _buildCalendarDay(DateTime date) {
    final dayOrders = orders.where((order) => order['plannedDate'] == _formatDate(date)).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_formatDate(date), style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (dayOrders.isEmpty)
              Text('No production scheduled', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
            ...dayOrders.map((order) => ListTile(
              leading: Icon(Icons.build, color: _getStatusColor(order['status'])),
              title: Text(order['product'], style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Text('Qty: ${order['quantity']}', style: TextStyle(fontFamily: 'Cairo')),
              trailing: Chip(
                label: Text(order['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                backgroundColor: _getStatusColor(order['status']),
              ),
            )),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Done': return Colors.green;
      case 'In Progress': return Colors.blue;
      case 'Confirmed': return Colors.orange;
      default: return Colors.grey;
    }
  }
}