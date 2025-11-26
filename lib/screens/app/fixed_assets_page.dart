import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class FixedAssetsPage extends StatefulWidget {
  const FixedAssetsPage({super.key});

  @override
  State<FixedAssetsPage> createState() => _FixedAssetsPageState();
}

class _FixedAssetsPageState extends State<FixedAssetsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  // Sample data for demonstration
  final List<Map<String, dynamic>> _assets = [
    {
      'id': 'AST001',
      'name': 'Dell Laptop XPS 15',
      'code': 'LAP-001',
      'category': 'IT Equipment',
      'serial_number': 'SN-DLXPS15-001',
      'description': 'Dell XPS 15 Laptop - 16GB RAM, 512GB SSD',
      'model': 'XPS 15 9520',
      'assigned_to': 'Ahmed Ali',
      'department': 'IT Department',
      'location': 'Main Office - Floor 3',
      'status': 'Running',
      'purchase_date': '2023-01-15',
      'purchase_value': 2500.0,
      'current_value': 1875.0,
      'vendor': 'Dell Technologies',
      'invoice_ref': 'INV-2023-001',
      'warranty_expiry': '2025-01-15',
      'insurance_expiry': '2024-01-15',
      'useful_life': 36,
      'depreciation_method': 'Straight-line',
      'depreciation_rate': 27.78,
    },
    {
      'id': 'AST002',
      'name': 'Toyota Camry 2023',
      'code': 'VEH-001',
      'category': 'Vehicles',
      'serial_number': 'VIN-123456789',
      'description': 'Toyota Camry 2023 - Executive Model',
      'model': 'Camry LE 2023',
      'assigned_to': 'Sales Department',
      'department': 'Sales',
      'location': 'Company Garage',
      'status': 'Running',
      'purchase_date': '2023-03-20',
      'purchase_value': 35000.0,
      'current_value': 28000.0,
      'vendor': 'Toyota Motors',
      'invoice_ref': 'INV-2023-045',
      'warranty_expiry': '2026-03-20',
      'insurance_expiry': '2024-03-20',
      'useful_life': 60,
      'depreciation_method': 'Straight-line',
      'depreciation_rate': 16.67,
    },
    {
      'id': 'AST003',
      'name': 'Office Desk Executive',
      'code': 'FUR-001',
      'category': 'Furniture',
      'serial_number': 'FUR-EXEC-001',
      'description': 'Executive Office Desk - Mahogany',
      'model': 'Executive Pro',
      'assigned_to': 'Sarah Mohamed',
      'department': 'Management',
      'location': 'CEO Office',
      'status': 'Running',
      'purchase_date': '2023-02-10',
      'purchase_value': 1200.0,
      'current_value': 1020.0,
      'vendor': 'Office Furniture Co.',
      'invoice_ref': 'INV-2023-023',
      'warranty_expiry': '2025-02-10',
      'insurance_expiry': '2024-02-10',
      'useful_life': 84,
      'depreciation_method': 'Straight-line',
      'depreciation_rate': 11.9,
    },
  ];

  final List<Map<String, dynamic>> _depreciationSchedule = [
    {
      'asset': 'Dell Laptop XPS 15',
      'date': '2024-02-01',
      'amount': 208.33,
      'type': 'Monthly',
      'status': 'Posted',
      'accumulated': 625.0,
    },
    {
      'asset': 'Toyota Camry 2023',
      'date': '2024-02-01',
      'amount': 486.11,
      'type': 'Monthly',
      'status': 'Posted',
      'accumulated': 7000.0,
    },
    {
      'asset': 'Office Desk Executive',
      'date': '2024-02-01',
      'amount': 14.29,
      'type': 'Monthly',
      'status': 'Posted',
      'accumulated': 180.0,
    },
  ];

  final List<Map<String, dynamic>> _assetTransfers = [
    {
      'id': 'TRF001',
      'asset': 'Dell Laptop XPS 15',
      'from': 'IT Department',
      'to': 'Marketing Department',
      'date': '2024-01-20',
      'status': 'Completed',
      'approved_by': 'IT Manager',
    },
    {
      'id': 'TRF002',
      'asset': 'Office Desk Executive',
      'from': 'Management',
      'to': 'Finance Department',
      'date': '2024-01-25',
      'status': 'Pending',
      'approved_by': 'Pending',
    },
  ];

  final List<Map<String, dynamic>> _maintenanceRecords = [
    {
      'id': 'MNT001',
      'asset': 'Toyota Camry 2023',
      'type': 'Preventive',
      'date': '2024-01-15',
      'cost': 250.0,
      'vendor': 'Toyota Service Center',
      'status': 'Completed',
      'next_due': '2024-07-15',
    },
    {
      'id': 'MNT002',
      'asset': 'Canon Printer MF644Cdw',
      'type': 'Repair',
      'date': '2024-01-30',
      'cost': 85.0,
      'vendor': 'Canon Service',
      'status': 'In Progress',
      'next_due': 'N/A',
    },
  ];

  final List<Map<String, dynamic>> _disposalRecords = [
    {
      'id': 'DSP001',
      'asset': 'Old Office Chair',
      'category': 'Furniture',
      'disposal_date': '2023-12-15',
      'disposal_type': 'Scrap',
      'original_value': 300.0,
      'disposal_value': 0.0,
      'reason': 'Damaged beyond repair',
    },
  ];

  final List<Map<String, dynamic>> _assetRequests = [
    {
      'id': 'REQ001',
      'employee': 'Mohamed Hassan',
      'department': 'Sales',
      'asset_type': 'Laptop',
      'reason': 'New team member',
      'date': '2024-01-28',
      'status': 'Pending',
      'priority': 'High',
    },
    {
      'id': 'REQ002',
      'employee': 'Fatima Ahmed',
      'department': 'HR',
      'asset_type': 'Printer',
      'reason': 'Department expansion',
      'date': '2024-01-29',
      'status': 'Approved',
      'priority': 'Medium',
    },
  ];

  final List<Map<String, dynamic>> _insuranceRecords = [
    {
      'id': 'INS001',
      'asset': 'Toyota Camry 2023',
      'provider': 'AXA Insurance',
      'policy_number': 'AXA-2023-001',
      'coverage_from': '2023-03-20',
      'coverage_to': '2024-03-20',
      'premium': 1200.0,
      'status': 'Active',
    },
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'IT Equipment',
      'depreciation_method': 'Straight-line',
      'useful_life': 36,
      'depreciation_rate': 27.78,
      'asset_account': 'Fixed Assets - IT',
      'expense_account': 'Depreciation Expense - IT',
      'accumulated_account': 'Accumulated Depreciation - IT',
    },
    {
      'name': 'Vehicles',
      'depreciation_method': 'Straight-line',
      'useful_life': 60,
      'depreciation_rate': 16.67,
      'asset_account': 'Fixed Assets - Vehicles',
      'expense_account': 'Depreciation Expense - Vehicles',
      'accumulated_account': 'Accumulated Depreciation - Vehicles',
    },
    {
      'name': 'Furniture',
      'depreciation_method': 'Straight-line',
      'useful_life': 84,
      'depreciation_rate': 11.9,
      'asset_account': 'Fixed Assets - Furniture',
      'expense_account': 'Depreciation Expense - Furniture',
      'accumulated_account': 'Accumulated Depreciation - Furniture',
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
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

  // Core Functions
  void _showAssetDetails(Map<String, dynamic> asset) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Asset Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Asset ID', asset['id']),
              _buildDetailRow('Name', asset['name']),
              _buildDetailRow('Code', asset['code']),
              _buildDetailRow('Category', asset['category']),
              _buildDetailRow('Serial Number', asset['serial_number']),
              _buildDetailRow('Description', asset['description']),
              _buildDetailRow('Model', asset['model']),
              _buildDetailRow('Assigned To', asset['assigned_to']),
              _buildDetailRow('Department', asset['department']),
              _buildDetailRow('Location', asset['location']),
              _buildDetailRow('Status', asset['status']),
              _buildDetailRow('Purchase Date', asset['purchase_date']),
              _buildDetailRow('Purchase Value', '\$${asset['purchase_value']}'),
              _buildDetailRow('Current Value', '\$${asset['current_value']}'),
              _buildDetailRow('Vendor', asset['vendor']),
              _buildDetailRow('Invoice Reference', asset['invoice_ref']),
              _buildDetailRow('Warranty Expiry', asset['warranty_expiry']),
              _buildDetailRow('Insurance Expiry', asset['insurance_expiry']),
              _buildDetailRow('Useful Life', '${asset['useful_life']} months'),
              _buildDetailRow('Depreciation Method', asset['depreciation_method']),
              _buildDetailRow('Depreciation Rate', '${asset['depreciation_rate']}% per year'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _editAsset(asset),
            child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _editAsset(Map<String, dynamic> asset) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AddAssetDialog(
        asset: asset,
        onAssetAdded: (updatedAsset) {
          setState(() {
            final index = _assets.indexWhere((a) => a['id'] == asset['id']);
            if (index != -1) {
              _assets[index] = {..._assets[index], ...updatedAsset};
            }
          });
        },
        categories: _categories,
      ),
    );
  }

  void _deleteAsset(Map<String, dynamic> asset) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Asset', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to delete ${asset['name']}?', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _assets.removeWhere((a) => a['id'] == asset['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Asset deleted successfully', style: TextStyle(fontFamily: 'Cairo'))),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddAssetDialog() {
    showDialog(
      context: context,
      builder: (context) => AddAssetDialog(
        onAssetAdded: (asset) {
          setState(() {
            _assets.add(asset);
          });
        },
        categories: _categories,
      ),
    );
  }

  void _showTransferAsset(Map<String, dynamic> asset) {
    showDialog(
      context: context,
      builder: (context) => AssetTransferDialog(
        asset: asset,
        onTransferCreated: (transfer) {
          setState(() {
            _assetTransfers.insert(0, transfer);
          });
        },
      ),
    );
  }

  void _showMaintenanceRequest(Map<String, dynamic> asset) {
    showDialog(
      context: context,
      builder: (context) => MaintenanceRequestDialog(
        asset: asset,
        onMaintenanceCreated: (maintenance) {
          setState(() {
            _maintenanceRecords.insert(0, maintenance);
          });
        },
      ),
    );
  }

  void _showDisposeAssetDialog() {
    showDialog(
      context: context,
      builder: (context) => AssetDisposalDialog(
        onDisposalCreated: (disposal) {
          setState(() {
            _disposalRecords.add(disposal);
          });
        },
        assets: _assets,
      ),
    );
  }

  void _showBarcodeScanner() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Asset Barcode Scanner', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 64, color: AppColors.primaryColor),
            SizedBox(height: 16),
            Text('Scan asset barcode for quick access', style: TextStyle(fontFamily: 'Cairo')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Asset scanned successfully!', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Simulate Scan', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _showAssetRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => AssetRequestDialog(
        onRequestCreated: (request) {
          setState(() {
            _assetRequests.insert(0, request);
          });
        },
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
      case 'Running': case 'Completed': case 'Active': case 'Approved': return Colors.green;
      case 'Pending': return Colors.orange;
      case 'In Progress': return Colors.blue;
      case 'Expired': return Colors.red;
      case 'Draft': return Colors.grey;
      default: return Colors.grey;
    }
  }

  IconData _getAssetIcon(String category) {
    switch (category) {
      case 'IT Equipment': return Icons.computer;
      case 'Vehicles': return Icons.directions_car;
      case 'Furniture': return Icons.chair;
      case 'Office Equipment': return Icons.print;
      default: return Icons.business_center;
    }
  }

  // Filtered data based on search
  List<Map<String, dynamic>> get _filteredAssets {
    if (_searchQuery.isEmpty) return _assets;
    return _assets.where((asset) =>
      asset['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      asset['code'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      asset['category'].toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
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
          'Fixed Assets Management',
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
            Tab(text: 'Assets'),
            Tab(text: 'Depreciation'),
            Tab(text: 'Transfers'),
            Tab(text: 'Maintenance'),
            Tab(text: 'Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildAssetsTab(),
          _buildDepreciationTab(),
          _buildTransfersTab(),
          _buildMaintenanceTab(),
          _buildReportsTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    final totalAssets = _assets.length;
    final totalValue = _assets.map((a) => a['purchase_value']).reduce((a, b) => a + b);
    final currentValue = _assets.map((a) => a['current_value']).reduce((a, b) => a + b);
    final depreciationThisMonth = _depreciationSchedule
        .where((d) => d['status'] == 'Posted')
        .map((d) => d['amount'])
        .fold(0.0, (a, b) => a + b);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
          Row(
            children: [
              _buildStatCard('Total Assets', totalAssets.toString(), Colors.blue, Icons.business_center),
              SizedBox(width: 12),
              _buildStatCard('Total Value', '\$${totalValue.toStringAsFixed(0)}', Colors.green, Icons.attach_money),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Current Value', '\$${currentValue.toStringAsFixed(0)}', Colors.orange, Icons.account_balance),
              SizedBox(width: 12),
              _buildStatCard('Monthly Depreciation', '\$${depreciationThisMonth.toStringAsFixed(0)}', Colors.purple, Icons.trending_down),
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
              _buildActionButton('Add Asset', Icons.add, Colors.green, _showAddAssetDialog),
              _buildActionButton('Transfer', Icons.swap_horiz, Colors.blue, () => _showTransferAsset(_assets.first)),
              _buildActionButton('Dispose', Icons.delete_outline, Colors.red, _showDisposeAssetDialog),
              _buildActionButton('Scan Barcode', Icons.qr_code_scanner, Colors.purple, _showBarcodeScanner),
              _buildActionButton('Maintenance', Icons.build, Colors.orange, () => _showMaintenanceRequest(_assets.first)),
              _buildActionButton('Request Asset', Icons.request_quote, Colors.teal, _showAssetRequestDialog),
            ],
          ),

          // Upcoming Depreciation
          SizedBox(height: 20),
          _buildUpcomingDepreciation(),

          // Recent Transfers
          SizedBox(height: 20),
          _buildRecentTransfers(),
        ],
      ),
    );
  }

  Widget _buildAssetsTab() {
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
                    hintText: 'Search assets...',
                    prefixIcon: Icon(Icons.search),
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
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _showAssetFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredAssets.length,
            itemBuilder: (context, index) {
                final asset = _filteredAssets[index];
                final depreciation = ((asset['purchase_value'] - asset['current_value']) / asset['purchase_value'] * 100).toStringAsFixed(1);
  
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: Icon(_getAssetIcon(asset['category']), color: AppColors.primaryColor),
                    title: Text(asset['name'], style: TextStyle(fontFamily: 'Cairo')),
                    subtitle: Text('${asset['category']} • Code: ${asset['code']} • Dep: $depreciation%', style: TextStyle(fontFamily: 'Cairo')),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('View Details', style: TextStyle(fontFamily: 'Cairo')),
                          onTap: () => _showAssetDetails(asset),
                        ),
                        PopupMenuItem(
                          child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
                          onTap: () => _editAsset(asset),
                        ),
                        PopupMenuItem(
                          child: Text('Delete', style: TextStyle(fontFamily: 'Cairo')),
                          onTap: () => _deleteAsset(asset),
                        ),
                      ],
                    ),
                    onTap: () => _showAssetDetails(asset),
                  ),
                );
              },
          ),
        ),
      ],
    );
  }

  Widget _buildDepreciationTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Depreciation Schedule', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ..._depreciationSchedule.map((depreciation) => Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.trending_down, color: Colors.purple),
            title: Text(depreciation['asset'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${depreciation['date']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Type: ${depreciation['type']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                Text('Accumulated: \$${depreciation['accumulated']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${depreciation['amount']}',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Chip(
                  label: Text(depreciation['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: _getStatusColor(depreciation['status']),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildTransfersTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Asset Transfers', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ..._assetTransfers.map((transfer) => Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.swap_horiz, color: Colors.blue),
            title: Text(transfer['asset'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${transfer['from']} → ${transfer['to']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Date: ${transfer['date']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                Text('Approved by: ${transfer['approved_by']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
              ],
            ),
            trailing: Chip(
              label: Text(transfer['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
              backgroundColor: _getStatusColor(transfer['status']),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildMaintenanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Maintenance Records', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._maintenanceRecords.map((maintenance) => Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.build, color: Colors.orange),
              title: Text(maintenance['asset'], style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: ${maintenance['type']}', style: TextStyle(fontFamily: 'Cairo')),
                  Text('Date: ${maintenance['date']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                  Text('Vendor: ${maintenance['vendor']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                  if (maintenance['next_due'] != 'N/A')
                    Text('Next Due: ${maintenance['next_due']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.blue)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${maintenance['cost']}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Chip(
                    label: Text(maintenance['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: _getStatusColor(maintenance['status']),
                  ),
                ],
              ),
            ),
          )),
          SizedBox(height: 20),
          Text('Asset Requests', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._assetRequests.map((request) => Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.request_quote, color: Colors.teal),
              title: Text('${request['asset_type']} - ${request['employee']}', style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Department: ${request['department']}', style: TextStyle(fontFamily: 'Cairo')),
                  Text('Reason: ${request['reason']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                  Text('Date: ${request['date']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: request['priority'] == 'High' ? Colors.red.withOpacity(0.1) : 
                             request['priority'] == 'Medium' ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: request['priority'] == 'High' ? Colors.red : 
                                        request['priority'] == 'Medium' ? Colors.orange : Colors.green),
                    ),
                    child: Text(request['priority'], style: TextStyle(
                      color: request['priority'] == 'High' ? Colors.red : 
                             request['priority'] == 'Medium' ? Colors.orange : Colors.green,
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  SizedBox(height: 4),
                  Chip(
                    label: Text(request['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: _getStatusColor(request['status']),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    final totalAssets = _assets.length;
    final totalValue = _assets.map((a) => a['purchase_value']).reduce((a, b) => a + b);
    final currentValue = _assets.map((a) => a['current_value']).reduce((a, b) => a + b);
    final totalDepreciation = totalValue - currentValue;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Asset Reports', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          
          // Summary Cards
          Row(
            children: [
              _buildReportCard('Total Assets', totalAssets.toString(), Colors.blue),
              SizedBox(width: 12),
              _buildReportCard('Total Value', '\$${totalValue.toStringAsFixed(0)}', Colors.green),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildReportCard('Current Value', '\$${currentValue.toStringAsFixed(0)}', Colors.orange),
              SizedBox(width: 12),
              _buildReportCard('Total Depreciation', '\$${totalDepreciation.toStringAsFixed(0)}', Colors.purple),
            ],
          ),
          
          SizedBox(height: 20),
          Text('Assets by Category', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          
          // Assets by Category
          ..._categories.map((category) {
            final categoryAssets = _assets.where((a) => a['category'] == category['name']).toList();
            final categoryValue = categoryAssets.map((a) => a['purchase_value']).fold(0.0, (a, b) => a + b);
            
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(category['name'], style: TextStyle(fontFamily: 'Cairo')),
                    ),
                    Text('${categoryAssets.length} assets', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    Text('\$${categoryValue.toStringAsFixed(0)}', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: categoryAssets.length / totalAssets,
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(height: 12),
              ],
            );
          }),

          SizedBox(height: 20),
          Text('Insurance Records', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._insuranceRecords.map((insurance) => Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.security, color: Colors.blue),
              title: Text(insurance['asset'], style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Provider: ${insurance['provider']}', style: TextStyle(fontFamily: 'Cairo')),
                  Text('Policy: ${insurance['policy_number']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                  Text('Coverage: ${insurance['coverage_from']} to ${insurance['coverage_to']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${insurance['premium']}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Chip(
                    label: Text(insurance['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: _getStatusColor(insurance['status']),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 1: // Assets
        return FloatingActionButton(
          onPressed: _showAddAssetDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 2: // Depreciation
        return FloatingActionButton(
          onPressed: () {}, // Add depreciation entry
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.trending_down, color: Colors.white),
        );
      case 3: // Transfers
        return FloatingActionButton(
          onPressed: () => _showTransferAsset(_assets.first),
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.swap_horiz, color: Colors.white),
        );
      case 4: // Maintenance
        return FloatingActionButton(
          onPressed: () => _showMaintenanceRequest(_assets.first),
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.build, color: Colors.white),
        );
      case 5: // Reports
        return FloatingActionButton(
          onPressed: _showAssetRequestDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.request_quote, color: Colors.white),
        );
      default: // Dashboard
        return FloatingActionButton(
          onPressed: _showAddAssetDialog,
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

  Widget _buildUpcomingDepreciation() {
    final upcoming = _depreciationSchedule.where((d) => d['status'] == 'Scheduled').toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_down, color: Colors.purple),
                SizedBox(width: 8),
                Text('Upcoming Depreciation', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 12),
            if (upcoming.isEmpty)
              Text('No upcoming depreciation', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey))
            else
              ...upcoming.take(3).map((depreciation) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(depreciation['asset'], style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500)),
                            SizedBox(height: 2),
                            Text('Date: ${depreciation['date']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Text('\$${depreciation['amount']}', style: TextStyle(fontFamily: 'Cairo', color: Colors.purple, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 12),
                ],
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransfers() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.swap_horiz, color: Colors.blue),
                SizedBox(width: 8),
                Text('Recent Transfers', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 12),
            ..._assetTransfers.take(3).map((transfer) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transfer['asset'], style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500)),
                          SizedBox(height: 2),
                          Text('${transfer['from']} → ${transfer['to']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(transfer['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                      backgroundColor: _getStatusColor(transfer['status']),
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              SizedBox(height: 4),
              Text(title, style: TextStyle(fontFamily: 'Cairo', color: color)),
            ],
          ),
        ),
      ),
    );
  }

  void _showAssetFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Assets', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter functionality to be implemented', style: TextStyle(fontFamily: 'Cairo')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}

// Dialog Classes
class AddAssetDialog extends StatefulWidget {
  final Map<String, dynamic>? asset;
  final Function(Map<String, dynamic>) onAssetAdded;
  final List<Map<String, dynamic>> categories;

  const AddAssetDialog({
    super.key,
    this.asset,
    required this.onAssetAdded,
    required this.categories,
  });

  @override
  State<AddAssetDialog> createState() => _AddAssetDialogState();
}

class _AddAssetDialogState extends State<AddAssetDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _serialController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _modelController = TextEditingController();
  final _assignedController = TextEditingController();
  final _departmentController = TextEditingController();
  final _locationController = TextEditingController();
  final _purchaseDateController = TextEditingController();
  final _purchaseValueController = TextEditingController();
  final _vendorController = TextEditingController();
  final _invoiceController = TextEditingController();
  final _warrantyController = TextEditingController();
  final _insuranceController = TextEditingController();
  String? _selectedCategory;
  String _selectedStatus = 'Running';

  @override
  void initState() {
    super.initState();
    if (widget.asset != null) {
      _nameController.text = widget.asset!['name'];
      _codeController.text = widget.asset!['code'];
      _serialController.text = widget.asset!['serial_number'];
      _descriptionController.text = widget.asset!['description'];
      _modelController.text = widget.asset!['model'];
      _assignedController.text = widget.asset!['assigned_to'];
      _departmentController.text = widget.asset!['department'];
      _locationController.text = widget.asset!['location'];
      _purchaseDateController.text = widget.asset!['purchase_date'];
      _purchaseValueController.text = widget.asset!['purchase_value'].toString();
      _vendorController.text = widget.asset!['vendor'];
      _invoiceController.text = widget.asset!['invoice_ref'];
      _warrantyController.text = widget.asset!['warranty_expiry'];
      _insuranceController.text = widget.asset!['insurance_expiry'];
      _selectedCategory = widget.asset!['category'];
      _selectedStatus = widget.asset!['status'];
    } else {
      _purchaseDateController.text = '2024-01-01';
      _warrantyController.text = '2025-01-01';
      _insuranceController.text = '2024-01-01';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.asset == null ? 'Add New Asset' : 'Edit Asset', 
                style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Asset Name'),
                validator: (value) => value!.isEmpty ? 'Please enter name' : null,
              ),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(labelText: 'Asset Code'),
                validator: (value) => value!.isEmpty ? 'Please enter code' : null,
              ),
              TextFormField(
                controller: _serialController,
                decoration: InputDecoration(labelText: 'Serial Number'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Model'),
              ),
              TextFormField(
                controller: _assignedController,
                decoration: InputDecoration(labelText: 'Assigned To'),
              ),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(labelText: 'Department'),
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: _purchaseDateController,
                decoration: InputDecoration(labelText: 'Purchase Date (YYYY-MM-DD)'),
              ),
              TextFormField(
                controller: _purchaseValueController,
                decoration: InputDecoration(labelText: 'Purchase Value'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _vendorController,
                decoration: InputDecoration(labelText: 'Vendor'),
              ),
              TextFormField(
                controller: _invoiceController,
                decoration: InputDecoration(labelText: 'Invoice Reference'),
              ),
              TextFormField(
                controller: _warrantyController,
                decoration: InputDecoration(labelText: 'Warranty Expiry (YYYY-MM-DD)'),
              ),
              TextFormField(
                controller: _insuranceController,
                decoration: InputDecoration(labelText: 'Insurance Expiry (YYYY-MM-DD)'),
              ),
              DropdownButtonFormField(
                value: _selectedCategory,
                items: widget.categories
                    .map((category) => DropdownMenuItem(value: category['name'], child: Text(category['name'])))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value! as String?),
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) => value == null ? 'Please select category' : null,
              ),
              DropdownButtonFormField(
                value: _selectedStatus,
                items: ['Draft', 'Running', 'Paused', 'Sold', 'Disposed']
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
              final selectedCategory = widget.categories.firstWhere(
                (cat) => cat['name'] == _selectedCategory,
                orElse: () => widget.categories.first
              );
              
              final asset = {
                'id': widget.asset?['id'] ?? 'AST${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'code': _codeController.text,
                'category': _selectedCategory!,
                'serial_number': _serialController.text,
                'description': _descriptionController.text,
                'model': _modelController.text,
                'assigned_to': _assignedController.text,
                'department': _departmentController.text,
                'location': _locationController.text,
                'status': _selectedStatus,
                'purchase_date': _purchaseDateController.text,
                'purchase_value': double.parse(_purchaseValueController.text),
                'current_value': double.parse(_purchaseValueController.text),
                'vendor': _vendorController.text,
                'invoice_ref': _invoiceController.text,
                'warranty_expiry': _warrantyController.text,
                'insurance_expiry': _insuranceController.text,
                'useful_life': selectedCategory['useful_life'],
                'depreciation_method': selectedCategory['depreciation_method'],
                'depreciation_rate': selectedCategory['depreciation_rate'],
              };
              widget.onAssetAdded(asset);
              Navigator.pop(context);
            }
          },
          child: Text(widget.asset == null ? 'Add Asset' : 'Update Asset', 
                    style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class AssetTransferDialog extends StatefulWidget {
  final Map<String, dynamic> asset;
  final Function(Map<String, dynamic>) onTransferCreated;

  const AssetTransferDialog({
    super.key,
    required this.asset,
    required this.onTransferCreated,
  });

  @override
  State<AssetTransferDialog> createState() => _AssetTransferDialogState();
}

class _AssetTransferDialogState extends State<AssetTransferDialog> {
  final _formKey = GlobalKey<FormState>();
  final _toDepartmentController = TextEditingController();
  final _toLocationController = TextEditingController();
  final _toEmployeeController = TextEditingController();
  final _notesController = TextEditingController();
  String _transferType = 'Department';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transfer Asset', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.business_center),
                title: Text(widget.asset['name'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('Current: ${widget.asset['department']} - ${widget.asset['location']}', style: TextStyle(fontFamily: 'Cairo')),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _transferType,
                items: ['Department', 'Location', 'Employee'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => _transferType = value!),
                decoration: InputDecoration(labelText: 'Transfer Type'),
              ),
              SizedBox(height: 16),
              if (_transferType == 'Department')
                TextFormField(
                  controller: _toDepartmentController,
                  decoration: InputDecoration(labelText: 'To Department'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                )
              else if (_transferType == 'Location')
                TextFormField(
                  controller: _toLocationController,
                  decoration: InputDecoration(labelText: 'To Location'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                )
              else
                TextFormField(
                  controller: _toEmployeeController,
                  decoration: InputDecoration(labelText: 'To Employee'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes (Optional)'),
                maxLines: 2,
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
              String to = '';
              if (_transferType == 'Department') {
                to = _toDepartmentController.text;
              } else if (_transferType == 'Location') {
                to = _toLocationController.text;
              } else {
                to = _toEmployeeController.text;
              }
              
              final transfer = {
                'id': 'TRF${DateTime.now().millisecondsSinceEpoch}',
                'asset': widget.asset['name'],
                'from': widget.asset['department'],
                'to': to,
                'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                'status': 'Pending',
                'approved_by': 'Pending Approval',
                'type': _transferType,
                'notes': _notesController.text.isEmpty ? null : _notesController.text,
              };
              widget.onTransferCreated(transfer);
              Navigator.pop(context);
            }
          },
          child: Text('Create Transfer', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class MaintenanceRequestDialog extends StatefulWidget {
  final Map<String, dynamic> asset;
  final Function(Map<String, dynamic>) onMaintenanceCreated;

  const MaintenanceRequestDialog({
    super.key,
    required this.asset,
    required this.onMaintenanceCreated,
  });

  @override
  State<MaintenanceRequestDialog> createState() => _MaintenanceRequestDialogState();
}

class _MaintenanceRequestDialogState extends State<MaintenanceRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _vendorController = TextEditingController();
  String _maintenanceType = 'Preventive';
  String _priority = 'Medium';

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
              ListTile(
                leading: Icon(Icons.build),
                title: Text(widget.asset['name'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('Asset: ${widget.asset['code']}', style: TextStyle(fontFamily: 'Cairo')),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _maintenanceType,
                items: ['Preventive', 'Corrective', 'Emergency'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => _maintenanceType = value!),
                decoration: InputDecoration(labelText: 'Maintenance Type'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _priority,
                items: ['Low', 'Medium', 'High', 'Critical'].map((priority) {
                  return DropdownMenuItem(value: priority, child: Text(priority));
                }).toList(),
                onChanged: (value) => setState(() => _priority = value!),
                decoration: InputDecoration(labelText: 'Priority'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(labelText: 'Estimated Cost'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _vendorController,
                decoration: InputDecoration(labelText: 'Vendor (Optional)'),
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
              final maintenance = {
                'id': 'MNT${DateTime.now().millisecondsSinceEpoch}',
                'asset': widget.asset['name'],
                'type': _maintenanceType,
                'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                'cost': _costController.text.isEmpty ? 0.0 : double.parse(_costController.text),
                'vendor': _vendorController.text.isEmpty ? null : _vendorController.text,
                'status': 'Pending',
                'description': _descriptionController.text,
                'priority': _priority,
                'next_due': _maintenanceType == 'Preventive' ? 
                  '${DateTime.now().add(Duration(days: 180)).year}-${DateTime.now().add(Duration(days: 180)).month.toString().padLeft(2, '0')}-${DateTime.now().add(Duration(days: 180)).day.toString().padLeft(2, '0')}' : 'N/A',
              };
              widget.onMaintenanceCreated(maintenance);
              Navigator.pop(context);
            }
          },
          child: Text('Create Request', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class AssetDisposalDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onDisposalCreated;
  final List<Map<String, dynamic>> assets;

  const AssetDisposalDialog({
    super.key,
    required this.onDisposalCreated,
    required this.assets,
  });

  @override
  State<AssetDisposalDialog> createState() => _AssetDisposalDialogState();
}

class _AssetDisposalDialogState extends State<AssetDisposalDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAsset;
  final _disposalDateController = TextEditingController();
  final _disposalValueController = TextEditingController();
  final _reasonController = TextEditingController();
  String _disposalType = 'Scrap';

  @override
  void initState() {
    super.initState();
    _disposalDateController.text = '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Asset Disposal', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                value: _selectedAsset,
                items: widget.assets.map((asset) {
                  return DropdownMenuItem(
                    value: asset['id'],
                    child: Text('${asset['name']} (${asset['code']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedAsset = value! as String?),
                decoration: InputDecoration(labelText: 'Select Asset'),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _disposalType,
                items: ['Scrap', 'Sale', 'Donation', 'Lost/Stolen'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => _disposalType = value!),
                decoration: InputDecoration(labelText: 'Disposal Type'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _disposalDateController,
                decoration: InputDecoration(labelText: 'Disposal Date (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _disposalValueController,
                decoration: InputDecoration(labelText: 'Disposal Value'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: 'Reason for Disposal'),
                maxLines: 2,
                validator: (value) => value!.isEmpty ? 'Required' : null,
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
              final asset = widget.assets.firstWhere((a) => a['id'] == _selectedAsset);
              
              final disposal = {
                'id': 'DSP${DateTime.now().millisecondsSinceEpoch}',
                'asset': asset['name'],
                'category': asset['category'],
                'disposal_date': _disposalDateController.text,
                'disposal_type': _disposalType,
                'original_value': asset['purchase_value'],
                'disposal_value': double.parse(_disposalValueController.text),
                'reason': _reasonController.text,
              };
              widget.onDisposalCreated(disposal);
              Navigator.pop(context);
            }
          },
          child: Text('Record Disposal', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class AssetRequestDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onRequestCreated;

  const AssetRequestDialog({
    super.key,
    required this.onRequestCreated,
  });

  @override
  State<AssetRequestDialog> createState() => _AssetRequestDialogState();
}

class _AssetRequestDialogState extends State<AssetRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  final _employeeController = TextEditingController();
  final _departmentController = TextEditingController();
  final _assetTypeController = TextEditingController();
  final _reasonController = TextEditingController();
  String _priority = 'Medium';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Asset Request', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _employeeController,
                decoration: InputDecoration(labelText: 'Employee Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(labelText: 'Department'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _assetTypeController,
                decoration: InputDecoration(labelText: 'Asset Type Required'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _priority,
                items: ['Low', 'Medium', 'High', 'Critical'].map((priority) {
                  return DropdownMenuItem(value: priority, child: Text(priority));
                }).toList(),
                onChanged: (value) => setState(() => _priority = value!),
                decoration: InputDecoration(labelText: 'Priority'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: 'Reason for Request'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required' : null,
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
              final request = {
                'id': 'REQ${DateTime.now().millisecondsSinceEpoch}',
                'employee': _employeeController.text,
                'department': _departmentController.text,
                'asset_type': _assetTypeController.text,
                'reason': _reasonController.text,
                'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                'status': 'Pending',
                'priority': _priority,
              };
              widget.onRequestCreated(request);
              Navigator.pop(context);
            }
          },
          child: Text('Submit Request', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class InsuranceDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onInsuranceCreated;
  final List<Map<String, dynamic>> assets;

  const InsuranceDialog({
    super.key,
    required this.onInsuranceCreated,
    required this.assets,
  });

  @override
  State<InsuranceDialog> createState() => _InsuranceDialogState();
}

class _InsuranceDialogState extends State<InsuranceDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAsset;
  final _providerController = TextEditingController();
  final _policyController = TextEditingController();
  final _coverageFromController = TextEditingController();
  final _coverageToController = TextEditingController();
  final _premiumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _coverageFromController.text = '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
    _coverageToController.text = '${DateTime.now().add(Duration(days: 365)).year}-${DateTime.now().add(Duration(days: 365)).month.toString().padLeft(2, '0')}-${DateTime.now().add(Duration(days: 365)).day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Insurance Registration', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                value: _selectedAsset,
                items: widget.assets.map((asset) {
                  return DropdownMenuItem(
                    value: asset['id'],
                    child: Text('${asset['name']} (${asset['code']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedAsset = value! as String?),
                decoration: InputDecoration(labelText: 'Select Asset'),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _providerController,
                decoration: InputDecoration(labelText: 'Insurance Provider'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _policyController,
                decoration: InputDecoration(labelText: 'Policy Number'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _coverageFromController,
                decoration: InputDecoration(labelText: 'Coverage From (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _coverageToController,
                decoration: InputDecoration(labelText: 'Coverage To (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _premiumController,
                decoration: InputDecoration(labelText: 'Premium Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
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
              final asset = widget.assets.firstWhere((a) => a['id'] == _selectedAsset);
              
              final insurance = {
                'id': 'INS${DateTime.now().millisecondsSinceEpoch}',
                'asset': asset['name'],
                'provider': _providerController.text,
                'policy_number': _policyController.text,
                'coverage_from': _coverageFromController.text,
                'coverage_to': _coverageToController.text,
                'premium': double.parse(_premiumController.text),
                'status': 'Active',
              };
              widget.onInsuranceCreated(insurance);
              Navigator.pop(context);
            }
          },
          child: Text('Register Insurance', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}