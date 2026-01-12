import 'package:flutter/material.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';

class PurchasePage extends StatefulWidget {
  final UserModel? user;
  
  const PurchasePage({super.key, this.user});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Sample data for demonstration
  final List<Map<String, dynamic>> _vendors = [
    {
      'id': 'V001', 
      'name': 'Tech Supplies Co.', 
      'contact': 'Ahmed Ali', 
      'email': 'ahmed@techsupplies.com',
      'phone': '+966 50 123 4567',
      'rating': 4.5,
      'category': 'Electronics',
      'status': 'Active',
      'totalSpend': 125000,
      'onTimeDelivery': 95,
      'qualityScore': 92
    },
    {
      'id': 'V002', 
      'name': 'Office Furniture Ltd.', 
      'contact': 'Sarah Mohamed', 
      'email': 'sarah@officefurn.com',
      'phone': '+966 55 987 6543',
      'rating': 4.2,
      'category': 'Furniture',
      'status': 'Active',
      'totalSpend': 75000,
      'onTimeDelivery': 88,
      'qualityScore': 85
    },
    {
      'id': 'V003', 
      'name': 'Raw Materials Inc.', 
      'contact': 'Yasser Hassan', 
      'email': 'yasser@rawmaterials.com',
      'phone': '+966 54 555 8888',
      'rating': 3.8,
      'category': 'Raw Materials',
      'status': 'Inactive',
      'totalSpend': 200000,
      'onTimeDelivery': 75,
      'qualityScore': 80
    },
  ];

  final List<Map<String, dynamic>> _rfqs = [
    {
      'id': 'RFQ001',
      'title': 'Laptop Procurement Q1 2024',
      'status': 'Draft',
      'createdDate': '2024-01-15',
      'deadline': '2024-01-30',
      'budget': 50000,
      'assignedTo': 'Procurement Manager',
      'vendors': ['V001', 'V004'],
      'items': [
        {'product': 'Dell Laptop i7', 'quantity': 20, 'specs': '16GB RAM, 512GB SSD'},
        {'product': 'HP Laptop i5', 'quantity': 15, 'specs': '8GB RAM, 256GB SSD'}
      ]
    },
    {
      'id': 'RFQ002',
      'title': 'Office Chairs Bulk Order',
      'status': 'Sent',
      'createdDate': '2024-01-10',
      'deadline': '2024-01-25',
      'budget': 15000,
      'assignedTo': 'Purchase Officer',
      'vendors': ['V002'],
      'items': [
        {'product': 'Ergonomic Office Chair', 'quantity': 50, 'specs': 'Adjustable height, lumbar support'}
      ]
    },
    {
      'id': 'RFQ003',
      'title': 'Server Hardware Upgrade',
      'status': 'Closed',
      'createdDate': '2024-01-05',
      'deadline': '2024-01-20',
      'budget': 80000,
      'assignedTo': 'IT Manager',
      'vendors': ['V001', 'V005'],
      'items': [
        {'product': 'Dell PowerEdge Server', 'quantity': 5, 'specs': '32GB RAM, 1TB SSD RAID'},
        {'product': 'Network Switches', 'quantity': 10, 'specs': '48-port Gigabit'}
      ]
    },
  ];

  final List<Map<String, dynamic>> _purchaseOrders = [
    {
      'id': 'PO001',
      'vendor': 'Tech Supplies Co.',
      'status': 'Approved',
      'orderDate': '2024-01-12',
      'expectedDate': '2024-01-25',
      'totalAmount': 45000,
      'currency': 'SAR',
      'items': [
        {'product': 'Dell Laptop i7', 'quantity': 10, 'unitPrice': 3500, 'total': 35000},
        {'product': 'HP Monitor 24"', 'quantity': 20, 'unitPrice': 500, 'total': 10000}
      ]
    },
    {
      'id': 'PO002',
      'vendor': 'Office Furniture Ltd.',
      'status': 'Ordered',
      'orderDate': '2024-01-08',
      'expectedDate': '2024-01-22',
      'totalAmount': 12000,
      'currency': 'SAR',
      'items': [
        {'product': 'Ergonomic Chair', 'quantity': 30, 'unitPrice': 400, 'total': 12000}
      ]
    },
    {
      'id': 'PO003',
      'vendor': 'Raw Materials Inc.',
      'status': 'Received',
      'orderDate': '2024-01-03',
      'expectedDate': '2024-01-18',
      'totalAmount': 75000,
      'currency': 'SAR',
      'items': [
        {'product': 'Steel Sheets', 'quantity': 500, 'unitPrice': 150, 'total': 75000}
      ]
    },
  ];

