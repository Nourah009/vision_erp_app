import 'package:flutter/material.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';

class SalePage extends StatefulWidget {
  final UserModel? user;
  
  const SalePage({super.key, this.user});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  
  // Sample sales data
  final List<Map<String, dynamic>> _quotations = [
    {
      'id': 'QT-001', 
      'customer': 'Tech Solutions Ltd.', 
      'amount': 25000.00, 
      'status': 'Sent',
      'date': '2024-01-15', 
      'validUntil': '2024-02-15',
      'salesperson': 'Ahmed Mohamed',
      'probability': 75
    },
    {
      'id': 'QT-002', 
      'customer': 'Global Enterprises', 
      'amount': 45000.00, 
      'status': 'Draft',
      'date': '2024-01-16', 
      'validUntil': '2024-02-16',
      'salesperson': 'Sarah Ahmed',
      'probability': 40
    },
    {
      'id': 'QT-003', 
      'customer': 'Innovation Corp', 
      'amount': 12000.00, 
      'status': 'Accepted',
      'date': '2024-01-10', 
      'validUntil': '2024-02-10',
      'salesperson': 'Yasser Ali',
      'probability': 100
    },
  ];

  final List<Map<String, dynamic>> _salesOrders = [
    {
      'id': 'SO-001',
      'customer': 'Innovation Corp',
      'amount': 12000.00,
      'status': 'Confirmed',
      'orderDate': '2024-01-12',
      'deliveryDate': '2024-01-25',
      'salesperson': 'Yasser Ali',
      'paymentStatus': 'Paid'
    },
    {
      'id': 'SO-002',
      'customer': 'Tech Solutions Ltd.',
      'amount': 18000.00,
      'status': 'Delivered',
      'orderDate': '2024-01-08',
      'deliveryDate': '2024-01-18',
      'salesperson': 'Ahmed Mohamed',
      'paymentStatus': 'Partial'
    },
    {
      'id': 'SO-003',
      'customer': 'Startup Ventures',
      'amount': 8500.00,
      'status': 'Draft',
      'orderDate': '2024-01-17',
      'deliveryDate': '2024-01-30',
      'salesperson': 'Sarah Ahmed',
      'paymentStatus': 'Unpaid'
    },
  ];

