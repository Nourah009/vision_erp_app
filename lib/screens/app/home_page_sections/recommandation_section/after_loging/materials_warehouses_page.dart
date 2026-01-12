import 'package:flutter/material.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';

class MaterialsWarehousesPage extends StatefulWidget {
  const MaterialsWarehousesPage({super.key, UserModel? user});

  @override
  State<MaterialsWarehousesPage> createState() => _MaterialsWarehousesPageState();
}

class _MaterialsWarehousesPageState extends State<MaterialsWarehousesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  // Sample data for demonstration
  final List<Map<String, dynamic>> _products = [
    {
      'id': 'P001', 
      'name': 'Laptop Dell XPS 13', 
      'sku': 'DLXPS13-001', 
      'category': 'Electronics', 
      'uom': 'Unit',
      'cost': 1200.0, 
      'sale_price': 1500.0, 
      'quantity': 45,
      'min_stock': 10,
      'max_stock': 100,
      'type': 'Storable',
      'vendor': 'Dell Inc.',
      'tracking': 'Serial',
      'barcode': '1234567890123',
      'weight': 1.2,
      'dimensions': '30x20x5 cm'
    },
    {
      'id': 'P002', 
      'name': 'Office Chair Ergonomic', 
      'sku': 'OC-ERG-002', 
      'category': 'Furniture', 
      'uom': 'Unit',
      'cost': 250.0, 
      'sale_price': 350.0, 
      'quantity': 23,
      'min_stock': 5,
      'max_stock': 50,
      'type': 'Storable',
      'vendor': 'OfficePro',
      'tracking': 'None',
      'barcode': '1234567890124',
      'weight': 15.0,
      'dimensions': '60x60x110 cm'
    },
    {
      'id': 'P003', 
      'name': 'A4 Paper Pack', 
      'sku': 'PAP-A4-500', 
      'category': 'Stationery', 
      'uom': 'Pack',
      'cost': 15.0, 
      'sale_price': 25.0, 
      'quantity': 8,
      'min_stock': 20,
      'max_stock': 200,
      'type': 'Consumable',
      'vendor': 'PaperCo',
      'tracking': 'Lot',
      'barcode': '1234567890125',
      'weight': 2.5,
      'dimensions': '30x21x5 cm'
    },
    {
      'id': 'P004', 
      'name': 'Wireless Mouse', 
      'sku': 'WM-001', 
      'category': 'Electronics', 
      'uom': 'Unit',
      'cost': 25.0, 
      'sale_price': 40.0, 
      'quantity': 15,
      'min_stock': 10,
      'max_stock': 100,
      'type': 'Storable',
      'vendor': 'TechSupplies',
      'tracking': 'None',
      'barcode': '1234567890126',
      'weight': 0.1,
      'dimensions': '10x5x3 cm'
    },
  ];

  final List<Map<String, dynamic>> _warehouses = [
    {
      'id': 'WH001',
      'name': 'Main Warehouse',
      'location': 'Riyadh Industrial Zone',
      'type': 'Internal',
      'capacity': 10000,
      'used_capacity': 6500,
      'manager': 'Ahmed Ali',
      'status': 'Active',
      'contact': '+966 50 123 4567',
      'address': 'Industrial Zone, Riyadh 12345'
    },
    {
      'id': 'WH002',
      'name': 'Jeddah Distribution Center',
      'location': 'Jeddah Port Area',
      'type': 'Internal',
      'capacity': 8000,
      'used_capacity': 4200,
      'manager': 'Sarah Mohamed',
      'status': 'Active',
      'contact': '+966 50 765 4321',
      'address': 'Port Area, Jeddah 23456'
    },
    {
      'id': 'WH003',
      'name': 'Quality Control',
      'location': 'Main Facility',
      'type': 'Quality',
      'capacity': 1000,
      'used_capacity': 300,
      'manager': 'Quality Dept',
      'status': 'Active',
      'contact': '+966 50 111 2222',
      'address': 'Main Facility, Riyadh 12345'
    },
  ];

  final List<Map<String, dynamic>> _inventoryTransfers = [
    {
      'id': 'TR001',
      'reference': 'TRF/2024/001',
      'from_location': 'Main Warehouse',
      'to_location': 'Jeddah Distribution',
      'product': 'Laptop Dell XPS 13',
      'product_id': 'P001',
      'quantity': 10,
      'status': 'Completed',
      'date': '2024-01-15',
      'type': 'Internal Transfer',
      'notes': 'Regular stock transfer'
    },
    {
      'id': 'TR002',
      'reference': 'REC/2024/001',
      'from_location': 'Vendor Location',
      'to_location': 'Main Warehouse',
      'product': 'Office Chair Ergonomic',
      'product_id': 'P002',
      'quantity': 50,
      'status': 'In Progress',
      'date': '2024-01-16',
      'type': 'Receipt',
      'notes': 'New stock from vendor'
    },
    {
      'id': 'TR003',
      'reference': 'DEL/2024/001',
      'from_location': 'Main Warehouse',
      'to_location': 'Customer Location',
      'product': 'A4 Paper Pack',
      'product_id': 'P003',
      'quantity': 100,
      'status': 'Pending',
      'date': '2024-01-17',
      'type': 'Delivery',
      'notes': 'Customer order fulfillment'
    },
  ];

  final List<Map<String, dynamic>> _stockMovements = [
    {
      'id': 'MV001',
      'product': 'Laptop Dell XPS 13',
      'product_id': 'P001',
      'reference': 'SO-2024-001',
      'quantity': -2,
      'balance': 43,
      'date': '2024-01-15 10:30',
      'type': 'Sale',
      'location': 'Main Warehouse',
      'user': 'Sales Team'
    },
    {
      'id': 'MV002',
      'product': 'A4 Paper Pack',
      'product_id': 'P003',
      'reference': 'PO-2024-001',
      'quantity': 50,
      'balance': 58,
      'date': '2024-01-15 14:15',
      'type': 'Purchase',
      'location': 'Main Warehouse',
      'user': 'Procurement'
    },
  ];

  // Show a dialog with recent stock movements
  void _showStockMovements() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stock Movements', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _stockMovements.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final mv = _stockMovements[index];
              final qty = mv['quantity'] as num;
              final qtyText = qty < 0 ? qty.toString() : '+${qty.toString()}';
              final qtyColor = qty < 0 ? Colors.red : Colors.green;
              return ListTile(
                leading: Icon(Icons.swap_horiz, color: AppColors.primaryColor),
                title: Text('${mv['product']}', style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('${mv['reference']} • ${mv['date']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(qtyText, style: TextStyle(fontFamily: 'Cairo', color: qtyColor, fontWeight: FontWeight.bold)),
                    Text('Bal: ${mv['balance']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  ],
                ),
                onTap: () => _showStockMovementDetails(mv),
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
      ),
    );
  }

  // Show detailed info for a single stock movement
  void _showStockMovementDetails(Map<String, dynamic> movement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Movement Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID', movement['id']),
              _buildDetailRow('Product', movement['product']),
              _buildDetailRow('Reference', movement['reference']),
              _buildDetailRow('Quantity', movement['quantity'].toString()),
              _buildDetailRow('Balance', movement['balance'].toString()),
              _buildDetailRow('Date', movement['date']),
              _buildDetailRow('Type', movement['type']),
              _buildDetailRow('Location', movement['location']),
              if (movement['user'] != null) _buildDetailRow('User', movement['user']),
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

  final List<Map<String, dynamic>> _lowStockAlerts = [
    {
      'product': 'A4 Paper Pack',
      'product_id': 'P003',
      'current_stock': 8,
      'min_stock': 20,
      'status': 'Critical',
      'last_ordered': '2024-01-10',
      'vendor': 'PaperCo',
      'urgency': 'High'
    },
    {
      'product': 'Wireless Mouse',
      'product_id': 'P004',
      'current_stock': 10,
      'min_stock': 15,
      'status': 'Warning',
      'last_ordered': '2024-01-08',
      'vendor': 'TechSupplies',
      'urgency': 'Medium'
    },
  ];

  final List<Map<String, dynamic>> _purchaseOrders = [
    {
      'id': 'PO001',
      'reference': 'PO-2024-001',
      'vendor': 'PaperCo',
      'product': 'A4 Paper Pack',
      'product_id': 'P003',
      'quantity': 200,
      'unit_price': 15.0,
      'total': 3000.0,
      'status': 'Draft',
      'expected_date': '2024-01-25',
      'created_date': '2024-01-15'
    },
    {
      'id': 'PO002',
      'reference': 'PO-2024-002',
      'vendor': 'TechSupplies',
      'product': 'Wireless Mouse',
      'product_id': 'P004',
      'quantity': 100,
      'unit_price': 25.0,
      'total': 2500.0,
      'status': 'Received',
      'expected_date': '2024-01-18',
      'created_date': '2024-01-10'
    },
  ];

  final List<Map<String, dynamic>> _lotsSerials = [
    {
      'lot_number': 'LOT-2024-001',
      'product': 'A4 Paper Pack',
      'product_id': 'P003',
      'quantity': 500,
      'expiry_date': '2025-12-31',
      'location': 'Main Warehouse',
      'status': 'Active',
      'manufacture_date': '2024-01-01'
    },
    {
      'serial_number': 'SN-DLXPS13-001',
      'product': 'Laptop Dell XPS 13',
      'product_id': 'P001',
      'location': 'Main Warehouse',
      'status': 'In Stock',
      'purchase_date': '2024-01-10',
      'warranty_expiry': '2026-01-10'
    },
  ];

  final List<Map<String, dynamic>> _inventoryAdjustments = [
    {
      'id': 'ADJ001',
      'reference': 'ADJ-2024-001',
      'product': 'Office Chair Ergonomic',
      'product_id': 'P002',
      'quantity': -1,
      'reason': 'Damaged during handling',
      'date': '2024-01-16',
      'status': 'Approved',
      'approved_by': 'Warehouse Manager',
      'location': 'Main Warehouse'
    },
  ];

  final List<Map<String, dynamic>> _scrapReturns = [
    {
      'id': 'SCR001',
      'reference': 'SCR-2024-001',
      'product': 'Office Chair Ergonomic',
      'product_id': 'P002',
      'quantity': 1,
      'reason': 'Damaged beyond repair',
      'date': '2024-01-16',
      'type': 'Scrap',
      'status': 'Completed',
      'location': 'Main Warehouse'
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
              _buildDetailRow('SKU', product['sku']),
              _buildDetailRow('Category', product['category']),
              _buildDetailRow('Unit of Measure', product['uom']),
              _buildDetailRow('Cost', '\$${product['cost']}'),
              _buildDetailRow('Sale Price', '\$${product['sale_price']}'),
              _buildDetailRow('Current Stock', '${product['quantity']} ${product['uom']}'),
              _buildDetailRow('Min Stock', product['min_stock'].toString()),
              _buildDetailRow('Max Stock', product['max_stock'].toString()),
              _buildDetailRow('Product Type', product['type']),
              _buildDetailRow('Vendor', product['vendor']),
              _buildDetailRow('Tracking', product['tracking']),
              if (product['barcode'] != null) _buildDetailRow('Barcode', product['barcode']),
              if (product['weight'] != null) _buildDetailRow('Weight', '${product['weight']} kg'),
              if (product['dimensions'] != null) _buildDetailRow('Dimensions', product['dimensions']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _editProduct(product),
            child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _editProduct(Map<String, dynamic> product) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AddProductDialog(
        product: product,
        onProductAdded: (updatedProduct) {
          setState(() {
            final index = _products.indexWhere((p) => p['id'] == product['id']);
            if (index != -1) {
              _products[index] = {..._products[index], ...updatedProduct};
            }
          });
        },
      ),
    );
  }

  void _deleteProduct(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Product', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to delete ${product['name']}?', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _products.removeWhere((p) => p['id'] == product['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product deleted successfully', style: TextStyle(fontFamily: 'Cairo'))),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => AddProductDialog(
        onProductAdded: (product) {
          setState(() {
            _products.add(product);
          });
        },
      ),
    );
  }

  void _showWarehouseDetails(Map<String, dynamic> warehouse) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Warehouse Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Warehouse ID', warehouse['id']),
              _buildDetailRow('Name', warehouse['name']),
              _buildDetailRow('Location', warehouse['location']),
              _buildDetailRow('Type', warehouse['type']),
              _buildDetailRow('Capacity', '${warehouse['capacity']} sqm'),
              _buildDetailRow('Used Capacity', '${warehouse['used_capacity']} sqm'),
              _buildDetailRow('Available', '${warehouse['capacity'] - warehouse['used_capacity']} sqm'),
              _buildDetailRow('Manager', warehouse['manager']),
              _buildDetailRow('Status', warehouse['status']),
              if (warehouse['contact'] != null) _buildDetailRow('Contact', warehouse['contact']),
              if (warehouse['address'] != null) _buildDetailRow('Address', warehouse['address']),
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

  void _showInventoryTransfer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => InventoryTransferForm(
        onTransferCreated: (transfer) {
          setState(() {
            _inventoryTransfers.insert(0, transfer);
          });
        },
        products: _products,
        warehouses: _warehouses,
      ),
    );
  }

  void _showReceiveItems() {
    showDialog(
      context: context,
      builder: (context) => ReceiveItemsDialog(
        onItemsReceived: (receipt) {
          setState(() {
            _inventoryTransfers.insert(0, receipt);
            final productIndex = _products.indexWhere((p) => p['id'] == receipt['product_id']);
            if (productIndex != -1) {
              _products[productIndex]['quantity'] += receipt['quantity'];
            }
          });
        },
        products: _products,
        warehouses: _warehouses,
      ),
    );
  }

  void _showAdjustStock() {
    showDialog(
      context: context,
      builder: (context) => StockAdjustmentDialog(
        onAdjustmentCreated: (adjustment) {
          setState(() {
            _inventoryAdjustments.add(adjustment);
            final productIndex = _products.indexWhere((p) => p['name'] == adjustment['product']);
            if (productIndex != -1) {
              _products[productIndex]['quantity'] += adjustment['quantity'];
            }
          });
        },
        products: _products,
      ),
    );
  }

  void _createPurchaseOrder(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => CreatePurchaseOrderDialog(
        alert: alert,
        onPurchaseOrderCreated: (purchaseOrder) {
          setState(() {
            _purchaseOrders.add(purchaseOrder);
          });
        },
      ),
    );
  }

  void _showBarcodeScanner() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Barcode Scanner', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 64, color: AppColors.primaryColor),
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Barcode scanned successfully!', style: TextStyle(fontFamily: 'Cairo')),
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

  void _showScrapReturnDialog() {
    showDialog(
      context: context,
      builder: (context) => ScrapReturnDialog(
        onScrapReturnCreated: (record) {
          setState(() {
            _scrapReturns.add(record);
          });
        },
        products: _products,
        warehouses: _warehouses,
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
      case 'Completed': case 'Approved': case 'Received': return Colors.green;
      case 'In Progress': case 'Confirmed': return Colors.blue;
      case 'Pending': case 'Draft': return Colors.orange;
      case 'Critical': return Colors.red;
      case 'Warning': return Colors.orange;
      default: return Colors.grey;
    }
  }

  // Filtered data based on search
  List<Map<String, dynamic>> get _filteredProducts {
    if (_searchQuery.isEmpty) return _products;
    return _products.where((product) =>
      product['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      product['sku'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      product['category'].toLowerCase().contains(_searchQuery.toLowerCase())
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
          'Materials & Warehouses',
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
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: AppColors.primaryColor),
            onPressed: _showStockMovements,
            tooltip: 'Stock Movements',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.primaryColor.withOpacity(0.5),
          indicatorColor: AppColors.primaryColor,
          tabs: const [
            Tab(text: 'Dashboard'),
            Tab(text: 'Products'),
            Tab(text: 'Warehouses'),
            Tab(text: 'Transfers'),
            Tab(text: 'Purchasing'),
            Tab(text: 'Tracking'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildProductsTab(),
          _buildWarehousesTab(),
          _buildTransfersTab(),
          _buildPurchasingTab(),
          _buildTrackingTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    final totalProducts = _products.length;
    final totalWarehouses = _warehouses.length;
    final totalValue = _products.map((p) => p['cost'] * p['quantity']).reduce((a, b) => a + b);
    final criticalAlerts = _lowStockAlerts.where((alert) => alert['status'] == 'Critical').length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
         Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildStatCard('Total Products', totalProducts.toString(), Colors.blue, Icons.inventory),
              SizedBox(width: 10),
              _buildStatCard('Total Warehouses', totalWarehouses.toString(), Colors.green, Icons.warehouse),
              SizedBox(height: 10),
               _buildStatCard('Inventory Value', '\$${totalValue.toStringAsFixed(0)}', Colors.orange, Icons.attach_money),
              SizedBox(width: 10),
              _buildStatCard('Critical Alerts', criticalAlerts.toString(), Colors.red, Icons.warning),
              SizedBox(height: 10),
            ],
          ),

          // Quick Actions
          Text('Quick Actions', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton('Add Product', Icons.add_box, Colors.blue, _showAddProductDialog),
              _buildActionButton('Receive Items', Icons.move_to_inbox, Colors.green, _showReceiveItems),
              _buildActionButton('Transfer', Icons.swap_horiz, Colors.orange, _showInventoryTransfer),
              _buildActionButton('Adjust Stock', Icons.adjust, Colors.purple, _showAdjustStock),
              _buildActionButton('Scan Barcode', Icons.qr_code_scanner, Colors.teal, _showBarcodeScanner),
              _buildActionButton('Scrap/Return', Icons.delete_outline, Colors.red, _showScrapReturnDialog),
            ],
          ),

          // Low Stock Alerts
          SizedBox(height: 20),
          _buildLowStockAlerts(),

          // Recent Transfers
          SizedBox(height: 20),
          _buildRecentTransfers(),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
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
                    hintText: 'Search products...',
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
                onPressed: _showProductFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];
              final stockStatus = product['quantity'] <= product['min_stock'] ? 'Low' : 'Good';

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: Icon(Icons.inventory_2, color: AppColors.primaryColor),
                  title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${product['category']} • SKU: ${product['sku']}', style: TextStyle(fontFamily: 'Cairo')),
                      SizedBox(height: 4),
                      Text(
                        'Status: $stockStatus',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: stockStatus == 'Low' ? Colors.red : Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('View Details', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showProductDetails(product),
                      ),
                      PopupMenuItem(
                        child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _editProduct(product),
                      ),
                      PopupMenuItem(
                        child: Text('Delete', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _deleteProduct(product),
                      ),
                    ],
                  ),
                  onTap: () => _showProductDetails(product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWarehousesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ..._warehouses.map((warehouse) => Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.warehouse, color: AppColors.primaryColor),
            title: Text(warehouse['name'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Text(warehouse['location'], style: TextStyle(fontFamily: 'Cairo')),
            trailing: Chip(
              label: Text(warehouse['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
              backgroundColor: warehouse['status'] == 'Active' ? Colors.green : Colors.orange,
            ),
            onTap: () => _showWarehouseDetails(warehouse),
          ),
        )),
      ],
    );
  }

  Widget _buildTransfersTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ..._inventoryTransfers.map((transfer) => Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              transfer['type'] == 'Internal Transfer' ? Icons.swap_horiz : 
              transfer['type'] == 'Receipt' ? Icons.move_to_inbox : Icons.local_shipping,
              color: AppColors.primaryColor
            ),
            title: Text(transfer['reference'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${transfer['product']} • Qty: ${transfer['quantity']}', style: TextStyle(fontFamily: 'Cairo')),
                Text('${transfer['from_location']} → ${transfer['to_location']}', 
                     style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
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

  Widget _buildPurchasingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Purchase Orders', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._purchaseOrders.map((po) => Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.shopping_cart, color: AppColors.primaryColor),
              title: Text(po['reference'], style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${po['product']} • Qty: ${po['quantity']}', style: TextStyle(fontFamily: 'Cairo')),
                  Text('Vendor: ${po['vendor']} • Total: \$${po['total']}', 
                       style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                ],
              ),
              trailing: Chip(
                label: Text(po['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                backgroundColor: _getStatusColor(po['status']),
              ),
            ),
          )),
          SizedBox(height: 20),
          Text('Low Stock Alerts', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._lowStockAlerts.map((alert) => Card(
            color: alert['status'] == 'Critical' ? Colors.red[50] : Colors.orange[50],
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.warning, color: alert['status'] == 'Critical' ? Colors.red : Colors.orange),
              title: Text(alert['product'], style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Text('Current: ${alert['current_stock']} • Min: ${alert['min_stock']}', 
                           style: TextStyle(fontFamily: 'Cairo')),
              trailing: ElevatedButton(
                onPressed: () => _createPurchaseOrder(alert),
                child: Text('Order', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lot/Serial Tracking', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._lotsSerials.map((tracking) => Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.confirmation_number, color: AppColors.primaryColor),
              title: Text(tracking['lot_number'] ?? tracking['serial_number'], style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tracking['product'], style: TextStyle(fontFamily: 'Cairo')),
                  if (tracking['expiry_date'] != null)
                    Text('Expires: ${tracking['expiry_date']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                  if (tracking['quantity'] != null)
                    Text('Quantity: ${tracking['quantity']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                ],
              ),
              trailing: Chip(
                label: Text(tracking['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                backgroundColor: tracking['status'] == 'Active' ? Colors.green : Colors.blue,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 1: // Products
        return FloatingActionButton(
          onPressed: _showAddProductDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 2: // Warehouses
        return FloatingActionButton(
          onPressed: () {}, // Add warehouse functionality
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add_business, color: Colors.white),
        );
      case 3: // Transfers
        return FloatingActionButton(
          onPressed: _showInventoryTransfer,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.swap_horiz, color: Colors.white),
        );
      case 4: // Purchasing
        return FloatingActionButton(
          onPressed: () => _createPurchaseOrder(_lowStockAlerts.first),
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.shopping_cart, color: Colors.white),
        );
      case 5: // Tracking
        return FloatingActionButton(
          onPressed: _showBarcodeScanner,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.qr_code_scanner, color: Colors.white),
        );
      default: // Dashboard
        return FloatingActionButton(
          onPressed: _showReceiveItems,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.move_to_inbox, color: Colors.white),
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

  Widget _buildLowStockAlerts() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: 8),
                Text('Low Stock Alerts', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 12),
            ..._lowStockAlerts.map((alert) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(alert['product'], style: TextStyle(fontFamily: 'Cairo')),
                    Text('${alert['current_stock']}/${alert['min_stock']}', 
                         style: TextStyle(fontFamily: 'Cairo', color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: alert['current_stock'] / alert['min_stock'],
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    alert['current_stock'] / alert['min_stock'] < 0.5 ? Colors.red : Colors.orange
                  ),
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
            ..._inventoryTransfers.take(3).map((transfer) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transfer['reference'], style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500)),
                          SizedBox(height: 2),
                          Text('${transfer['product']} • Qty: ${transfer['quantity']}', 
                               style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
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

  void _showProductFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Products', style: TextStyle(fontFamily: 'Cairo')),
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
class AddProductDialog extends StatefulWidget {
  final Map<String, dynamic>? product;
  final Function(Map<String, dynamic>) onProductAdded;

  const AddProductDialog({super.key, this.product, required this.onProductAdded});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _categoryController = TextEditingController();
  final _costController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _minStockController = TextEditingController();
  final _maxStockController = TextEditingController();
  final _vendorController = TextEditingController();
  String _selectedType = 'Storable';
  String _selectedTracking = 'None';
  String _selectedUOM = 'Unit';

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!['name'];
      _skuController.text = widget.product!['sku'];
      _categoryController.text = widget.product!['category'];
      _costController.text = widget.product!['cost'].toString();
      _priceController.text = widget.product!['sale_price'].toString();
      _quantityController.text = widget.product!['quantity'].toString();
      _minStockController.text = widget.product!['min_stock'].toString();
      _maxStockController.text = widget.product!['max_stock'].toString();
      _vendorController.text = widget.product!['vendor'];
      _selectedType = widget.product!['type'];
      _selectedTracking = widget.product!['tracking'];
      _selectedUOM = widget.product!['uom'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add New Product' : 'Edit Product', 
                style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Please enter name' : null,
              ),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(labelText: 'SKU'),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Sale Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _minStockController,
                decoration: InputDecoration(labelText: 'Min Stock'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _maxStockController,
                decoration: InputDecoration(labelText: 'Max Stock'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _vendorController,
                decoration: InputDecoration(labelText: 'Vendor'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedType,
                items: ['Storable', 'Consumable', 'Service']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(labelText: 'Product Type'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedTracking,
                items: ['None', 'Lot', 'Serial']
                    .map((tracking) => DropdownMenuItem(value: tracking, child: Text(tracking)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedTracking = value!),
                decoration: InputDecoration(labelText: 'Tracking'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedUOM,
                items: ['Unit', 'Pack', 'Box', 'Pallet', 'Kg', 'Liter']
                    .map((uom) => DropdownMenuItem(value: uom, child: Text(uom)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedUOM = value!),
                decoration: InputDecoration(labelText: 'Unit of Measure'),
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
              widget.onProductAdded({
                'id': widget.product?['id'] ?? 'P${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'sku': _skuController.text,
                'category': _categoryController.text,
                'uom': _selectedUOM,
                'cost': double.parse(_costController.text),
                'sale_price': double.parse(_priceController.text),
                'quantity': int.parse(_quantityController.text),
                'min_stock': int.parse(_minStockController.text),
                'max_stock': int.parse(_maxStockController.text),
                'type': _selectedType,
                'vendor': _vendorController.text.isEmpty ? 'Default Vendor' : _vendorController.text,
                'tracking': _selectedTracking,
              });
              Navigator.pop(context);
            }
          },
          child: Text(widget.product == null ? 'Add Product' : 'Update Product', 
                    style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class InventoryTransferForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onTransferCreated;
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> warehouses;

  const InventoryTransferForm({
    super.key,
    required this.onTransferCreated,
    required this.products,
    required this.warehouses,
  });

  @override
  State<InventoryTransferForm> createState() => _InventoryTransferFormState();
}

class _InventoryTransferFormState extends State<InventoryTransferForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProduct;
  String? _selectedFromLocation;
  String? _selectedToLocation;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _selectedType = 'Internal Transfer';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Create Transfer', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  initialValue: _selectedType,
                  items: ['Internal Transfer', 'Receipt', 'Delivery'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                  decoration: InputDecoration(labelText: 'Transfer Type'),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: _selectedProduct,
                  items: widget.products.map((product) {
                    return DropdownMenuItem(
                      value: product['id'],
                      child: Text('${product['name']} (${product['sku']})'),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                  decoration: InputDecoration(labelText: 'Product'),
                  validator: (value) => value == null ? 'Required' : null,
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: _selectedFromLocation,
                  items: widget.warehouses.map((warehouse) {
                    return DropdownMenuItem(
                      value: warehouse['id'],
                      child: Text(warehouse['name']),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedFromLocation = value! as String?),
                  decoration: InputDecoration(labelText: 'From Location'),
                  validator: (value) => value == null ? 'Required' : null,
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: _selectedToLocation,
                  items: widget.warehouses.map((warehouse) {
                    return DropdownMenuItem(
                      value: warehouse['id'],
                      child: Text(warehouse['name']),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedToLocation = value! as String?),
                  decoration: InputDecoration(labelText: 'To Location'),
                  validator: (value) => value == null ? 'Required' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(labelText: 'Notes (Optional)'),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final product = widget.products.firstWhere((p) => p['id'] == _selectedProduct);
                final fromLocation = widget.warehouses.firstWhere((w) => w['id'] == _selectedFromLocation);
                final toLocation = widget.warehouses.firstWhere((w) => w['id'] == _selectedToLocation);
                
                final transfer = {
                  'id': 'TR${DateTime.now().millisecondsSinceEpoch}',
                  'reference': '${_selectedType == 'Receipt' ? 'REC' : _selectedType == 'Delivery' ? 'DEL' : 'TRF'}/${DateTime.now().year}/${DateTime.now().millisecondsSinceEpoch}',
                  'from_location': fromLocation['name'],
                  'to_location': toLocation['name'],
                  'product': product['name'],
                  'product_id': product['id'],
                  'quantity': int.parse(_quantityController.text),
                  'status': 'Pending',
                  'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                  'type': _selectedType,
                  'notes': _notesController.text.isEmpty ? null : _notesController.text,
                };
                widget.onTransferCreated(transfer);
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Transfer created successfully!', style: TextStyle(fontFamily: 'Cairo')),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: Text('Create Transfer', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}

class ReceiveItemsDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onItemsReceived;
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> warehouses;

  const ReceiveItemsDialog({
    super.key,
    required this.onItemsReceived,
    required this.products,
    required this.warehouses,
  });

  @override
  State<ReceiveItemsDialog> createState() => _ReceiveItemsDialogState();
}

class _ReceiveItemsDialogState extends State<ReceiveItemsDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProduct;
  String? _selectedWarehouse;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _purchaseOrderController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Receive Items', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                initialValue: _selectedProduct,
                items: widget.products.map((product) {
                  return DropdownMenuItem(
                    value: product['id'],
                    child: Text('${product['name']} (${product['sku']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                decoration: InputDecoration(labelText: 'Product'),
                validator: (value) => value == null ? 'Required' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedWarehouse,
                items: widget.warehouses.map((warehouse) {
                  return DropdownMenuItem(
                    value: warehouse['id'],
                    child: Text(warehouse['name']),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedWarehouse = value! as String?),
                decoration: InputDecoration(labelText: 'Warehouse'),
                validator: (value) => value == null ? 'Required' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _purchaseOrderController,
                decoration: InputDecoration(labelText: 'Purchase Order (Optional)'),
              ),
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
              final product = widget.products.firstWhere((p) => p['id'] == _selectedProduct);
              final warehouse = widget.warehouses.firstWhere((w) => w['id'] == _selectedWarehouse);
              
              final receipt = {
                'id': 'REC${DateTime.now().millisecondsSinceEpoch}',
                'reference': 'REC/${DateTime.now().year}/${DateTime.now().millisecondsSinceEpoch}',
                'from_location': 'Vendor Location',
                'to_location': warehouse['name'],
                'product': product['name'],
                'product_id': product['id'],
                'quantity': int.parse(_quantityController.text),
                'status': 'Completed',
                'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                'type': 'Receipt',
                'purchase_order': _purchaseOrderController.text.isEmpty ? null : _purchaseOrderController.text,
                'notes': _notesController.text.isEmpty ? null : _notesController.text,
              };
              widget.onItemsReceived(receipt);
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Items received successfully!', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: Text('Receive Items', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class StockAdjustmentDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdjustmentCreated;
  final List<Map<String, dynamic>> products;

  const StockAdjustmentDialog({
    super.key,
    required this.onAdjustmentCreated,
    required this.products,
  });

  @override
  State<StockAdjustmentDialog> createState() => _StockAdjustmentDialogState();
}

class _StockAdjustmentDialogState extends State<StockAdjustmentDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProduct;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  String _adjustmentType = 'Increase';
  String _selectedReason = 'Damaged';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stock Adjustment', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                initialValue: _selectedProduct,
                items: widget.products.map((product) {
                  return DropdownMenuItem(
                    value: product['id'],
                    child: Text('${product['name']} (Current: ${product['quantity']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                decoration: InputDecoration(labelText: 'Product'),
                validator: (value) => value == null ? 'Required' : null,
              ),
              DropdownButtonFormField(
                initialValue: _adjustmentType,
                items: ['Increase', 'Decrease'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => _adjustmentType = value!),
                decoration: InputDecoration(labelText: 'Adjustment Type'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedReason,
                items: ['Damaged', 'Found', 'Counting Error', 'Theft', 'Other'].map((reason) {
                  return DropdownMenuItem(value: reason, child: Text(reason));
                }).toList(),
                onChanged: (value) => setState(() => _selectedReason = value!),
                decoration: InputDecoration(labelText: 'Reason'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: 'Additional Details (Optional)'),
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
              final product = widget.products.firstWhere((p) => p['id'] == _selectedProduct);
              final quantity = int.parse(_quantityController.text);
              final adjustedQuantity = _adjustmentType == 'Increase' ? quantity : -quantity;
              final reason = _selectedReason == 'Other' ? _reasonController.text : _selectedReason;
              
              final adjustment = {
                'id': 'ADJ${DateTime.now().millisecondsSinceEpoch}',
                'reference': 'ADJ/${DateTime.now().year}/${DateTime.now().millisecondsSinceEpoch}',
                'product': product['name'],
                'product_id': product['id'],
                'quantity': adjustedQuantity,
                'reason': reason,
                'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                'status': 'Approved',
                'approved_by': 'System',
                'location': 'Main Warehouse',
              };
              widget.onAdjustmentCreated(adjustment);
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Stock adjustment created successfully!', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: Text('Adjust Stock', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class CreatePurchaseOrderDialog extends StatefulWidget {
  final Map<String, dynamic> alert;
  final Function(Map<String, dynamic>) onPurchaseOrderCreated;

  const CreatePurchaseOrderDialog({
    super.key,
    required this.alert,
    required this.onPurchaseOrderCreated,
  });

  @override
  State<CreatePurchaseOrderDialog> createState() => _CreatePurchaseOrderDialogState();
}

class _CreatePurchaseOrderDialogState extends State<CreatePurchaseOrderDialog> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final suggestedQty = widget.alert['min_stock'] * 2 - widget.alert['current_stock'];
    _quantityController.text = suggestedQty.toString();
    _unitPriceController.text = '15.0'; // Default price
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Purchase Order', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.inventory_2),
              title: Text('Product: ${widget.alert['product']}', style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Text('Vendor: ${widget.alert['vendor']}', style: TextStyle(fontFamily: 'Cairo')),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _unitPriceController,
              decoration: InputDecoration(labelText: 'Unit Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes (Optional)'),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: () {
            final quantity = int.parse(_quantityController.text);
            final unitPrice = double.parse(_unitPriceController.text);
            final total = quantity * unitPrice;
            
            final purchaseOrder = {
              'id': 'PO${DateTime.now().millisecondsSinceEpoch}',
              'reference': 'PO/${DateTime.now().year}/${DateTime.now().millisecondsSinceEpoch}',
              'vendor': widget.alert['vendor'],
              'product': widget.alert['product'],
              'product_id': widget.alert['product_id'],
              'quantity': quantity,
              'unit_price': unitPrice,
              'total': total,
              'status': 'Draft',
              'expected_date': '${DateTime.now().add(Duration(days: 7)).year}-${DateTime.now().add(Duration(days: 7)).month.toString().padLeft(2, '0')}-${DateTime.now().add(Duration(days: 7)).day.toString().padLeft(2, '0')}',
              'created_date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
              'notes': _notesController.text.isEmpty ? null : _notesController.text,
            };
            widget.onPurchaseOrderCreated(purchaseOrder);
            Navigator.pop(context);
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Purchase order created successfully!', style: TextStyle(fontFamily: 'Cairo')),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Text('Create PO', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class ScrapReturnDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onScrapReturnCreated;
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> warehouses;

  const ScrapReturnDialog({
    super.key,
    required this.onScrapReturnCreated,
    required this.products,
    required this.warehouses,
  });

  @override
  State<ScrapReturnDialog> createState() => _ScrapReturnDialogState();
}

class _ScrapReturnDialogState extends State<ScrapReturnDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProduct;
  String? _selectedWarehouse;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  String _selectedType = 'Scrap';
  String _selectedStatus = 'Pending Inspection';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Scrap/Return Management', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                initialValue: _selectedType,
                items: ['Scrap', 'Return'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(labelText: 'Type'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedStatus,
                items: ['Pending Inspection', 'Approved', 'Completed'].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
                decoration: InputDecoration(labelText: 'Status'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedProduct,
                items: widget.products.map((product) {
                  return DropdownMenuItem(
                    value: product['id'],
                    child: Text('${product['name']} (${product['sku']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                decoration: InputDecoration(labelText: 'Product'),
                validator: (value) => value == null ? 'Required' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedWarehouse,
                items: widget.warehouses.map((warehouse) {
                  return DropdownMenuItem(
                    value: warehouse['id'],
                    child: Text(warehouse['name']),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedWarehouse = value! as String?),
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) => value == null ? 'Required' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: 'Reason'),
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
              final product = widget.products.firstWhere((p) => p['id'] == _selectedProduct);
              final warehouse = widget.warehouses.firstWhere((w) => w['id'] == _selectedWarehouse);
              
              final record = {
                'id': '${_selectedType == 'Scrap' ? 'SCR' : 'RET'}${DateTime.now().millisecondsSinceEpoch}',
                'reference': '${_selectedType == 'Scrap' ? 'SCR' : 'RET'}/${DateTime.now().year}/${DateTime.now().millisecondsSinceEpoch}',
                'product': product['name'],
                'product_id': product['id'],
                'quantity': int.parse(_quantityController.text),
                'reason': _reasonController.text,
                'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                'type': _selectedType,
                'status': _selectedStatus,
                'location': warehouse['name'],
              };
              widget.onScrapReturnCreated(record);
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$_selectedType record created successfully!', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: Text('Create Record', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}