import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class InventoryPage extends StatefulWidget {
  final UserModel? user;
  
  const InventoryPage({super.key, this.user});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  String _barcodeResult = 'No barcode scanned';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showAdvancedFilters = false;
  Map<String, dynamic>? _selectedProduct;
  bool _showLocationView = false;
  
  // Dashboard Data
  double _totalStockValue = 125489.75;
  int _lowStockItems = 12;
  int _outOfStockItems = 5;
  final int _incomingShipments = 8;
  final int _topSellingItems = 15;

  // Last Scanned Barcode Card
  Widget _buildLastScannedBarcode() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Last Scanned Barcode', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(_barcodeResult, style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
          ],
        ),
      ),
    );
  }
  
  // Sample Inventory Data
  final List<Map<String, dynamic>> _products = [
    {
      'id': 'PROD001',
      'sku': 'SKU-001',
      'name': 'iPhone 14 Pro',
      'category': 'Electronics',
      'brand': 'Apple',
      'description': 'Latest iPhone model with advanced camera',
      'quantity': 25,
      'reserved': 5,
      'available': 20,
      'minQuantity': 5,
      'maxQuantity': 50,
      'price': 999.99,
      'cost': 850.00,
      'location': 'WH-01-A1-B2',
      'warehouse': 'Main Warehouse',
      'supplier': 'Apple Inc.',
      'image': 'assets/iphone.jpg',
      'status': 'Available',
      'lastUpdated': '2024-01-15',
      'barcode': '123456789012',
      'unit': 'Piece',
      'expiryDate': null,
      'batchNumber': 'BATCH001',
      'serialNumbers': ['SN001', 'SN002', 'SN003'],
      'movementHistory': [
        {'date': '2024-01-15', 'type': 'Purchase', 'quantity': 10, 'from': 'Supplier', 'to': 'Main Warehouse'},
        {'date': '2024-01-10', 'type': 'Sale', 'quantity': -2, 'from': 'Main Warehouse', 'to': 'Customer'},
      ]
    },
    {
      'id': 'PROD002',
      'sku': 'SKU-002',
      'name': 'MacBook Air M2',
      'category': 'Electronics',
      'brand': 'Apple',
      'description': 'Lightweight laptop with M2 chip',
      'quantity': 8,
      'reserved': 2,
      'available': 6,
      'minQuantity': 3,
      'maxQuantity': 20,
      'price': 1199.99,
      'cost': 1050.00,
      'location': 'WH-01-A2-B3',
      'warehouse': 'Main Warehouse',
      'supplier': 'Apple Inc.',
      'image': 'assets/macbook.jpg',
      'status': 'Low Stock',
      'lastUpdated': '2024-01-14',
      'barcode': '234567890123',
      'unit': 'Piece',
      'expiryDate': null,
      'batchNumber': 'BATCH002',
      'serialNumbers': ['SN101', 'SN102'],
      'movementHistory': [
        {'date': '2024-01-14', 'type': 'Purchase', 'quantity': 5, 'from': 'Supplier', 'to': 'Main Warehouse'},
        {'date': '2024-01-12', 'type': 'Sale', 'quantity': -3, 'from': 'Main Warehouse', 'to': 'Customer'},
      ]
    },
    {
      'id': 'PROD003',
      'sku': 'SKU-003',
      'name': 'Samsung Galaxy S23',
      'category': 'Electronics',
      'brand': 'Samsung',
      'description': 'Android flagship smartphone',
      'quantity': 0,
      'reserved': 0,
      'available': 0,
      'minQuantity': 10,
      'maxQuantity': 100,
      'price': 799.99,
      'cost': 700.00,
      'location': 'WH-01-B1-C2',
      'warehouse': 'Main Warehouse',
      'supplier': 'Samsung Electronics',
      'image': 'assets/galaxy.jpg',
      'status': 'Out of Stock',
      'lastUpdated': '2024-01-10',
      'barcode': '345678901234',
      'unit': 'Piece',
      'expiryDate': null,
      'batchNumber': 'BATCH003',
      'serialNumbers': [],
      'movementHistory': [
        {'date': '2024-01-10', 'type': 'Sale', 'quantity': -15, 'from': 'Main Warehouse', 'to': 'Customer'},
      ]
    },
    {
      'id': 'PROD004',
      'sku': 'SKU-004',
      'name': 'Dell XPS 13',
      'category': 'Electronics',
      'brand': 'Dell',
      'description': 'Premium business laptop',
      'quantity': 45,
      'reserved': 8,
      'available': 37,
      'minQuantity': 15,
      'maxQuantity': 100,
      'price': 1299.99,
      'cost': 1150.00,
      'location': 'WH-02-A1-B1',
      'warehouse': 'Warehouse 2',
      'supplier': 'Dell Technologies',
      'image': 'assets/dell.jpg',
      'status': 'Available',
      'lastUpdated': '2024-01-16',
      'barcode': '456789012345',
      'unit': 'Piece',
      'expiryDate': null,
      'batchNumber': 'BATCH004',
      'serialNumbers': ['SN201', 'SN202', 'SN203', 'SN204'],
      'movementHistory': [
        {'date': '2024-01-16', 'type': 'Purchase', 'quantity': 20, 'from': 'Supplier', 'to': 'Warehouse 2'},
        {'date': '2024-01-15', 'type': 'Transfer', 'quantity': 10, 'from': 'Main Warehouse', 'to': 'Warehouse 2'},
      ]
    },
    {
      'id': 'PROD005',
      'sku': 'SKU-005',
      'name': 'Logitech MX Master 3',
      'category': 'Accessories',
      'brand': 'Logitech',
      'description': 'Wireless mouse for professionals',
      'quantity': 3,
      'reserved': 1,
      'available': 2,
      'minQuantity': 10,
      'maxQuantity': 100,
      'price': 99.99,
      'cost': 75.00,
      'location': 'WH-01-C3-D1',
      'warehouse': 'Main Warehouse',
      'supplier': 'Logitech',
      'image': 'assets/mouse.jpg',
      'status': 'Low Stock',
      'lastUpdated': '2024-01-13',
      'barcode': '567890123456',
      'unit': 'Piece',
      'expiryDate': null,
      'batchNumber': 'BATCH005',
      'serialNumbers': ['SN301', 'SN302', 'SN303'],
      'movementHistory': [
        {'date': '2024-01-13', 'type': 'Adjustment', 'quantity': -7, 'from': 'Main Warehouse', 'to': 'Damaged'},
        {'date': '2024-01-12', 'type': 'Purchase', 'quantity': 10, 'from': 'Supplier', 'to': 'Main Warehouse'},
      ]
    },
  ];

  final List<Map<String, dynamic>> _warehouses = [
    {'id': 'WH-01', 'name': 'Main Warehouse', 'address': '123 Main St, City', 'capacity': 10000, 'used': 6500},
    {'id': 'WH-02', 'name': 'Warehouse 2', 'address': '456 Oak Ave, City', 'capacity': 8000, 'used': 4200},
    {'id': 'WH-03', 'name': 'Cold Storage', 'address': '789 Pine Rd, City', 'capacity': 5000, 'used': 2800},
  ];

  final List<Map<String, dynamic>> _movements = [
    {'id': 'MOV001', 'product': 'iPhone 14 Pro', 'type': 'Purchase', 'quantity': 10, 'from': 'Apple Inc.', 'to': 'Main Warehouse', 'date': '2024-01-15', 'user': 'John Doe'},
    {'id': 'MOV002', 'product': 'MacBook Air M2', 'type': 'Sale', 'quantity': -3, 'from': 'Main Warehouse', 'to': 'Customer', 'date': '2024-01-12', 'user': 'Jane Smith'},
    {'id': 'MOV003', 'product': 'Dell XPS 13', 'type': 'Transfer', 'quantity': 10, 'from': 'Main Warehouse', 'to': 'Warehouse 2', 'date': '2024-01-15', 'user': 'John Doe'},
    {'id': 'MOV004', 'product': 'Logitech MX Master 3', 'type': 'Adjustment', 'quantity': -7, 'from': 'Main Warehouse', 'to': 'Damaged', 'date': '2024-01-13', 'user': 'Mike Wilson'},
    {'id': 'MOV005', 'product': 'Samsung Galaxy S23', 'type': 'Sale', 'quantity': -15, 'from': 'Main Warehouse', 'to': 'Customer', 'date': '2024-01-10', 'user': 'Sarah Lee'},
  ];

  final List<Map<String, dynamic>> _purchaseOrders = [
    {'id': 'PO-001', 'supplier': 'Apple Inc.', 'product': 'iPhone 14 Pro', 'quantity': 50, 'orderedDate': '2024-01-20', 'expectedDate': '2024-01-25', 'status': 'Pending'},
    {'id': 'PO-002', 'supplier': 'Samsung Electronics', 'product': 'Samsung Galaxy S23', 'quantity': 100, 'orderedDate': '2024-01-18', 'expectedDate': '2024-01-23', 'status': 'In Transit'},
    {'id': 'PO-003', 'supplier': 'Logitech', 'product': 'Logitech MX Master 3', 'quantity': 50, 'orderedDate': '2024-01-22', 'expectedDate': '2024-01-27', 'status': 'Ordered'},
  ];

  final List<Map<String, dynamic>> _stockTransfers = [
    {'id': 'TRF-001', 'product': 'Dell XPS 13', 'from': 'Main Warehouse', 'to': 'Warehouse 2', 'quantity': 10, 'requestedDate': '2024-01-14', 'status': 'Completed'},
    {'id': 'TRF-002', 'product': 'iPhone 14 Pro', 'from': 'Main Warehouse', 'to': 'Showroom', 'quantity': 5, 'requestedDate': '2024-01-16', 'status': 'In Progress'},
    {'id': 'TRF-003', 'product': 'MacBook Air M2', 'from': 'Warehouse 2', 'to': 'Main Warehouse', 'quantity': 3, 'requestedDate': '2024-01-17', 'status': 'Pending'},
  ];

  // Filter states
  String _selectedCategory = 'All';
  String _selectedBrand = 'All';
  String _selectedWarehouse = 'All';
  String _selectedStatus = 'All';
  final List<String> _categories = ['All', 'Electronics', 'Accessories', 'Furniture', 'Clothing'];
  final List<String> _brands = ['All', 'Apple', 'Samsung', 'Dell', 'Logitech'];
  final List<String> _statuses = ['All', 'Available', 'Low Stock', 'Out of Stock'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _updateDashboard();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  void _updateDashboard() {
    // Calculate dashboard metrics
    int lowStock = 0;
    int outOfStock = 0;
    double totalValue = 0;
    
    for (var product in _products) {
      totalValue += product['quantity'] * product['cost'];
      if (product['quantity'] <= product['minQuantity']) {
        lowStock++;
      }
      if (product['quantity'] == 0) {
        outOfStock++;
      }
    }
    
    setState(() {
      _totalStockValue = totalValue;
      _lowStockItems = lowStock;
      _outOfStockItems = outOfStock;
    });
  }

  // Core Inventory Functions
  void _scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#${AppColors.primaryColor.value.toRadixString(16).substring(2)}',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      if (barcode != '-1') {
        setState(() {
          _barcodeResult = 'Scanned: $barcode';
        });
        
        // Find product with this barcode
        final product = _products.firstWhere(
          (p) => p['barcode'] == barcode,
          orElse: () => {},
        );
        
        if (product.isNotEmpty) {
          _showProductDetails(product);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Product not found for barcode: $barcode', style: TextStyle(fontFamily: 'Cairo')),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      print('Barcode scan error: $e');
    }
  }

  void _showProductDetails(Map<String, dynamic> product) {
    setState(() {
      _selectedProduct = product;
    });
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProductDetailSheet(
        product: product,
        onStockAdjusted: (adjustment) {
          _adjustStock(product, adjustment);
        },
        onTransferRequested: (transferDetails) {
          _requestStockTransfer(product, transferDetails);
        },
      ),
    );
  }

  void _adjustStock(Map<String, dynamic> product, Map<String, dynamic> adjustment) {
    final index = _products.indexWhere((p) => p['id'] == product['id']);
    if (index != -1) {
      setState(() {
        _products[index]['quantity'] += adjustment['quantity'];
        _products[index]['available'] = _products[index]['quantity'] - _products[index]['reserved'];
        
        // Update status based on new quantity
        if (_products[index]['quantity'] == 0) {
          _products[index]['status'] = 'Out of Stock';
        } else if (_products[index]['quantity'] <= _products[index]['minQuantity']) {
          _products[index]['status'] = 'Low Stock';
        } else {
          _products[index]['status'] = 'Available';
        }
        
        // Add to movement history
        _movements.insert(0, {
          'id': 'MOV${DateTime.now().millisecondsSinceEpoch}',
          'product': product['name'],
          'type': adjustment['type'],
          'quantity': adjustment['quantity'],
          'from': adjustment['from'],
          'to': adjustment['to'],
          'date': DateTime.now().toIso8601String().split('T')[0],
          'user': widget.user?.name ?? 'System',
          'reason': adjustment['reason'],
        });
      });
      
      _updateDashboard();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Stock adjusted successfully', style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _requestStockTransfer(Map<String, dynamic> product, Map<String, dynamic> transferDetails) {
    setState(() {
      _stockTransfers.insert(0, {
        'id': 'TRF-${DateTime.now().millisecondsSinceEpoch}',
        'product': product['name'],
        'from': transferDetails['from'],
        'to': transferDetails['to'],
        'quantity': transferDetails['quantity'],
        'requestedDate': DateTime.now().toIso8601String().split('T')[0],
        'status': 'Pending',
        'requestedBy': widget.user?.name ?? 'System',
      });
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transfer request submitted', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _createPurchaseOrder(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Purchase Order', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Product: ${product['name']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Current Stock: ${product['quantity']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Min Quantity: ${product['minQuantity']}', style: TextStyle(fontFamily: 'Cairo')),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Order Quantity',
                border: OutlineInputBorder(),
              ),
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
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _purchaseOrders.insert(0, {
                  'id': 'PO-${DateTime.now().millisecondsSinceEpoch}',
                  'supplier': product['supplier'],
                  'product': product['name'],
                  'quantity': 50, // This should come from form
                  'orderedDate': DateTime.now().toIso8601String().split('T')[0],
                  'expectedDate': DateTime.now().add(Duration(days: 7)).toIso8601String().split('T')[0],
                  'status': 'Ordered',
                });
              });
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Purchase order created', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Create PO', style: TextStyle(fontFamily: 'Cairo')),
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
          _updateDashboard();
        },
      ),
    );
  }

  void _showStockCount() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StockCountSheet(
        products: _products,
        onCountCompleted: (countResults) {
          _processStockCount(countResults);
        },
      ),
    );
  }

  void _processStockCount(List<Map<String, dynamic>> countResults) {
    for (var result in countResults) {
      final productIndex = _products.indexWhere((p) => p['id'] == result['productId']);
      if (productIndex != -1) {
        final adjustment = result['counted'] - _products[productIndex]['quantity'];
        if (adjustment != 0) {
          _adjustStock(_products[productIndex], {
            'quantity': adjustment,
            'type': 'Adjustment',
            'from': _products[productIndex]['warehouse'],
            'to': _products[productIndex]['warehouse'],
            'reason': 'Physical Count',
          });
        }
      }
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Stock count completed', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showWarehouseManagement() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => WarehouseManagementSheet(
        warehouses: _warehouses,
        onWarehouseUpdated: (updatedWarehouses) {
          setState(() {
            // Update warehouses
          });
        },
      ),
    );
  }

  void _toggleLocationView() {
    setState(() {
      _showLocationView = !_showLocationView;
    });
  }


  void _clearFilters() {
    setState(() {
      _selectedCategory = 'All';
      _selectedBrand = 'All';
      _selectedWarehouse = 'All';
      _selectedStatus = 'All';
      _searchQuery = '';
      _searchController.clear();
    });
  }

  // Filtered products
  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) {
      // Search filter
      if (_searchQuery.isNotEmpty &&
          !product['name'].toLowerCase().contains(_searchQuery.toLowerCase()) &&
          !product['sku'].toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      
      // Category filter
      if (_selectedCategory != 'All' && product['category'] != _selectedCategory) {
        return false;
      }
      
      // Brand filter
      if (_selectedBrand != 'All' && product['brand'] != _selectedBrand) {
        return false;
      }
      
      // Warehouse filter
      if (_selectedWarehouse != 'All' && product['warehouse'] != _selectedWarehouse) {
        return false;
      }
      
      // Status filter
      if (_selectedStatus != 'All') {
        if (_selectedStatus == 'Available' && product['status'] != 'Available') return false;
        if (_selectedStatus == 'Low Stock' && product['status'] != 'Low Stock') return false;
        if (_selectedStatus == 'Out of Stock' && product['status'] != 'Out of Stock') return false;
      }
      
      return true;
    }).toList();
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
          'Inventory Management',
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
            icon: Icon(Icons.qr_code_scanner, color: AppColors.primaryColor),
            onPressed: _scanBarcode,
            tooltip: 'Scan Barcode',
          ),
          IconButton(
            icon: Icon(_showLocationView ? Icons.list : Icons.location_on, color: AppColors.primaryColor),
            onPressed: _toggleLocationView,
            tooltip: _showLocationView ? 'List View' : 'Location View',
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
            Tab(text: 'Movements'),
            Tab(text: 'Warehouses'),
            Tab(text: 'Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildProductsTab(),
          _buildMovementsTab(),
          _buildWarehousesTab(),
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
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildStatCard('Total Stock Value', '\$${_totalStockValue.toStringAsFixed(2)}', Colors.blue, Icons.attach_money),
              _buildStatCard('Low Stock Items', _lowStockItems.toString(), Colors.orange, Icons.warning),
              _buildStatCard('Out of Stock', _outOfStockItems.toString(), Colors.red, Icons.error),
              _buildStatCard('Incoming Shipments', _incomingShipments.toString(), Colors.green, Icons.local_shipping),
              _buildStatCard('Top Selling Items', _topSellingItems.toString(), Colors.teal, Icons.trending_up),
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
              _buildActionButton('Scan Barcode', Icons.qr_code_scanner, Colors.blue, _scanBarcode),
              _buildActionButton('Stock Count', Icons.checklist, Colors.green, _showStockCount),
              _buildActionButton('Add Product', Icons.add_box, Colors.orange, _showAddProductDialog),
              _buildActionButton('Transfer Stock', Icons.compare_arrows, Colors.purple, () => _showTransferDialog()),
              _buildActionButton('Warehouses', Icons.warehouse, Colors.brown, _showWarehouseManagement),
              _buildActionButton('Reports', Icons.assessment, Colors.teal, () => _generateReport()),
            ],
          ),
          
          // Low Stock Alerts
          SizedBox(height: 20),
          _buildLowStockAlerts(),
          
          // Recent Movements
          SizedBox(height: 20),
          _buildRecentMovements(),
          
          // Last Scanned Barcode
          SizedBox(height: 20),
          _buildLastScannedBarcode(),

          // Top Products
          SizedBox(height: 20),
          _buildTopProducts(),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return Column(
      children: [
        // Search and Filter Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
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
                    onPressed: () {
                      setState(() {
                        _showAdvancedFilters = !_showAdvancedFilters;
                      });
                    },
                  ),
                ],
              ),
              
              // Advanced Filters
              if (_showAdvancedFilters) ...[
                SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Category', _selectedCategory, (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }, _categories),
                      SizedBox(width: 8),
                      _buildFilterChip('Brand', _selectedBrand, (value) {
                        setState(() {
                          _selectedBrand = value;
                        });
                      }, _brands),
                      SizedBox(width: 8),
                      _buildFilterChip('Warehouse', _selectedWarehouse, (value) {
                        setState(() {
                          _selectedWarehouse = value;
                        });
                      }, ['All', ..._warehouses.map((w) => w['name'])]),
                      SizedBox(width: 8),
                      _buildFilterChip('Status', _selectedStatus, (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      }, _statuses),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _clearFilters,
                      child: Text('Clear Filters', style: TextStyle(fontFamily: 'Cairo')),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        
        // Products List
        Expanded(
          child: _showLocationView ? _buildLocationView() : _buildProductsList(),
        ),
      ],
    );
  }

  Widget _buildProductsList() {
    if (_filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No products found', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
            if (_searchQuery.isNotEmpty || 
                _selectedCategory != 'All' || 
                _selectedBrand != 'All' ||
                _selectedStatus != 'All')
              TextButton(
                onPressed: _clearFilters,
                child: Text('Clear filters', style: TextStyle(fontFamily: 'Cairo')),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildLocationView() {
    // Group products by location
    final Map<String, List<Map<String, dynamic>>> productsByLocation = {};
    
    for (var product in _filteredProducts) {
      final location = product['location'] ?? 'Unknown';
      if (!productsByLocation.containsKey(location)) {
        productsByLocation[location] = [];
      }
      productsByLocation[location]!.add(product);
    }
    
    final locations = productsByLocation.keys.toList();
    
    if (locations.isEmpty) {
      return Center(
        child: Text('No products found', style: TextStyle(fontFamily: 'Cairo')),
      );
    }

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        final products = productsByLocation[location]!;
        
        return Card(
          margin: EdgeInsets.all(8),
          child: ExpansionTile(
            leading: Icon(Icons.location_on, color: AppColors.primaryColor),
            title: Text('Location: $location', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            subtitle: Text('${products.length} products', style: TextStyle(fontFamily: 'Cairo')),
            children: products.map((product) => 
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getStatusColor(product['status']).withOpacity(0.1),
                  child: Text(product['sku'].substring(0, 2), style: TextStyle(color: _getStatusColor(product['status']))),
                ),
                title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('Qty: ${product['quantity']}', style: TextStyle(fontFamily: 'Cairo')),
                trailing: Text(product['status'], style: TextStyle(
                  fontFamily: 'Cairo',
                  color: _getStatusColor(product['status']),
                  fontWeight: FontWeight.bold,
                )),
                onTap: () => _showProductDetails(product),
              )
            ).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMovementsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Movements', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () => _showAllMovements(),
                icon: Icon(Icons.history),
                label: Text('View All', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _movements.length,
            itemBuilder: (context, index) {
              final movement = _movements[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: Icon(
                    _getMovementIcon(movement['type']),
                    color: _getMovementColor(movement['type']),
                  ),
                  title: Text(movement['product'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${movement['type']} - ${movement['quantity']} units', style: TextStyle(fontFamily: 'Cairo')),
                      Text('${movement['from']} → ${movement['to']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                      Text('${movement['date']} by ${movement['user']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: movement['quantity'] > 0 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      movement['quantity'] > 0 ? '+${movement['quantity']}' : movement['quantity'].toString(),
                      style: TextStyle(
                        color: movement['quantity'] > 0 ? Colors.green : Colors.red,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWarehousesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Warehouses & Locations', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          
          // Warehouses
          ..._warehouses.map((warehouse) => _buildWarehouseCard(warehouse)),
          
          SizedBox(height: 20),
          
          // Stock by Warehouse
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stock Distribution', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  ..._warehouses.map((warehouse) {
                    final productsInWarehouse = _products.where((p) => p['warehouse'] == warehouse['name']).toList();
                    final totalQuantity = productsInWarehouse.fold(0, (sum, p) => sum + (p['quantity'] as int));
                    final percentage = (totalQuantity / warehouse['capacity']) * 100;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(warehouse['name'], style: TextStyle(fontFamily: 'Cairo')),
                              Text('$totalQuantity items', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: percentage / 100,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              percentage > 80 ? Colors.red :
                              percentage > 60 ? Colors.orange : Colors.green
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '$totalQuantity/${warehouse['capacity']} units (${percentage.toStringAsFixed(1)}%)',
                            style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inventory Reports', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          
          // Report Cards
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildReportCard('Stock Valuation', Icons.assessment, Colors.blue, () => _generateStockValuationReport()),
              _buildReportCard('Stock Aging', Icons.timeline, Colors.orange, () => _generateStockAgingReport()),
              _buildReportCard('Movement Report', Icons.compare_arrows, Colors.green, () => _generateMovementReport()),
              _buildReportCard('Low Stock Report', Icons.warning, Colors.red, () => _generateLowStockReport()),
              _buildReportCard('Expiry Report', Icons.calendar_today, Colors.purple, () => _generateExpiryReport()),
              _buildReportCard('Top Items', Icons.trending_up, Colors.teal, () => _generateTopItemsReport()),
            ],
          ),
          
          // Recent Reports
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recently Generated Reports', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  _buildReportItem('Stock Valuation - Jan 2024', 'Generated: Today', Icons.picture_as_pdf),
                  _buildReportItem('Low Stock Alert', 'Generated: Yesterday', Icons.picture_as_pdf),
                  _buildReportItem('Movement Report - Week 2', 'Generated: Jan 15', Icons.table_chart),
                ],
              ),
            ),
          ),
          
          // Export Options
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Export Options', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _exportToPDF(),
                          icon: Icon(Icons.picture_as_pdf),
                          label: Text('Export as PDF', style: TextStyle(fontFamily: 'Cairo')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _exportToExcel(),
                          icon: Icon(Icons.table_chart),
                          label: Text('Export as Excel', style: TextStyle(fontFamily: 'Cairo')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 0: // Dashboard
        return FloatingActionButton.extended(
          onPressed: _scanBarcode,
          backgroundColor: AppColors.primaryColor,
          icon: Icon(Icons.qr_code_scanner),
          label: Text('Scan', style: TextStyle(fontFamily: 'Cairo')),
        );
      case 1: // Products
        return FloatingActionButton(
          onPressed: _showAddProductDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 2: // Movements
        return FloatingActionButton(
          onPressed: () => _showAdjustmentDialog(),
          backgroundColor: Colors.orange,
          child: Icon(Icons.edit, color: Colors.white),
        );
      case 3: // Warehouses
        return FloatingActionButton(
          onPressed: _showWarehouseManagement,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add_location, color: Colors.white),
        );
      case 4: // Reports
        return FloatingActionButton(
          onPressed: () => _generateStockValuationReport(),
          backgroundColor: Colors.green,
          child: Icon(Icons.picture_as_pdf, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: _scanBarcode,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.qr_code_scanner, color: Colors.white),
        );
    }
  }

  // Helper Widgets
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(value, style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: color,
                  )),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600])),
          ],
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

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(product['status']).withOpacity(0.1),
          child: Icon(
            _getProductIcon(product['category']),
            color: _getStatusColor(product['status']),
          ),
        ),
        title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SKU: ${product['sku']} | ${product['category']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            Text('${product['warehouse']} - ${product['location']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 11)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${product['price'].toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getStatusColor(product['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${product['quantity']} units',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: _getStatusColor(product['status']),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onTap: () => _showProductDetails(product),
      ),
    );
  }

  Widget _buildWarehouseCard(Map<String, dynamic> warehouse) {
    final percentage = (warehouse['used'] / warehouse['capacity']) * 100;
    final productsInWarehouse = _products.where((p) => p['warehouse'] == warehouse['name']).toList();
    
    return Card(
      child: ListTile(
        leading: Icon(Icons.warehouse, color: AppColors.primaryColor),
        title: Text(warehouse['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(warehouse['address'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            SizedBox(height: 4),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                percentage > 80 ? Colors.red : 
                percentage > 60 ? Colors.orange : Colors.green
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${warehouse['used']}/${warehouse['capacity']} units (${percentage.toStringAsFixed(1)}%)',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 11),
            ),
          ],
        ),
        trailing: Chip(
          label: Text('${productsInWarehouse.length} items', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ),
    );
  }

  Widget _buildLowStockAlerts() {
    final lowStockProducts = _products.where((p) => p['status'] == 'Low Stock' || p['status'] == 'Out of Stock').toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Low Stock Alerts', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${lowStockProducts.length} alerts', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 12),
            ...lowStockProducts.take(3).map((product) => 
              ListTile(
                leading: Icon(Icons.warning, color: Colors.orange),
                title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('Current: ${product['quantity']} | Min: ${product['minQuantity']}', style: TextStyle(fontFamily: 'Cairo')),
                trailing: ElevatedButton(
                  onPressed: () => _createPurchaseOrder(product),
                  child: Text('Order', style: TextStyle(fontFamily: 'Cairo')),
                ),
              )
            ),
            if (lowStockProducts.isEmpty)
              Text('No low stock items', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentMovements() {
    final recentMovements = _movements.take(5).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Movements', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ...recentMovements.map((movement) => 
              ListTile(
                leading: Icon(_getMovementIcon(movement['type']), color: _getMovementColor(movement['type'])),
                title: Text(movement['product'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('${movement['type']} - ${movement['quantity']} units', style: TextStyle(fontFamily: 'Cairo')),
                trailing: Text(movement['date'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProducts() {
    final topProducts = List.from(_products);
    topProducts.sort((a, b) => b['quantity'].compareTo(a['quantity']));
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Products by Stock', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ...topProducts.take(3).map((product) => 
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  child: Text(product['sku'].substring(0, 2), style: TextStyle(color: AppColors.primaryColor)),
                ),
                title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('${product['warehouse']} - ${product['location']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${product['quantity']} units', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    Text('\$${(product['quantity'] * product['cost']).toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String selectedValue, Function(String) onChanged, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: options.map((option) {
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(option, style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  selected: selectedValue == option,
                  onSelected: (selected) => onChanged(option),
                  selectedColor: AppColors.primaryColor,
                  labelStyle: TextStyle(
                    color: selectedValue == option ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportItem(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title, style: TextStyle(fontFamily: 'Cairo')),
      subtitle: Text(subtitle, style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      trailing: IconButton(
        icon: Icon(Icons.download),
        onPressed: () {},
      ),
    );
  }

  // Utility Functions
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Available': return Colors.green;
      case 'Low Stock': return Colors.orange;
      case 'Out of Stock': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getProductIcon(String category) {
    switch (category) {
      case 'Electronics': return Icons.computer;
      case 'Accessories': return Icons.mouse;
      case 'Furniture': return Icons.chair;
      case 'Clothing': return Icons.checkroom;
      default: return Icons.inventory_2;
    }
  }

  IconData _getMovementIcon(String type) {
    switch (type) {
      case 'Purchase': return Icons.shopping_cart;
      case 'Sale': return Icons.sell;
      case 'Transfer': return Icons.compare_arrows;
      case 'Adjustment': return Icons.edit;
      default: return Icons.history;
    }
  }

  Color _getMovementColor(String type) {
    switch (type) {
      case 'Purchase': return Colors.green;
      case 'Sale': return Colors.blue;
      case 'Transfer': return Colors.orange;
      case 'Adjustment': return Colors.purple;
      default: return Colors.grey;
    }
  }

  // Action Methods
  void _showTransferDialog() {
    showDialog(
      context: context,
      builder: (context) => StockTransferDialog(
        products: _products,
        warehouses: _warehouses,
        onTransferRequested: _requestStockTransfer,
      ),
    );
  }

  void _showAdjustmentDialog() {
    showDialog(
      context: context,
      builder: (context) => StockAdjustmentDialog(
        products: _products,
        onStockAdjusted: (product, adjustment) {
          _adjustStock(product, adjustment);
        },
      ),
    );
  }

  void _showAllMovements() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('All Movements', style: TextStyle(fontFamily: 'Cairo')),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: _movements.length,
            itemBuilder: (context, index) {
              final movement = _movements[index];
              return ListTile(
                title: Text(movement['product'], style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Text('${movement['type']} - ${movement['quantity']} units', style: TextStyle(fontFamily: 'Cairo')),
                trailing: Text(movement['date'], style: TextStyle(fontFamily: 'Cairo')),
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

  void _generateReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report generation started', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _generateStockValuationReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stock Valuation Report', style: TextStyle(fontFamily: 'Cairo')),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Stock Value: \$${_totalStockValue.toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo', fontSize: 18)),
              SizedBox(height: 16),
              ..._products.map((product) {
                final value = product['quantity'] * product['cost'];
                return ListTile(
                  title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('${product['quantity']} × \$${product['cost']}', style: TextStyle(fontFamily: 'Cairo')),
                  trailing: Text('\$${value.toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo')),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Report exported as PDF', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Export PDF', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _generateStockAgingReport() {
    // Implementation for stock aging report
  }

  void _generateMovementReport() {
    // Implementation for movement report
  }

  void _generateLowStockReport() {
    // Implementation for low stock report
  }

  void _generateExpiryReport() {
    // Implementation for expiry report
  }

  void _generateTopItemsReport() {
    // Implementation for top items report
  }

  void _exportToPDF() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting to PDF...', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _exportToExcel() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting to Excel...', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Dialog and Sheet Widgets
class ProductDetailSheet extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onStockAdjusted;
  final Function(Map<String, dynamic>) onTransferRequested;

  const ProductDetailSheet({
    super.key,
    required this.product,
    required this.onStockAdjusted,
    required this.onTransferRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getStatusColor(product['status']).withOpacity(0.1),
                  radius: 30,
                  child: Icon(
                    _getProductIcon(product['category']),
                    color: _getStatusColor(product['status']),
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['name'], style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(product['sku'], style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
                      Text(product['category'], style: TextStyle(fontFamily: 'Cairo')),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(product['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product['status'],
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: _getStatusColor(product['status']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Stock Information
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStockInfo('Total Stock', product['quantity'].toString()),
                        _buildStockInfo('Reserved', product['reserved'].toString()),
                        _buildStockInfo('Available', product['available'].toString()),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStockInfo('Min Quantity', product['minQuantity'].toString()),
                        _buildStockInfo('Max Quantity', product['maxQuantity'].toString()),
                        _buildStockInfo('Reorder At', product['minQuantity'].toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Price Information
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Cost Price', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
                        Text('\$${product['cost'].toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Selling Price', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
                        Text('\$${product['price'].toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Margin', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
                        Text('${((product['price'] - product['cost']) / product['cost'] * 100).toStringAsFixed(1)}%', 
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Location Information
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildDetailRow('Warehouse', product['warehouse']),
                    _buildDetailRow('Location', product['location']),
                    _buildDetailRow('Supplier', product['supplier']),
                    _buildDetailRow('Unit', product['unit']),
                    if (product['batchNumber'] != null)
                      _buildDetailRow('Batch Number', product['batchNumber']),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => StockAdjustmentDialog(
                          products: [product],
                          onStockAdjusted: (selectedProduct, adjustment) {
                            onStockAdjusted(adjustment);
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Adjust Stock', style: TextStyle(fontFamily: 'Cairo')),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => StockTransferDialog(
                          products: [product],
                          warehouses: [],
                          onTransferRequested: (selectedProduct, transferDetails) => onTransferRequested(transferDetails),
                        ),
                      );
                    },
                    icon: Icon(Icons.compare_arrows),
                    label: Text('Transfer', style: TextStyle(fontFamily: 'Cairo')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 8),
            
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // Show movement history
              },
              icon: Icon(Icons.history),
              label: Text('View History', style: TextStyle(fontFamily: 'Cairo')),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockInfo(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontFamily: 'Cairo', color: Colors.grey, fontSize: 12)),
        Text(value, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontFamily: 'Cairo'))),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Available': return Colors.green;
      case 'Low Stock': return Colors.orange;
      case 'Out of Stock': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getProductIcon(String category) {
    switch (category) {
      case 'Electronics': return Icons.computer;
      case 'Accessories': return Icons.mouse;
      case 'Furniture': return Icons.chair;
      case 'Clothing': return Icons.checkroom;
      default: return Icons.inventory_2;
    }
  }
}

class AddProductDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onProductAdded;

  const AddProductDialog({super.key, required this.onProductAdded});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController(text: '0');
  final _priceController = TextEditingController();
  final _costController = TextEditingController();
  final _minQuantityController = TextEditingController(text: '5');
  final _maxQuantityController = TextEditingController(text: '100');
  String _selectedCategory = 'Electronics';
  String _selectedBrand = 'Apple';
  final String _selectedWarehouse = 'Main Warehouse';
  String _selectedUnit = 'Piece';

  final List<String> _categories = ['Electronics', 'Accessories', 'Furniture', 'Clothing'];
  final List<String> _brands = ['Apple', 'Samsung', 'Dell', 'Logitech'];
  final List<String> _units = ['Piece', 'Box', 'Pack', 'Meter', 'Kilogram'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Product', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(labelText: 'SKU'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: InputDecoration(labelText: 'Initial Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(labelText: 'Cost Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _minQuantityController,
                      decoration: InputDecoration(labelText: 'Min Quantity'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _maxQuantityController,
                      decoration: InputDecoration(labelText: 'Max Quantity'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              DropdownButtonFormField(
                initialValue: _selectedCategory,
                items: _categories.map((category) => 
                  DropdownMenuItem(value: category, child: Text(category))
                ).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
                decoration: InputDecoration(labelText: 'Category'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedBrand,
                items: _brands.map((brand) => 
                  DropdownMenuItem(value: brand, child: Text(brand))
                ).toList(),
                onChanged: (value) => setState(() => _selectedBrand = value!),
                decoration: InputDecoration(labelText: 'Brand'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedUnit,
                items: _units.map((unit) => 
                  DropdownMenuItem(value: unit, child: Text(unit))
                ).toList(),
                onChanged: (value) => setState(() => _selectedUnit = value!),
                decoration: InputDecoration(labelText: 'Unit'),
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
                'id': 'PROD${DateTime.now().millisecondsSinceEpoch}',
                'sku': _skuController.text,
                'name': _nameController.text,
                'category': _selectedCategory,
                'brand': _selectedBrand,
                'description': _descriptionController.text,
                'quantity': int.parse(_quantityController.text),
                'reserved': 0,
                'available': int.parse(_quantityController.text),
                'minQuantity': int.parse(_minQuantityController.text),
                'maxQuantity': int.parse(_maxQuantityController.text),
                'price': double.parse(_priceController.text),
                'cost': double.tryParse(_costController.text) ?? double.parse(_priceController.text) * 0.8,
                'location': 'WH-01-A1-B1',
                'warehouse': _selectedWarehouse,
                'supplier': _selectedBrand,
                'status': int.parse(_quantityController.text) == 0 ? 'Out of Stock' : 
                          int.parse(_quantityController.text) <= int.parse(_minQuantityController.text) ? 'Low Stock' : 'Available',
                'unit': _selectedUnit,
                'barcode': DateTime.now().millisecondsSinceEpoch.toString(),
              });
              Navigator.pop(context);
            }
          },
          child: Text('Add Product', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class StockAdjustmentDialog extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>, Map<String, dynamic>) onStockAdjusted;

  const StockAdjustmentDialog({
    super.key,
    required this.products,
    required this.onStockAdjusted,
  });

  @override
  State<StockAdjustmentDialog> createState() => _StockAdjustmentDialogState();
}

class _StockAdjustmentDialogState extends State<StockAdjustmentDialog> {
  Map<String, dynamic>? _selectedProduct;
  String _adjustmentType = 'Add Stock';
  final _quantityController = TextEditingController();
  final _reasonController = TextEditingController();
  String _selectedReason = 'Physical Count';

  final List<String> _reasons = [
    'Physical Count',
    'Damaged Goods',
    'Returned Goods',
    'Theft/Loss',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stock Adjustment', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              initialValue: _selectedProduct,
              items: widget.products.map((product) => 
                DropdownMenuItem(
                  value: product,
                  child: Text('${product['name']} (${product['quantity']} units)', style: TextStyle(fontFamily: 'Cairo')),
                )
              ).toList(),
              onChanged: (value) => setState(() => _selectedProduct = value),
              decoration: InputDecoration(labelText: 'Select Product'),
            ),
            
            if (_selectedProduct != null) ...[
              SizedBox(height: 16),
              Text('Current Stock: ${_selectedProduct!['quantity']}', style: TextStyle(fontFamily: 'Cairo')),
              SizedBox(height: 16),
              DropdownButtonFormField(
                initialValue: _adjustmentType,
                items: ['Add Stock', 'Remove Stock', 'Set Stock'].map((type) => 
                  DropdownMenuItem(value: type, child: Text(type))
                ).toList(),
                onChanged: (value) => setState(() => _adjustmentType = value!),
                decoration: InputDecoration(labelText: 'Adjustment Type'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedReason,
                items: _reasons.map((reason) => 
                  DropdownMenuItem(value: reason, child: Text(reason))
                ).toList(),
                onChanged: (value) => setState(() => _selectedReason = value!),
                decoration: InputDecoration(labelText: 'Reason'),
              ),
              if (_selectedReason == 'Other')
                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(labelText: 'Specify Reason'),
                ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: _selectedProduct == null ? null : () {
            final quantity = int.parse(_quantityController.text);
            final adjustment = _adjustmentType == 'Remove Stock' ? -quantity : quantity;
            
            widget.onStockAdjusted(_selectedProduct!, {
              'quantity': adjustment,
              'type': 'Adjustment',
              'from': _selectedProduct!['warehouse'],
              'to': _selectedProduct!['warehouse'],
              'reason': _reasonController.text.isNotEmpty ? _reasonController.text : _selectedReason,
            });
            
            Navigator.pop(context);
          },
          child: Text('Adjust Stock', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class StockTransferDialog extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> warehouses;
  final Function(Map<String, dynamic>, Map<String, dynamic>) onTransferRequested;

  const StockTransferDialog({
    super.key,
    required this.products,
    required this.warehouses,
    required this.onTransferRequested,
  });

  @override
  State<StockTransferDialog> createState() => _StockTransferDialogState();
}

class _StockTransferDialogState extends State<StockTransferDialog> {
  Map<String, dynamic>? _selectedProduct;
  Map<String, dynamic>? _selectedFromWarehouse;
  Map<String, dynamic>? _selectedToWarehouse;
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stock Transfer', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              initialValue: _selectedProduct,
              items: widget.products.map((product) => 
                DropdownMenuItem(
                  value: product,
                  child: Text('${product['name']} (${product['quantity']} available)', style: TextStyle(fontFamily: 'Cairo')),
                )
              ).toList(),
              onChanged: (value) => setState(() => _selectedProduct = value),
              decoration: InputDecoration(labelText: 'Product'),
            ),
            
            if (_selectedProduct != null) ...[
              SizedBox(height: 16),
              Text('Current Location: ${_selectedProduct!['warehouse']} - ${_selectedProduct!['location']}', 
                style: TextStyle(fontFamily: 'Cairo')),
              SizedBox(height: 16),
              DropdownButtonFormField(
                initialValue: _selectedFromWarehouse,
                items: widget.warehouses.map((warehouse) => 
                  DropdownMenuItem(
                    value: warehouse,
                    child: Text(warehouse['name'], style: TextStyle(fontFamily: 'Cairo')),
                  )
                ).toList(),
                onChanged: (value) => setState(() => _selectedFromWarehouse = value),
                decoration: InputDecoration(labelText: 'From Warehouse'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedToWarehouse,
                items: widget.warehouses.where((w) => w != _selectedFromWarehouse).map((warehouse) => 
                  DropdownMenuItem(
                    value: warehouse,
                    child: Text(warehouse['name'], style: TextStyle(fontFamily: 'Cairo')),
                  )
                ).toList(),
                onChanged: (value) => setState(() => _selectedToWarehouse = value),
                decoration: InputDecoration(labelText: 'To Warehouse'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Transfer Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes (Optional)'),
                maxLines: 3,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: _selectedProduct == null ||
                    _selectedFromWarehouse == null ||
                    _selectedToWarehouse == null ? null : () {
            final transferDetails = {
              'from': _selectedFromWarehouse!['name'],
              'to': _selectedToWarehouse!['name'],
              'quantity': int.parse(_quantityController.text),
              'notes': _notesController.text,
            };

            widget.onTransferRequested(_selectedProduct!, transferDetails);
            Navigator.pop(context);
          },
          child: Text('Request Transfer', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class StockCountSheet extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Function(List<Map<String, dynamic>>) onCountCompleted;

  const StockCountSheet({super.key, required this.products, required this.onCountCompleted});

  @override
  State<StockCountSheet> createState() => _StockCountSheetState();
}

class _StockCountSheetState extends State<StockCountSheet> {
  List<Map<String, dynamic>> _countResults = [];

  @override
  void initState() {
    super.initState();
    _countResults = widget.products.map((product) => {
      'productId': product['id'],
      'productName': product['name'],
      'expected': product['quantity'],
      'counted': product['quantity'],
      'variance': 0,
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Stock Count', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _countResults.length,
              itemBuilder: (context, index) {
                final result = _countResults[index];
                return Card(
                  child: ListTile(
                    title: Text(result['productName'], style: TextStyle(fontFamily: 'Cairo')),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Expected: ${result['expected']}', style: TextStyle(fontFamily: 'Cairo')),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: result['counted'].toString(),
                                decoration: InputDecoration(
                                  labelText: 'Counted',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                ),
                                onChanged: (value) {
                                  final counted = int.tryParse(value) ?? result['expected'];
                                  setState(() {
                                    _countResults[index]['counted'] = counted;
                                    _countResults[index]['variance'] = counted - result['expected'];
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: result['variance'] == 0 ? Colors.green.withOpacity(0.1) : 
                                       result['variance'] > 0 ? Colors.blue.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${result['variance'] >= 0 ? '+' : ''}${result['variance']}',
                                style: TextStyle(
                                  color: result['variance'] == 0 ? Colors.green : 
                                         result['variance'] > 0 ? Colors.blue : Colors.red,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  label: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    widget.onCountCompleted(_countResults);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.check),
                  label: Text('Complete Count', style: TextStyle(fontFamily: 'Cairo')),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WarehouseManagementSheet extends StatelessWidget {
  final List<Map<String, dynamic>> warehouses;
  final Function(List<Map<String, dynamic>>) onWarehouseUpdated;

  const WarehouseManagementSheet({
    super.key,
    required this.warehouses,
    required this.onWarehouseUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Warehouse Management', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: warehouses.length,
              itemBuilder: (context, index) {
                final warehouse = warehouses[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.warehouse, color: AppColors.primaryColor),
                    title: Text(warehouse['name'], style: TextStyle(fontFamily: 'Cairo')),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(warehouse['address'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                        SizedBox(height: 4),
                        Text('Capacity: ${warehouse['capacity']} units', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, size: 20),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, size: 20),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Add Warehouse', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}