  final List<Map<String, dynamic>> _customers = [
    {
      'id': 'CUST-001',
      'name': 'Tech Solutions Ltd.',
      'type': 'Corporate',
      'email': 'contact@techsolutions.com',
      'phone': '+966501234567',
      'address': 'Riyadh, Saudi Arabia',
      'creditLimit': 100000.00,
      'totalOrders': 15,
      'totalSpent': 245000.00,
      'status': 'Active'
    },
    {
      'id': 'CUST-002',
      'name': 'Global Enterprises',
      'type': 'Corporate',
      'email': 'sales@globalent.com',
      'phone': '+966502345678',
      'address': 'Jeddah, Saudi Arabia',
      'creditLimit': 50000.00,
      'totalOrders': 8,
      'totalSpent': 89000.00,
      'status': 'Active'
    },
    {
      'id': 'CUST-003',
      'name': 'Innovation Corp',
      'type': 'SME',
      'email': 'info@innovation.com',
      'phone': '+966503456789',
      'address': 'Dubai, UAE',
      'creditLimit': 25000.00,
      'totalOrders': 22,
      'totalSpent': 156000.00,
      'status': 'VIP'
    },
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'id': 'PROD-001',
      'name': 'Smartphone X1',
      'category': 'Electronics',
      'salesPrice': 899.00,
      'costPrice': 550.00,
      'stock': 1500,
      'uom': 'pcs',
      'tax': 15.0,
      'status': 'Active',
      'margin': 38.9
    },
    {
      'id': 'PROD-002',
      'name': 'Laptop Pro',
      'category': 'Electronics',
      'salesPrice': 1299.00,
      'costPrice': 890.00,
      'stock': 800,
      'uom': 'pcs',
      'tax': 15.0,
      'status': 'Active',
      'margin': 31.5
    },
    {
      'id': 'PROD-003',
      'name': 'Tablet Mini',
      'category': 'Electronics',
      'salesPrice': 499.00,
      'costPrice': 320.00,
      'stock': 2000,
      'uom': 'pcs',
      'tax': 15.0,
      'status': 'Active',
      'margin': 35.9
    },
  ];

  final List<Map<String, dynamic>> _invoices = [
    {
      'id': 'INV-001',
      'customer': 'Innovation Corp',
      'amount': 12000.00,
      'status': 'Paid',
      'issueDate': '2024-01-12',
      'dueDate': '2024-02-12',
      'salesOrder': 'SO-001',
      'paymentMethod': 'Bank Transfer'
    },
    {
      'id': 'INV-002',
      'customer': 'Tech Solutions Ltd.',
      'amount': 18000.00,
      'status': 'Partial',
      'issueDate': '2024-01-08',
      'dueDate': '2024-02-08',
      'salesOrder': 'SO-002',
      'paymentMethod': 'Credit Card'
    },
    {
      'id': 'INV-003',
      'customer': 'Startup Ventures',
      'amount': 8500.00,
      'status': 'Overdue',
      'issueDate': '2024-01-03',
      'dueDate': '2024-01-18',
      'salesOrder': 'SO-003',
      'paymentMethod': 'Cash'
    },
  ];

  final List<Map<String, dynamic>> _salesTeam = [
    {
      'id': 'SAL-001',
      'name': 'Ahmed Mohamed',
      'email': 'ahmed@sales.com',
      'phone': '+966504567890',
      'region': 'Riyadh',
      'target': 500000.00,
      'achieved': 325000.00,
      'commissionRate': 5.0,
      'status': 'Active',
      'performance': 85.0
    },
    {
      'id': 'SAL-002',
      'name': 'Sarah Ahmed',
      'email': 'sarah@sales.com',
      'phone': '+966505678901',
      'region': 'Jeddah',
      'target': 450000.00,
      'achieved': 289000.00,
      'commissionRate': 5.0,
      'status': 'Active',
      'performance': 78.5
    },
    {
      'id': 'SAL-003',
      'name': 'Yasser Ali',
      'email': 'yasser@sales.com',
      'phone': '+966506789012',
      'region': 'Dubai',
      'target': 300000.00,
      'achieved': 156000.00,
      'commissionRate': 5.0,
      'status': 'Active',
      'performance': 62.0
    },
  ];

  final List<Map<String, dynamic>> _priceLists = [
    {
      'id': 'PL-001',
      'name': 'Standard Price List',
      'currency': 'SAR',
      'validFrom': '2024-01-01',
      'validTo': '2024-12-31',
      'status': 'Active',
      'products': 45
    },
    {
      'id': 'PL-002',
      'name': 'VIP Customer List',
      'currency': 'SAR',
      'validFrom': '2024-01-01',
      'validTo': '2024-12-31',
      'status': 'Active',
      'products': 45
    },
    {
      'id': 'PL-003',
      'name': 'Seasonal Promotion',
      'currency': 'SAR',
      'validFrom': '2024-01-15',
      'validTo': '2024-02-15',
      'status': 'Active',
      'products': 12
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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

  // Sales Functions
  void _showQuotationDetails(Map<String, dynamic> quotation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quotation Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Quotation ID', quotation['id']),
              _buildDetailRow('Customer', quotation['customer']),
              _buildDetailRow('Amount', '\$${quotation['amount']}'),
              _buildDetailRow('Status', quotation['status']),
              _buildDetailRow('Probability', '${quotation['probability']}%'),
              _buildDetailRow('Salesperson', quotation['salesperson']),
              _buildDetailRow('Date', quotation['date']),
              _buildDetailRow('Valid Until', quotation['validUntil']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _editQuotation(quotation),
            child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
          ),
          if (quotation['status'] == 'Draft' || quotation['status'] == 'Sent')
            ElevatedButton(
              onPressed: () => _convertToSalesOrder(quotation),
              child: Text('Convert to SO', style: TextStyle(fontFamily: 'Cairo')),
            ),
        ],
      ),
    );
  }

  void _editQuotation(Map<String, dynamic> quotation) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AddQuotationDialog(
        quotation: quotation,
        onQuotationAdded: (updatedQuotation) {
          setState(() {
            final index = _quotations.indexWhere((q) => q['id'] == quotation['id']);
            if (index != -1) {
              _quotations[index] = {..._quotations[index], ...updatedQuotation};
            }
          });
        },
      ),
    );
  }

  void _createQuotation() {
    showDialog(
      context: context,
      builder: (context) => AddQuotationDialog(
        onQuotationAdded: (quotation) {
          setState(() {
            _quotations.insert(0, quotation);
          });
        },
      ),
    );
  }

  void _convertToSalesOrder(Map<String, dynamic> quotation) {
    setState(() {
      quotation['status'] = 'Converted';
      _salesOrders.insert(0, {
        'id': 'SO-${DateTime.now().millisecondsSinceEpoch}',
        'customer': quotation['customer'],
        'amount': quotation['amount'],
        'status': 'Confirmed',
        'orderDate': _formatDate(DateTime.now()),
        'deliveryDate': quotation['validUntil'],
        'salesperson': quotation['salesperson'],
        'paymentStatus': 'Unpaid'
      });
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quotation converted to Sales Order', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void _showCustomerDetails(Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Customer Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer ID', customer['id']),
              _buildDetailRow('Name', customer['name']),
              _buildDetailRow('Type', customer['type']),
              _buildDetailRow('Email', customer['email']),
              _buildDetailRow('Phone', customer['phone']),
              _buildDetailRow('Address', customer['address']),
              _buildDetailRow('Credit Limit', '\$${customer['creditLimit']}'),
              _buildDetailRow('Total Orders', '${customer['totalOrders']}'),
              _buildDetailRow('Total Spent', '\$${customer['totalSpent']}'),
              _buildDetailRow('Status', customer['status']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _createQuotationForCustomer(customer),
            child: Text('Create Quotation', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _createQuotationForCustomer(Map<String, dynamic> customer) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AddQuotationDialog(
        customer: customer,
        onQuotationAdded: (quotation) {
          setState(() {
            _quotations.insert(0, quotation);
          });
        },
      ),
    );
  }

  void _showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Product Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Product ID', product['id']),
              _buildDetailRow('Name', product['name']),
              _buildDetailRow('Category', product['category']),
              _buildDetailRow('Sales Price', '\$${product['salesPrice']}'),
              _buildDetailRow('Cost Price', '\$${product['costPrice']}'),
              _buildDetailRow('Margin', '${product['margin']}%'),
              _buildDetailRow('Stock', '${product['stock']} ${product['uom']}'),
              _buildDetailRow('Tax', '${product['tax']}%'),
              _buildDetailRow('Status', product['status']),
            ],
          ),
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

  void _showSalesOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sales Order Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Order ID', order['id']),
              _buildDetailRow('Customer', order['customer']),
              _buildDetailRow('Amount', '\$${order['amount']}'),
              _buildDetailRow('Status', order['status']),
              _buildDetailRow('Payment Status', order['paymentStatus']),
              _buildDetailRow('Salesperson', order['salesperson']),
              _buildDetailRow('Order Date', order['orderDate']),
              _buildDetailRow('Delivery Date', order['deliveryDate']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          if (order['status'] == 'Confirmed')
            ElevatedButton(
              onPressed: () => _createInvoiceFromOrder(order),
              child: Text('Create Invoice', style: TextStyle(fontFamily: 'Cairo')),
            ),
        ],
      ),
    );
  }

  void _createInvoiceFromOrder(Map<String, dynamic> order) {
    setState(() {
      order['status'] = 'Invoiced';
      _invoices.insert(0, {
        'id': 'INV-${DateTime.now().millisecondsSinceEpoch}',
        'customer': order['customer'],
        'amount': order['amount'],
        'status': 'Unpaid',
        'issueDate': _formatDate(DateTime.now()),
        'dueDate': _formatDate(DateTime.now().add(Duration(days: 30))),
        'salesOrder': order['id'],
        'paymentMethod': 'Pending'
      });
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invoice created from Sales Order', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  // Utility Functions
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
      case 'confirmed':
      case 'delivered':
      case 'paid':
      case 'active':
      case 'vip':
        return Colors.green;
      case 'sent':
      case 'partial':
        return Colors.orange;
      case 'draft':
      case 'unpaid':
        return Colors.blue;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getProbabilityColor(double probability) {
    if (probability >= 80) return Colors.green;
    if (probability >= 60) return Colors.orange;
    if (probability >= 40) return Colors.yellow;
    return Colors.red;
  }

  // Filtered data based on search
  List<Map<String, dynamic>> get _filteredQuotations {
    if (_searchQuery.isEmpty) return _quotations;
    return _quotations.where((quotation) =>
      quotation['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      quotation['customer'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      quotation['status'].toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> get _filteredCustomers {
    if (_searchQuery.isEmpty) return _customers;
    return _customers.where((customer) =>
      customer['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      customer['email'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      customer['type'].toLowerCase().contains(_searchQuery.toLowerCase())
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
          'Sales Management',
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
            Tab(text: 'Quotations'),
            Tab(text: 'Sales Orders'),
            Tab(text: 'Customers'),
            Tab(text: 'Products'),
            Tab(text: 'Invoices'),
            Tab(text: 'Sales Team'),
            Tab(text: 'Price Lists'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildQuotationsTab(),
          _buildSalesOrdersTab(),
          _buildCustomersTab(),
          _buildProductsTab(),
          _buildInvoicesTab(),
          _buildSalesTeamTab(),
          _buildPriceListsTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    final totalSales = _salesOrders.fold(0.0, (sum, order) => sum + order['amount']);
    final openQuotations = _quotations.where((q) => q['status'] == 'Sent' || q['status'] == 'Draft').length;
    final confirmedOrders = _salesOrders.where((o) => o['status'] == 'Confirmed').length;
    final pendingInvoices = _invoices.where((i) => i['status'] == 'Unpaid' || i['status'] == 'Partial').length;
    final totalCustomers = _customers.length;
    final teamPerformance = _salesTeam.fold(0.0, (sum, member) => sum + member['performance']) / _salesTeam.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
          Row(
            children: [
              _buildStatCard('Total Sales', '\$${totalSales.toStringAsFixed(0)}', Colors.blue, Icons.attach_money),
              SizedBox(width: 12),
              _buildStatCard('Open Quotes', openQuotations.toString(), Colors.orange, Icons.description),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Confirmed Orders', confirmedOrders.toString(), Colors.green, Icons.shopping_cart),
              SizedBox(width: 12),
              _buildStatCard('Pending Invoices', pendingInvoices.toString(), Colors.red, Icons.receipt),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Total Customers', totalCustomers.toString(), Colors.purple, Icons.people),
              SizedBox(width: 12),
              _buildStatCard('Team Performance', '${teamPerformance.toStringAsFixed(1)}%', Colors.teal, Icons.assessment),
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
              _buildActionButton('Create Quotation', Icons.description, Colors.blue, _createQuotation),
              _buildActionButton('New Customer', Icons.person_add, Colors.green, _showAddCustomerDialog),
              _buildActionButton('Sales Report', Icons.analytics, Colors.orange, _showSalesReport),
              _buildActionButton('Price Lists', Icons.list_alt, Colors.purple, _showPriceLists),
              _buildActionButton('Team Performance', Icons.leaderboard, Colors.teal, _showTeamPerformance),
              _buildActionButton('Sales Pipeline', Icons.timeline, Colors.red, _showSalesPipeline),
            ],
          ),

          // Recent Quotations
          SizedBox(height: 20),
          _buildRecentQuotations(),

          // Top Customers
          SizedBox(height: 20),
          _buildTopCustomers(),
        ],
      ),
    );
  }

  Widget _buildQuotationsTab() {
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
                    hintText: 'Search quotations...',
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
                onPressed: _showQuotationFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredQuotations.length,
            itemBuilder: (context, index) {
              final quotation = _filteredQuotations[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.description, color: AppColors.primaryColor),
                  ),
                  title: Text(quotation['customer'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount: \$${quotation['amount']}', style: TextStyle(fontFamily: 'Cairo')),
                      Text('Salesperson: ${quotation['salesperson']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(quotation['status']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(quotation['status'], style: TextStyle(
                          color: _getStatusColor(quotation['status']),
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                      SizedBox(height: 4),
                      Text('${quotation['probability']}%', style: TextStyle(
                        color: _getProbabilityColor(quotation['probability']),
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                    ],
                  ),
                  onTap: () => _showQuotationDetails(quotation),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSalesOrdersTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _salesOrders.length,
      itemBuilder: (context, index) {
        final order = _salesOrders[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.shopping_cart, color: AppColors.primaryColor),
            ),
            title: Text(order['customer'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount: \$${order['amount']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Order Date: ${order['orderDate']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(order['status'], style: TextStyle(
                    color: _getStatusColor(order['status']),
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
                ),
                SizedBox(height: 4),
                Text(order['paymentStatus'], style: TextStyle(
                  color: _getStatusColor(order['paymentStatus']),
                  fontFamily: 'Cairo',
                  fontSize: 12,
                )),
              ],
            ),
            onTap: () => _showSalesOrderDetails(order),
          ),
        );
      },
    );
  }

  Widget _buildCustomersTab() {
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
                    hintText: 'Search customers...',
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
                onPressed: _showCustomerFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredCustomers.length,
            itemBuilder: (context, index) {
              final customer = _filteredCustomers[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.person, color: AppColors.primaryColor),
                  ),
                  title: Text(customer['name'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customer['email'], style: TextStyle(fontFamily: 'Cairo')),
                      Text('${customer['type']} • \$${customer['totalSpent']} spent', 
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(customer['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(customer['status'], style: TextStyle(
                      color: _getStatusColor(customer['status']),
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  onTap: () => _showCustomerDetails(customer),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.inventory_2, color: AppColors.primaryColor),
            ),
            title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: \$${product['salesPrice']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Stock: ${product['stock']} ${product['uom']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${product['margin']}%', style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(product['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(product['status'], style: TextStyle(
                    color: _getStatusColor(product['status']),
                    fontFamily: 'Cairo',
                    fontSize: 10,
                  )),
                ),
              ],
            ),
            onTap: () => _showProductDetails(product),
          ),
        );
      },
    );
  }

  Widget _buildInvoicesTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _invoices.length,
      itemBuilder: (context, index) {
        final invoice = _invoices[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.receipt, color: AppColors.primaryColor),
            ),
            title: Text(invoice['customer'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount: \$${invoice['amount']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('Due: ${invoice['dueDate']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(invoice['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(invoice['status'], style: TextStyle(
                    color: _getStatusColor(invoice['status']),
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
                ),
                SizedBox(height: 4),
                Text(invoice['paymentMethod'], style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSalesTeamTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _salesTeam.length,
      itemBuilder: (context, index) {
        final member = _salesTeam[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.person, color: AppColors.primaryColor),
            ),
            title: Text(member['name'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member['region'], style: TextStyle(fontFamily: 'Cairo')),
                Text('Target: \$${member['target']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${member['achieved']}', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: member['performance'] / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    member['performance'] >= 80 ? Colors.green :
                    member['performance'] >= 60 ? Colors.orange : Colors.red
                  ),
                ),
                Text('${member['performance']}%', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriceListsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _priceLists.length,
      itemBuilder: (context, index) {
        final priceList = _priceLists[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(Icons.list_alt, color: AppColors.primaryColor),
            ),
            title: Text(priceList['name'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${priceList['products']} products', style: TextStyle(fontFamily: 'Cairo')),
                Text('Valid: ${priceList['validFrom']} to ${priceList['validTo']}', 
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(priceList['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(priceList['status'], style: TextStyle(
                color: _getStatusColor(priceList['status']),
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 1: // Quotations
        return FloatingActionButton(
          onPressed: _createQuotation,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 2: // Sales Orders
        return FloatingActionButton(
          onPressed: _createQuotation,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add_shopping_cart, color: Colors.white),
        );
      case 3: // Customers
        return FloatingActionButton(
          onPressed: _showAddCustomerDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.person_add, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: _createQuotation,
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

  Widget _buildRecentQuotations() {
    final recentQuotations = _quotations.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Quotations', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${_quotations.length} total', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 12),
            ...recentQuotations.map((quotation) => _buildQuotationItem(quotation)),
            if (recentQuotations.isEmpty)
              Text('No quotations yet', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotationItem(Map<String, dynamic> quotation) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          Icons.description,
          color: _getStatusColor(quotation['status']),
        ),
        title: Text(quotation['customer'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${quotation['amount']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Probability: ${quotation['probability']}%', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(quotation['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(quotation['status'], style: TextStyle(
            color: _getStatusColor(quotation['status']),
            fontFamily: 'Cairo',
            fontSize: 12,
          )),
        ),
        onTap: () => _showQuotationDetails(quotation),
      ),
    );
  }

  Widget _buildTopCustomers() {
    final topCustomers = _customers.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Top Customers', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('VIP', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 12),
            ...topCustomers.map((customer) => _buildCustomerItem(customer)),
            if (topCustomers.isEmpty)
              Text('No customers yet', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerItem(Map<String, dynamic> customer) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Text(customer['name'][0], style: TextStyle(color: AppColors.primaryColor)),
        ),
        title: Text(customer['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${customer['totalSpent']} spent', style: TextStyle(fontFamily: 'Cairo')),
            Text('${customer['totalOrders']} orders', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(customer['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(customer['status'], style: TextStyle(
            color: _getStatusColor(customer['status']),
            fontFamily: 'Cairo',
            fontSize: 12,
          )),
        ),
        onTap: () => _showCustomerDetails(customer),
      ),
    );
  }

  // Dialog Methods
  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) => AddCustomerDialog(
        onCustomerAdded: (customer) {
          setState(() {
            _customers.add(customer);
          });
        },
      ),
    );
  }

  void _showSalesReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sales Report', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Sales report functionality will be implemented here', 
                    style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _showPriceLists() {
    // Navigate to price lists tab
    _tabController.animateTo(7);
  }

  void _showTeamPerformance() {
    showDialog(
      context: context,
      builder: (context) => TeamPerformanceDialog(salesTeam: _salesTeam),
    );
  }

  void _showSalesPipeline() {
    showDialog(
      context: context,
      builder: (context) => SalesPipelineDialog(quotations: _quotations),
    );
  }

  void _showQuotationFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Quotations', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Filter functionality to be implemented', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _showCustomerFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Customers', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Filter functionality to be implemented', style: TextStyle(fontFamily: 'Cairo')),
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
class AddQuotationDialog extends StatefulWidget {
  final Map<String, dynamic>? quotation;
  final Map<String, dynamic>? customer;
  final Function(Map<String, dynamic>) onQuotationAdded;

  const AddQuotationDialog({super.key, this.quotation, this.customer, required this.onQuotationAdded});

  @override
  State<AddQuotationDialog> createState() => _AddQuotationDialogState();
}

class _AddQuotationDialogState extends State<AddQuotationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedStatus = 'Draft';
  double _probability = 50.0;
  DateTime? _validUntil;

  @override
  void initState() {
    super.initState();
    if (widget.quotation != null) {
      _customerController.text = widget.quotation!['customer'];
      _amountController.text = widget.quotation!['amount'].toString();
      _selectedStatus = widget.quotation!['status'];
      _probability = widget.quotation!['probability'].toDouble();
    } else if (widget.customer != null) {
      _customerController.text = widget.customer!['name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.quotation == null ? 'Create Quotation' : 'Edit Quotation', 
                style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _customerController,
                decoration: InputDecoration(labelText: 'Customer'),
                validator: (value) => value!.isEmpty ? 'Please enter customer' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter amount' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedStatus,
                items: ['Draft', 'Sent', 'Accepted', 'Rejected']
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
                decoration: InputDecoration(labelText: 'Status'),
              ),
              SizedBox(height: 16),
              Text('Probability: ${_probability.toInt()}%', style: TextStyle(fontFamily: 'Cairo')),
              Slider(
                value: _probability,
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (value) => setState(() => _probability = value),
              ),
              ListTile(
                title: Text(_validUntil == null ? 'Select Valid Until Date' : 'Valid Until: ${_formatDate(_validUntil!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 30)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _validUntil = date);
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
            if (_formKey.currentState!.validate() && _validUntil != null) {
              widget.onQuotationAdded({
                'id': widget.quotation?['id'] ?? 'QT-${DateTime.now().millisecondsSinceEpoch}',
                'customer': _customerController.text,
                'amount': double.parse(_amountController.text),
                'status': _selectedStatus,
                'date': _formatDate(DateTime.now()),
                'validUntil': _formatDate(_validUntil!),
                'salesperson': 'Current User',
                'probability': _probability.toInt(),
              });
              Navigator.pop(context);
            }
          },
          child: Text(widget.quotation == null ? 'Create' : 'Update', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class AddCustomerDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onCustomerAdded;

  const AddCustomerDialog({super.key, required this.onCustomerAdded});

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _creditLimitController = TextEditingController();
  String _selectedType = 'Corporate';
  String _selectedStatus = 'Active';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Customer', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) => value!.isEmpty ? 'Please enter name' : null,
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
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: _creditLimitController,
                decoration: InputDecoration(labelText: 'Credit Limit'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField(
                initialValue: _selectedType,
                items: ['Corporate', 'SME', 'Individual']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(labelText: 'Customer Type'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedStatus,
                items: ['Active', 'VIP', 'Inactive']
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
              widget.onCustomerAdded({
                'id': 'CUST-${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'type': _selectedType,
                'email': _emailController.text,
                'phone': _phoneController.text,
                'address': _addressController.text,
                'creditLimit': double.tryParse(_creditLimitController.text) ?? 0.0,
                'totalOrders': 0,
                'totalSpent': 0.0,
                'status': _selectedStatus,
              });
              Navigator.pop(context);
            }
          },
          child: Text('Add Customer', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class TeamPerformanceDialog extends StatelessWidget {
  final List<Map<String, dynamic>> salesTeam;

  const TeamPerformanceDialog({super.key, required this.salesTeam});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Team Performance', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: salesTeam.map((member) => _buildPerformanceItem(member)).toList(),
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

  Widget _buildPerformanceItem(Map<String, dynamic> member) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Text(member['name'][0], style: TextStyle(color: AppColors.primaryColor)),
        ),
        title: Text(member['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Achieved: \$${member['achieved']} / \$${member['target']}', 
                style: TextStyle(fontFamily: 'Cairo')),
            LinearProgressIndicator(
              value: member['performance'] / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                member['performance'] >= 80 ? Colors.green :
                member['performance'] >= 60 ? Colors.orange : Colors.red
              ),
            ),
          ],
        ),
        trailing: Text('${member['performance']}%', 
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class SalesPipelineDialog extends StatelessWidget {
  final List<Map<String, dynamic>> quotations;

  const SalesPipelineDialog({super.key, required this.quotations});

  @override
  Widget build(BuildContext context) {
    final draft = quotations.where((q) => q['status'] == 'Draft').length;
    final sent = quotations.where((q) => q['status'] == 'Sent').length;
    final accepted = quotations.where((q) => q['status'] == 'Accepted').length;
    final totalValue = quotations.fold(0.0, (sum, q) => sum + q['amount']);

    return AlertDialog(
      title: Text('Sales Pipeline', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPipelineStage('Draft', draft, Colors.blue),
            _buildPipelineStage('Sent', sent, Colors.orange),
            _buildPipelineStage('Accepted', accepted, Colors.green),
            SizedBox(height: 16),
            Card(
              color: AppColors.primaryColor.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Total Pipeline Value', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    Text('\$${totalValue.toStringAsFixed(0)}', 
                         style: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
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

  Widget _buildPipelineStage(String stage, int count, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(stage, style: TextStyle(fontFamily: 'Cairo')),
        trailing: Chip(
          label: Text(count.toString(), style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          backgroundColor: color,
        ),
      ),
    );
  }
}