  final List<Map<String, dynamic>> _receipts = [
    {
      'id': 'GRN001',
      'poNumber': 'PO003',
      'vendor': 'Raw Materials Inc.',
      'receiptDate': '2024-01-17',
      'status': 'Completed',
      'totalItems': 500,
      'receivedBy': 'Warehouse Manager',
      'items': [
        {'product': 'Steel Sheets', 'ordered': 500, 'received': 500, 'damaged': 0}
      ]
    },
    {
      'id': 'GRN002',
      'poNumber': 'PO004',
      'vendor': 'Electronics Corp',
      'receiptDate': '2024-01-14',
      'status': 'Partial',
      'totalItems': 100,
      'receivedBy': 'Store Keeper',
      'items': [
        {'product': 'Circuit Boards', 'ordered': 100, 'received': 80, 'damaged': 2}
      ]
    },
  ];

  final List<Map<String, dynamic>> _vendorBills = [
    {
      'id': 'BILL001',
      'vendor': 'Tech Supplies Co.',
      'billDate': '2024-01-20',
      'dueDate': '2024-02-19',
      'amount': 45000,
      'status': 'Paid',
      'poReference': 'PO001',
      'paymentTerms': 'Net 30'
    },
    {
      'id': 'BILL002',
      'vendor': 'Office Furniture Ltd.',
      'billDate': '2024-01-18',
      'dueDate': '2024-02-17',
      'amount': 12000,
      'status': 'Unpaid',
      'poReference': 'PO002',
      'paymentTerms': 'Net 30'
    },
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'id': 'P001',
      'name': 'Dell Laptop i7',
      'category': 'Electronics',
      'purchasePrice': 3500,
      'minOrderQty': 5,
      'preferredVendor': 'Tech Supplies Co.',
      'leadTime': 7,
      'uom': 'Piece',
      'reorderLevel': 10
    },
    {
      'id': 'P002',
      'name': 'Ergonomic Office Chair',
      'category': 'Furniture',
      'purchasePrice': 400,
      'minOrderQty': 10,
      'preferredVendor': 'Office Furniture Ltd.',
      'leadTime': 14,
      'uom': 'Piece',
      'reorderLevel': 25
    },
  ];

  // Dashboard KPIs
  final double _totalPurchaseThisMonth = 125000;
  final int _rfqsAwaitingResponse = 3;
  final int _posPendingApproval = 2;
  final double _purchaseSavings = 15000;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
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

  // Core Purchasing Functions
  void _showCreateRfqDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateRfqDialog(
        onRfqCreated: (rfq) {
          setState(() {
            _rfqs.insert(0, rfq);
          });
        },
        vendors: _vendors,
      ),
    );
  }

  void _showCreatePurchaseOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => CreatePurchaseOrderDialog(
        onPOCreated: (po) {
          setState(() {
            _purchaseOrders.insert(0, po);
          });
        },
        vendors: _vendors,
        products: _products,
      ),
    );
  }

  void _showAddVendorDialog() {
    showDialog(
      context: context,
      builder: (context) => AddVendorDialog(
        onVendorAdded: (vendor) {
          setState(() {
            _vendors.add(vendor);
          });
        },
      ),
    );
  }

  void _showVendorDetails(Map<String, dynamic> vendor) {
    showDialog(
      context: context,
      builder: (context) => VendorDetailsDialog(vendor: vendor),
    );
  }

  void _showRfqDetails(Map<String, dynamic> rfq) {
    showDialog(
      context: context,
      builder: (context) => RfqDetailsDialog(rfq: rfq),
    );
  }

  void _showPurchaseOrderDetails(Map<String, dynamic> po) {
    showDialog(
      context: context,
      builder: (context) => PurchaseOrderDetailsDialog(po: po),
    );
  }

  void _showReceiptDetails(Map<String, dynamic> receipt) {
    showDialog(
      context: context,
      builder: (context) => ReceiptDetailsDialog(receipt: receipt),
    );
  }

  void _approvePurchaseOrder(int index) {
    setState(() {
      _purchaseOrders[index]['status'] = 'Approved';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Purchase Order ${_purchaseOrders[index]['id']} approved', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _receivePurchaseOrder(int index) {
    setState(() {
      _purchaseOrders[index]['status'] = 'Received';
      // Create receipt
      _receipts.insert(0, {
        'id': 'GRN${_receipts.length + 1}'.padLeft(3, '0'),
        'poNumber': _purchaseOrders[index]['id'],
        'vendor': _purchaseOrders[index]['vendor'],
        'receiptDate': _formatDate(DateTime.now()),
        'status': 'Completed',
        'totalItems': _purchaseOrders[index]['items'].fold(0, (sum, item) => sum + item['quantity']),
        'receivedBy': widget.user?.username ?? 'Current User',
        'items': _purchaseOrders[index]['items'].map((item) => {
          'product': item['product'],
          'ordered': item['quantity'],
          'received': item['quantity'],
          'damaged': 0
        }).toList()
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Purchase Order ${_purchaseOrders[index]['id']} marked as received', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Utility Functions
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'draft': return Colors.grey;
      case 'sent': return Colors.orange;
      case 'approved': return Colors.green;
      case 'ordered': return Colors.blue;
      case 'received': return Colors.purple;
      case 'paid': return Colors.green;
      case 'unpaid': return Colors.red;
      case 'completed': return Colors.green;
      case 'partial': return Colors.orange;
      case 'closed': return Colors.grey;
      case 'active': return Colors.green;
      case 'inactive': return Colors.red;
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
          'Purchasing Management',
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
            Tab(text: 'RFQs'),
            Tab(text: 'Purchase Orders'),
            Tab(text: 'Vendors'),
            Tab(text: 'Receipts'),
            Tab(text: 'Bills'),
            Tab(text: 'Products'),
            Tab(text: 'Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildRfqsTab(),
          _buildPurchaseOrdersTab(),
          _buildVendorsTab(),
          _buildReceiptsTab(),
          _buildBillsTab(),
          _buildProductsTab(),
          _buildReportsTab(),
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
              _buildStatCard('Total Purchase', 'SAR ${_totalPurchaseThisMonth.toStringAsFixed(0)}', Colors.blue, Icons.shopping_cart),
              SizedBox(width: 12),
              _buildStatCard('RFQs Awaiting', _rfqsAwaitingResponse.toString(), Colors.orange, Icons.request_quote),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('POs Pending', _posPendingApproval.toString(), Colors.red, Icons.pending_actions),
              SizedBox(width: 12),
              _buildStatCard('Purchase Savings', 'SAR ${_purchaseSavings.toStringAsFixed(0)}', Colors.green, Icons.savings),
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
              _buildActionButton('Create RFQ', Icons.request_quote, Colors.blue, _showCreateRfqDialog),
              _buildActionButton('Create PO', Icons.shopping_cart, Colors.green, _showCreatePurchaseOrderDialog),
              _buildActionButton('Add Vendor', Icons.business, Colors.orange, _showAddVendorDialog),
              _buildActionButton('Receive Goods', Icons.inventory, Colors.purple, () {}),
              _buildActionButton('Process Bill', Icons.receipt, Colors.teal, () {}),
              _buildActionButton('Vendor Evaluation', Icons.assessment, Colors.brown, () {}),
            ],
          ),

          // Recent Purchase Orders
          SizedBox(height: 20),
          _buildRecentPurchaseOrders(),

          // Vendor Performance
          SizedBox(height: 20),
          _buildVendorPerformance(),
        ],
      ),
    );
  }

  Widget _buildRfqsTab() {
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
                    hintText: 'Search RFQs...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _showRfqFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _rfqs.length,
            itemBuilder: (context, index) {
              final rfq = _rfqs[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.request_quote, color: AppColors.primaryColor),
                  ),
                  title: Text(rfq['title'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Budget: SAR ${rfq['budget']}', style: TextStyle(fontFamily: 'Cairo')),
                      Text('Deadline: ${rfq['deadline']}', style: TextStyle(fontFamily: 'Cairo')),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(rfq['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: _getStatusColor(rfq['status']),
                  ),
                  onTap: () => _showRfqDetails(rfq),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseOrdersTab() {
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
                    hintText: 'Search Purchase Orders...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _showPOFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _purchaseOrders.length,
            itemBuilder: (context, index) {
              final po = _purchaseOrders[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.shopping_cart, color: AppColors.primaryColor),
                  ),
                  title: Text('${po['id']} - ${po['vendor']}', style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount: SAR ${po['totalAmount']}', style: TextStyle(fontFamily: 'Cairo')),
                      Text('Expected: ${po['expectedDate']}', style: TextStyle(fontFamily: 'Cairo')),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Chip(
                        label: Text(po['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                        backgroundColor: _getStatusColor(po['status']),
                      ),
                      if (po['status'] == 'Draft' || po['status'] == 'Ordered')
                        IconButton(
                          icon: Icon(Icons.approval, color: Colors.blue),
                          onPressed: () => _approvePurchaseOrder(index),
                          tooltip: 'Approve Purchase Order',
                        ),
                      if (po['status'] == 'Approved')
                        IconButton(
                          icon: Icon(Icons.check_circle, color: Colors.green),
                          onPressed: () => _receivePurchaseOrder(index),
                          tooltip: 'Mark as Received',
                        ),
                    ],
                  ),
                  onTap: () => _showPurchaseOrderDetails(po),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVendorsTab() {
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
                    hintText: 'Search vendors...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _showVendorFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _vendors.length,
            itemBuilder: (context, index) {
              final vendor = _vendors[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.business, color: AppColors.primaryColor),
                  ),
                  title: Text(vendor['name'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vendor['contact'], style: TextStyle(fontFamily: 'Cairo')),
                      Text(vendor['category'], style: TextStyle(fontFamily: 'Cairo')),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          Text(' ${vendor['rating']}', style: TextStyle(fontFamily: 'Cairo')),
                        ],
                      ),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(vendor['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: _getStatusColor(vendor['status']),
                  ),
                  onTap: () => _showVendorDetails(vendor),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _receipts.length,
      itemBuilder: (context, index) {
        final receipt = _receipts[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.inventory, color: AppColors.primaryColor),
            ),
            title: Text('${receipt['id']} - ${receipt['vendor']}', style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PO: ${receipt['poNumber']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Date: ${receipt['receiptDate']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Items: ${receipt['totalItems']}', style: TextStyle(fontFamily: 'Cairo')),
              ],
            ),
            trailing: Chip(
              label: Text(receipt['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
              backgroundColor: _getStatusColor(receipt['status']),
            ),
            onTap: () => _showReceiptDetails(receipt),
          ),
        );
      },
    );
  }

  Widget _buildBillsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _vendorBills.length,
      itemBuilder: (context, index) {
        final bill = _vendorBills[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.receipt, color: AppColors.primaryColor),
            ),
            title: Text('${bill['id']} - ${bill['vendor']}', style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount: SAR ${bill['amount']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Due: ${bill['dueDate']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('PO: ${bill['poReference']}', style: TextStyle(fontFamily: 'Cairo')),
              ],
            ),
            trailing: Chip(
              label: Text(bill['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
              backgroundColor: _getStatusColor(bill['status']),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.inventory_2, color: AppColors.primaryColor),
            ),
            title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${product['category']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Purchase Price: SAR ${product['purchasePrice']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Vendor: ${product['preferredVendor']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Lead Time: ${product['leadTime']} days', style: TextStyle(fontFamily: 'Cairo')),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit, color: AppColors.primaryColor),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Purchasing Reports', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _buildReportCard('Purchase by Vendor', Icons.bar_chart, Colors.blue),
          _buildReportCard('Monthly Spend Analysis', Icons.trending_up, Colors.green),
          _buildReportCard('Vendor Performance', Icons.assessment, Colors.orange),
          _buildReportCard('Delivery Performance', Icons.schedule, Colors.purple),
          _buildReportCard('Price Comparison', Icons.compare, Colors.teal),
          _buildReportCard('Budget vs Actual', Icons.account_balance, Colors.red),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 1: // RFQs
        return FloatingActionButton(
          onPressed: _showCreateRfqDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.request_quote, color: Colors.white),
        );
      case 2: // Purchase Orders
        return FloatingActionButton(
          onPressed: _showCreatePurchaseOrderDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add_shopping_cart, color: Colors.white),
        );
      case 3: // Vendors
        return FloatingActionButton(
          onPressed: _showAddVendorDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.business, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: _showCreatePurchaseOrderDialog,
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
              Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildRecentPurchaseOrders() {
    final recentPOs = _purchaseOrders.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Purchase Orders', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${_purchaseOrders.length} total', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 12),
            ...recentPOs.map((po) => _buildRecentPOItem(po)),
            if (recentPOs.isEmpty)
              Text('No purchase orders yet', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPOItem(Map<String, dynamic> po) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      color: Colors.grey[50],
      child: ListTile(
        leading: Icon(Icons.shopping_cart, color: _getStatusColor(po['status'])),
        title: Text(po['id'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(po['vendor'], style: TextStyle(fontFamily: 'Cairo')),
            Text('SAR ${po['totalAmount']}', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: Chip(
          label: Text(po['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 10)),
          backgroundColor: _getStatusColor(po['status']),
        ),
      ),
    );
  }

  Widget _buildVendorPerformance() {
    final topVendors = _vendors.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Vendor Performance', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ...topVendors.map((vendor) => _buildVendorPerformanceItem(vendor)),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorPerformanceItem(Map<String, dynamic> vendor) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Text(vendor['name'][0], style: TextStyle(color: AppColors.primaryColor)),
        ),
        title: Text(vendor['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timer, size: 12, color: Colors.green),
                SizedBox(width: 4),
                Text('${vendor['onTimeDelivery']}% On-time', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.high_quality, size: 12, color: Colors.blue),
                SizedBox(width: 4),
                Text('${vendor['qualityScore']}% Quality', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
          ],
        ),
        trailing: Chip(
          label: Text('${vendor['rating']}', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontFamily: 'Cairo')),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  void _showRfqFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter RFQs', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add filter options here
            Text('Filter by status, date, budget...', style: TextStyle(fontFamily: 'Cairo')),
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

  void _showPOFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Purchase Orders', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter by status, vendor, date...', style: TextStyle(fontFamily: 'Cairo')),
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

  void _showVendorFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Vendors', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter by category, rating, status...', style: TextStyle(fontFamily: 'Cairo')),
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

// Interactive Dialogs
class CreateRfqDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onRfqCreated;
  final List<Map<String, dynamic>> vendors;

  const CreateRfqDialog({super.key, required this.onRfqCreated, required this.vendors});

  @override
  State<CreateRfqDialog> createState() => _CreateRfqDialogState();
}

class _CreateRfqDialogState extends State<CreateRfqDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _budgetController = TextEditingController();
  DateTime? _deadline;
  final List<String> _selectedVendors = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Request for Quotation', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'RFQ Title'),
                validator: (value) => value!.isEmpty ? 'Please enter title' : null,
              ),
              TextFormField(
                controller: _budgetController,
                decoration: InputDecoration(labelText: 'Budget (SAR)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter budget' : null,
              ),
              ListTile(
                title: Text(_deadline == null ? 'Select Deadline' : 'Deadline: ${_formatDate(_deadline!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 15)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _deadline = date);
                },
              ),
              SizedBox(height: 16),
              Text('Select Vendors:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ...widget.vendors.map((vendor) => CheckboxListTile(
                title: Text(vendor['name'], style: TextStyle(fontFamily: 'Cairo')),
                value: _selectedVendors.contains(vendor['id']),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedVendors.add(vendor['id']);
                    } else {
                      _selectedVendors.remove(vendor['id']);
                    }
                  });
                },
              )),
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
            if (_formKey.currentState!.validate() && _deadline != null && _selectedVendors.isNotEmpty) {
              widget.onRfqCreated({
                'id': 'RFQ${DateTime.now().millisecondsSinceEpoch}'.substring(0, 6),
                'title': _titleController.text,
                'status': 'Draft',
                'createdDate': _formatDate(DateTime.now()),
                'deadline': _formatDate(_deadline!),
                'budget': double.parse(_budgetController.text),
                'assignedTo': 'Current User',
                'vendors': _selectedVendors,
                'items': []
              });
              Navigator.pop(context);
            }
          },
          child: Text('Create RFQ', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class CreatePurchaseOrderDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onPOCreated;
  final List<Map<String, dynamic>> vendors;
  final List<Map<String, dynamic>> products;

  const CreatePurchaseOrderDialog({super.key, required this.onPOCreated, required this.vendors, required this.products});

  @override
  State<CreatePurchaseOrderDialog> createState() => _CreatePurchaseOrderDialogState();
}

class _CreatePurchaseOrderDialogState extends State<CreatePurchaseOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedVendor;
  DateTime? _expectedDate;
  final List<Map<String, dynamic>> _items = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Purchase Order', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                initialValue: _selectedVendor,
                items: widget.vendors
                    .map((vendor) => DropdownMenuItem(
                          value: vendor['id'],
                          child: Text(vendor['name'], style: TextStyle(fontFamily: 'Cairo')),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedVendor = value as String?),
                decoration: InputDecoration(labelText: 'Select Vendor'),
              ),
              ListTile(
                title: Text(_expectedDate == null ? 'Select Expected Date' : 'Expected: ${_formatDate(_expectedDate!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 7)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _expectedDate = date);
                },
              ),
              SizedBox(height: 16),
              Text('Add Items:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ..._items.asMap().entries.map((entry) => ListTile(
                title: Text(entry.value['product'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('Qty: ${entry.value['quantity']} × SAR ${entry.value['unitPrice']}', style: TextStyle(fontFamily: 'Cairo')),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => setState(() => _items.removeAt(entry.key)),
                ),
              )),
              ElevatedButton(
                onPressed: _showAddItemDialog,
                child: Text('Add Item', style: TextStyle(fontFamily: 'Cairo')),
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
          onPressed: _items.isEmpty ? null : () {
            if (_formKey.currentState!.validate() && _selectedVendor != null && _expectedDate != null) {
              final vendor = widget.vendors.firstWhere((v) => v['id'] == _selectedVendor);
              final totalAmount = _items.fold(0.0, (sum, item) => sum + item['total']);
              
              widget.onPOCreated({
                'id': 'PO${DateTime.now().millisecondsSinceEpoch}'.substring(0, 6),
                'vendor': vendor['name'],
                'status': 'Draft',
                'orderDate': _formatDate(DateTime.now()),
                'expectedDate': _formatDate(_expectedDate!),
                'totalAmount': totalAmount,
                'currency': 'SAR',
                'items': List.from(_items)
              });
              Navigator.pop(context);
            }
          },
          child: Text('Create PO', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        products: widget.products,
        onItemAdded: (item) {
          setState(() {
            _items.add(item);
          });
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class AddVendorDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onVendorAdded;

  const AddVendorDialog({super.key, required this.onVendorAdded});

  @override
  State<AddVendorDialog> createState() => _AddVendorDialogState();
}

class _AddVendorDialogState extends State<AddVendorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCategory = 'Electronics';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Vendor', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Vendor Name'),
                validator: (value) => value!.isEmpty ? 'Please enter vendor name' : null,
              ),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Contact Person'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              DropdownButtonFormField(
                initialValue: _selectedCategory,
                items: ['Electronics', 'Furniture', 'Raw Materials', 'Office Supplies', 'Services']
                    .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
                decoration: InputDecoration(labelText: 'Category'),
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
              widget.onVendorAdded({
                'id': 'V${DateTime.now().millisecondsSinceEpoch}'.substring(0, 6),
                'name': _nameController.text,
                'contact': _contactController.text,
                'email': _emailController.text,
                'phone': _phoneController.text,
                'rating': 0.0,
                'category': _selectedCategory,
                'status': 'Active',
                'totalSpend': 0,
                'onTimeDelivery': 0,
                'qualityScore': 0
              });
              Navigator.pop(context);
            }
          },
          child: Text('Add Vendor', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class AddItemDialog extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) onItemAdded;

  const AddItemDialog({super.key, required this.products, required this.onItemAdded});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String? _selectedProduct;
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Item', style: TextStyle(fontFamily: 'Cairo')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
            initialValue: _selectedProduct,
            items: widget.products
                .map((product) => DropdownMenuItem(
                      value: product['id'],
                      child: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() => _selectedProduct = value as String?);
              if (_selectedProduct != null) {
                final product = widget.products.firstWhere((p) => p['id'] == _selectedProduct);
                _unitPriceController.text = product['purchasePrice'].toString();
              }
            },
            decoration: InputDecoration(labelText: 'Select Product'),
          ),
          TextFormField(
            controller: _quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _unitPriceController,
            decoration: InputDecoration(labelText: 'Unit Price (SAR)'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: _selectedProduct == null ? null : () {
            final product = widget.products.firstWhere((p) => p['id'] == _selectedProduct);
            final quantity = int.tryParse(_quantityController.text) ?? 1;
            final unitPrice = double.tryParse(_unitPriceController.text) ?? 0;
            
            widget.onItemAdded({
              'product': product['name'],
              'quantity': quantity,
              'unitPrice': unitPrice,
              'total': quantity * unitPrice
            });
            Navigator.pop(context);
          },
          child: Text('Add', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

// Details Dialogs
class VendorDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> vendor;

  const VendorDetailsDialog({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Vendor Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('Vendor ID', vendor['id']),
            _buildDetailRow('Name', vendor['name']),
            _buildDetailRow('Contact', vendor['contact']),
            _buildDetailRow('Email', vendor['email']),
            _buildDetailRow('Phone', vendor['phone']),
            _buildDetailRow('Category', vendor['category']),
            _buildDetailRow('Status', vendor['status']),
            _buildDetailRow('Rating', vendor['rating'].toString()),
            _buildDetailRow('Total Spend', 'SAR ${vendor['totalSpend']}'),
            _buildDetailRow('On-time Delivery', '${vendor['onTimeDelivery']}%'),
            _buildDetailRow('Quality Score', '${vendor['qualityScore']}%'),
          ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontFamily: 'Cairo'))),
        ],
      ),
    );
  }
}

class RfqDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> rfq;

  const RfqDetailsDialog({super.key, required this.rfq});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('RFQ Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('RFQ ID', rfq['id']),
            _buildDetailRow('Title', rfq['title']),
            _buildDetailRow('Status', rfq['status']),
            _buildDetailRow('Created Date', rfq['createdDate']),
            _buildDetailRow('Deadline', rfq['deadline']),
            _buildDetailRow('Budget', 'SAR ${rfq['budget']}'),
            _buildDetailRow('Assigned To', rfq['assignedTo']),
            SizedBox(height: 16),
            Text('Items:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ...rfq['items'].map<Widget>((item) => Text('• ${item['product']} (${item['quantity']})', style: TextStyle(fontFamily: 'Cairo'))),
          ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontFamily: 'Cairo'))),
        ],
      ),
    );
  }
}

class PurchaseOrderDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> po;

  const PurchaseOrderDetailsDialog({super.key, required this.po});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Purchase Order Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('PO ID', po['id']),
            _buildDetailRow('Vendor', po['vendor']),
            _buildDetailRow('Status', po['status']),
            _buildDetailRow('Order Date', po['orderDate']),
            _buildDetailRow('Expected Date', po['expectedDate']),
            _buildDetailRow('Total Amount', 'SAR ${po['totalAmount']}'),
            SizedBox(height: 16),
            Text('Items:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ...po['items'].map<Widget>((item) => 
              Card(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  title: Text(item['product'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('Qty: ${item['quantity']}', style: TextStyle(fontFamily: 'Cairo')),
                  trailing: Text('SAR ${item['total']}', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                ),
              )),
          ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontFamily: 'Cairo'))),
        ],
      ),
    );
  }
}

class ReceiptDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> receipt;

  const ReceiptDetailsDialog({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Goods Receipt Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('GRN ID', receipt['id']),
            _buildDetailRow('PO Number', receipt['poNumber']),
            _buildDetailRow('Vendor', receipt['vendor']),
            _buildDetailRow('Receipt Date', receipt['receiptDate']),
            _buildDetailRow('Status', receipt['status']),
            _buildDetailRow('Received By', receipt['receivedBy']),
            SizedBox(height: 16),
            Text('Items Received:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ...receipt['items'].map<Widget>((item) => 
              Card(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  title: Text(item['product'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('Ordered: ${item['ordered']} | Received: ${item['received']}', style: TextStyle(fontFamily: 'Cairo')),
                  trailing: item['damaged'] > 0 
                      ? Text('${item['damaged']} damaged', style: TextStyle(fontFamily: 'Cairo', color: Colors.red))
                      : null,
                ),
              )),
          ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontFamily: 'Cairo'))),
        ],
      ),
    );
  }
}