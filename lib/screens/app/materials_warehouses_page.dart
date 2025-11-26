import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';

class MaterialsWarehousesPage extends StatefulWidget {
  const MaterialsWarehousesPage({super.key});

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
    {
      'id': 'P005', 
      'name': 'Desk Lamp', 
      'sku': 'DL-001', 
      'category': 'Furniture', 
      'uom': 'Unit',
      'cost': 45.0, 
      'sale_price': 70.0, 
      'quantity': 12,
      'min_stock': 5,
      'max_stock': 50,
      'type': 'Storable',
      'vendor': 'LightingCo',
      'tracking': 'Serial',
      'barcode': '1234567890127',
      'weight': 1.5,
      'dimensions': '15x15x40 cm'
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
    {
      'id': 'WH004',
      'name': 'Damam Storage',
      'location': 'Damam Commercial Area',
      'type': 'Internal',
      'capacity': 6000,
      'used_capacity': 2800,
      'manager': 'Khalid Omar',
      'status': 'Active',
      'contact': '+966 50 333 4444',
      'address': 'Commercial Area, Damam 34567'
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
    {
      'id': 'TR004',
      'reference': 'TRF/2024/002',
      'from_location': 'Jeddah Distribution',
      'to_location': 'Damam Storage',
      'product': 'Wireless Mouse',
      'product_id': 'P004',
      'quantity': 25,
      'status': 'Completed',
      'date': '2024-01-18',
      'type': 'Internal Transfer',
      'notes': 'Regional distribution'
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
    {
      'id': 'MV003',
      'product': 'Office Chair Ergonomic',
      'product_id': 'P002',
      'reference': 'ADJ-2024-001',
      'quantity': -1,
      'balance': 22,
      'date': '2024-01-16 09:00',
      'type': 'Adjustment',
      'location': 'Main Warehouse',
      'user': 'Warehouse Manager'
    },
    {
      'id': 'MV004',
      'product': 'Wireless Mouse',
      'product_id': 'P004',
      'reference': 'SO-2024-002',
      'quantity': -5,
      'balance': 10,
      'date': '2024-01-16 11:20',
      'type': 'Sale',
      'location': 'Jeddah Distribution',
      'user': 'Sales Team'
    },
    {
      'id': 'MV005',
      'product': 'Desk Lamp',
      'product_id': 'P005',
      'reference': 'TRF-2024-001',
      'quantity': 10,
      'balance': 22,
      'date': '2024-01-17 08:45',
      'type': 'Transfer',
      'location': 'Main Warehouse',
      'user': 'Logistics'
    },
  ];

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
      'product': 'Printer Ink Cartridge',
      'product_id': 'P006',
      'current_stock': 12,
      'min_stock': 15,
      'status': 'Warning',
      'last_ordered': '2024-01-12',
      'vendor': 'InkSupplies',
      'urgency': 'Medium'
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
      'vendor': 'InkSupplies',
      'product': 'Printer Ink Cartridge',
      'product_id': 'P006',
      'quantity': 50,
      'unit_price': 25.0,
      'total': 1250.0,
      'status': 'Confirmed',
      'expected_date': '2024-01-20',
      'created_date': '2024-01-14'
    },
    {
      'id': 'PO003',
      'reference': 'PO-2024-003',
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
    {
      'serial_number': 'SN-DLXPS13-002',
      'product': 'Laptop Dell XPS 13',
      'product_id': 'P001',
      'location': 'Jeddah Distribution',
      'status': 'In Stock',
      'purchase_date': '2024-01-12',
      'warranty_expiry': '2026-01-12'
    },
    {
      'lot_number': 'LOT-2024-002',
      'product': 'Desk Lamp',
      'product_id': 'P005',
      'quantity': 100,
      'expiry_date': '2027-12-31',
      'location': 'Main Warehouse',
      'status': 'Active',
      'manufacture_date': '2024-01-05'
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
    {
      'id': 'ADJ002',
      'reference': 'ADJ-2024-002',
      'product': 'Wireless Mouse',
      'product_id': 'P004',
      'quantity': 2,
      'reason': 'Found in returns',
      'date': '2024-01-17',
      'status': 'Approved',
      'approved_by': 'Quality Control',
      'location': 'Jeddah Distribution'
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
    {
      'id': 'RET001',
      'reference': 'RET-2024-001',
      'product': 'Wireless Mouse',
      'product_id': 'P004',
      'quantity': 3,
      'reason': 'Customer return - defective',
      'date': '2024-01-15',
      'type': 'Return',
      'status': 'Pending Inspection',
      'location': 'Quality Control'
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _loadInitialData();
  }

  void _loadInitialData() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(milliseconds: 500)); // Simulate API call
    setState(() => _isLoading = false);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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

  // Core Functions
  void _showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => ResponsiveDialog(
        title: 'Product Details',
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
        child: SingleChildScrollView(
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
              
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showAdjustStockForProduct(product),
                      icon: Icon(Icons.adjust, size: _responsiveValue(context, mobile: 16, tablet: 18)),
                      label: Text('Adjust Stock', style: TextStyle(fontFamily: 'Cairo', fontSize: _responsiveValue(context, mobile: 12, tablet: 14))),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showTransferProduct(product),
                      icon: Icon(Icons.swap_horiz, size: _responsiveValue(context, mobile: 16, tablet: 18)),
                      label: Text('Transfer', style: TextStyle(fontFamily: 'Cairo', fontSize: _responsiveValue(context, mobile: 12, tablet: 14))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAdjustStockForProduct(Map<String, dynamic> product) {
    Navigator.pop(context); // Close details dialog first
    showDialog(
      context: context,
      builder: (context) => StockAdjustmentDialog(
        product: product,
        onAdjustmentCreated: (adjustment) {
          setState(() {
            _inventoryAdjustments.add(adjustment);
            final productIndex = _products.indexWhere((p) => p['id'] == product['id']);
            if (productIndex != -1) {
              _products[productIndex]['quantity'] += adjustment['quantity'];
            }
          });
        },
        products: _products,
      ),
    );
  }

  void _showTransferProduct(Map<String, dynamic> product) {
    Navigator.pop(context); // Close details dialog first
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => InventoryTransferForm(
        initialProduct: product,
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
      builder: (context) => ResponsiveDialog(
        title: 'Warehouse Details',
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
        child: SingleChildScrollView(
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
              
              SizedBox(height: 16),
              Text('Capacity Usage', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: warehouse['used_capacity'] / warehouse['capacity'],
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  (warehouse['used_capacity'] / warehouse['capacity']) > 0.8 ? Colors.red : 
                  (warehouse['used_capacity'] / warehouse['capacity']) > 0.6 ? Colors.orange : Colors.green
                ),
              ),
              Text('${((warehouse['used_capacity'] / warehouse['capacity']) * 100).toStringAsFixed(1)}% Used', 
                   style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  void _showInventoryTransfer({Map<String, dynamic>? initialProduct}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => InventoryTransferForm(
        initialProduct: initialProduct,
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
      builder: (context) => ResponsiveDialog(
        title: 'Barcode Scanner',
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: _responsiveValue(context, mobile: 64, tablet: 80, desktop: 100), color: AppColors.primaryColor),
            SizedBox(height: 16),
            Text('Point camera at barcode to scan', style: TextStyle(fontFamily: 'Cairo', fontSize: _responsiveValue(context, mobile: 14, tablet: 16))),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16),
            Text('Simulated Scan Results', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ..._products.take(2).map((product) => ListTile(
              leading: Icon(Icons.inventory_2),
              title: Text(product['name'], style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Text('Barcode: ${product['barcode']}', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                _showProductDetails(product);
              },
            )),
          ],
        ),
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
      padding: EdgeInsets.symmetric(vertical: _responsiveValue(context, mobile: 2, tablet: 4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _responsiveValue(context, mobile: 100, tablet: 120, desktop: 140),
            child: Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: _responsiveValue(context, mobile: 12, tablet: 14))),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: _responsiveValue(context, mobile: 12, tablet: 14))),
          ),
        ],
      ),
    );
  }

  // Helper methods for UI
  IconData _getTransferIcon(String type) {
    switch (type) {
      case 'Internal Transfer': return Icons.swap_horiz;
      case 'Receipt': return Icons.move_to_inbox;
      case 'Delivery': return Icons.local_shipping;
      default: return Icons.swap_horiz;
    }
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

  List<Map<String, dynamic>> get _filteredTransfers {
    if (_selectedFilter == 'All') return _inventoryTransfers;
    return _inventoryTransfers.where((transfer) => transfer['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : AppColors.backgroundColor,
      body: _isLoading ? _buildLoadingState() : _buildMainContent(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor)),
          SizedBox(height: 16),
          Text('Loading Materials & Warehouses...', style: TextStyle(fontFamily: 'Cairo', fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.primaryColor,
            elevation: 0,
            pinned: true,
            floating: true,
            snap: true,
            title: Text(
              'Materials & Warehouses',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
              onPressed: () => Navigator.pop(context),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(_responsiveValue(context, mobile: 48, tablet: 56, desktop: 60)),
              child: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.white,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.primaryColor.withOpacity(0.5),
                  indicatorColor: AppColors.primaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 11, tablet: 13, desktop: 15),
                  ),
                  tabs: const [
                    Tab(text: 'Dashboard'),
                    Tab(text: 'Products'),
                    Tab(text: 'Warehouses'),
                    Tab(text: 'Transfers'),
                    Tab(text: 'Movements'),
                    Tab(text: 'Purchasing'),
                    Tab(text: 'Tracking'),
                    Tab(text: 'Adjustments'),
                    Tab(text: 'Scrap/Returns'),
                    Tab(text: 'Reports'),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildProductsTab(),
          _buildWarehousesTab(),
          _buildTransfersTab(),
          _buildMovementsTab(),
          _buildPurchasingTab(),
          _buildTrackingTab(),
          _buildAdjustmentsTab(),
          _buildScrapReturnsTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    final totalProducts = _products.length;
    final totalWarehouses = _warehouses.length;
    final totalValue = _products.map((p) => p['cost'] * p['quantity']).reduce((a, b) => a + b);
    final criticalAlerts = _lowStockAlerts.where((alert) => alert['status'] == 'Critical').length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        children: [
          // Quick Stats - Responsive Grid
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
            mainAxisSpacing: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
            childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.2 : 1.0,
            children: [
              _buildStatCard('Total Products', totalProducts.toString(), Colors.blue, Icons.inventory),
              _buildStatCard('Total Warehouses', totalWarehouses.toString(), Colors.green, Icons.warehouse),
              _buildStatCard('Inventory Value', '\$${totalValue.toStringAsFixed(0)}', Colors.orange, Icons.attach_money),
              _buildStatCard('Critical Alerts', criticalAlerts.toString(), Colors.red, Icons.warning),
            ],
          ),

          SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),

          // Quick Actions
          Text('Quick Actions', style: TextStyle(
            fontFamily: 'Cairo', 
            fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
            fontWeight: FontWeight.bold
          )),
          SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
          
          Wrap(
            spacing: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
            runSpacing: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
            children: [
              _buildActionButton('Receive Items', Icons.move_to_inbox, Colors.green, _showReceiveItems),
              _buildActionButton('Transfer', Icons.swap_horiz, Colors.blue, _showInventoryTransfer),
              _buildActionButton('Adjust Stock', Icons.adjust, Colors.orange, _showAdjustStock),
              _buildActionButton('Scan Barcode', Icons.qr_code_scanner, Colors.purple, _showBarcodeScanner),
              _buildActionButton('Add Product', Icons.add_box, Colors.teal, _showAddProductDialog),
              _buildActionButton('Scrap/Return', Icons.delete_outline, Colors.red, _showScrapReturnDialog),
            ],
          ),

          SizedBox(height: _responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),

          // Low Stock Alerts
          _buildLowStockAlerts(),

          SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),

          // Recent Transfers
          _buildRecentTransfers(),
        ],
      ),
    );
  }

  Widget _buildLowStockAlerts() {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
      child: Padding(
        padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.orange, size: _responsiveValue(context, mobile: 20, tablet: 24)),
                SizedBox(width: 8),
                Text('Low Stock Alerts', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                  fontWeight: FontWeight.bold
                )),
              ],
            ),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
            ..._lowStockAlerts.map((alert) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(alert['product'], style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                      )),
                    ),
                    Text('${alert['current_stock']}/${alert['min_stock']}', 
                         style: TextStyle(
                           fontFamily: 'Cairo', 
                           color: Colors.red,
                           fontSize: _responsiveValue(context, mobile: 14, tablet: 16),
                           fontWeight: FontWeight.bold
                         )),
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
                SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransfers() {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
      child: Padding(
        padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.swap_horiz, color: Colors.blue, size: _responsiveValue(context, mobile: 20, tablet: 24)),
                SizedBox(width: 8),
                Text('Recent Transfers', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                  fontWeight: FontWeight.bold
                )),
              ],
            ),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
            ..._inventoryTransfers.take(3).map((transfer) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transfer['reference'], style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: _responsiveValue(context, mobile: 14, tablet: 16),
                            fontWeight: FontWeight.w500
                          )),
                          SizedBox(height: 2),
                          Text('${transfer['product']} • Qty: ${transfer['quantity']}', 
                               style: TextStyle(
                                 fontFamily: 'Cairo', 
                                 fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                                 color: Colors.grey[600]
                               )),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(transfer['status'], style: TextStyle(
                        fontFamily: 'Cairo', 
                        fontSize: _responsiveValue(context, mobile: 10, tablet: 12),
                        color: Colors.white
                      )),
                      backgroundColor: _getStatusColor(transfer['status']),
                    ),
                  ],
                ),
                SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
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
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: _responsiveValue(context, mobile: 12, tablet: 16),
                      vertical: _responsiveValue(context, mobile: 12, tablet: 16),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(width: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
              IconButton(
                icon: Icon(Icons.filter_list, size: _responsiveValue(context, mobile: 20, tablet: 24)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => FilterDialog(
                      onFilterApplied: (filter) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: _filteredProducts.isEmpty ? 
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text('No products found', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: Colors.grey[600])),
                  SizedBox(height: 8),
                  Text('Try adjusting your search or add a new product', 
                       style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Colors.grey[500])),
                ],
              ),
            ) :
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                final stockStatus = product['quantity'] <= product['min_stock'] ? 'Low' : 'Good';
                final statusColor = stockStatus == 'Low' ? Colors.red : Colors.green;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: _responsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
                  elevation: 1,
                  child: ListTile(
                    leading: Icon(Icons.inventory_2, color: AppColors.primaryColor, 
                                 size: _responsiveValue(context, mobile: 24, tablet: 28)),
                    title: Text(product['name'], style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(context, mobile: 14, tablet: 16),
                      fontWeight: FontWeight.w500
                    )),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SKU: ${product['sku']} • ${product['category']}', style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(context, mobile: 12, tablet: 14)
                        )),
                        Text('Stock: ${product['quantity']} ${product['uom']}', style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: _responsiveValue(context, mobile: 12, tablet: 14)
                        )),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _responsiveValue(context, mobile: 6, tablet: 8),
                            vertical: _responsiveValue(context, mobile: 2, tablet: 4)
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: statusColor.withOpacity(0.3)),
                          ),
                          child: Text(stockStatus, style: TextStyle(
                            color: statusColor,
                            fontFamily: 'Cairo',
                            fontSize: _responsiveValue(context, mobile: 10, tablet: 12),
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                        SizedBox(height: 4),
                        Text('\$${product['cost']}', style: TextStyle(
                          fontFamily: 'Cairo', 
                          fontWeight: FontWeight.bold,
                          fontSize: _responsiveValue(context, mobile: 12, tablet: 14)
                        )),
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
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      children: [
        ..._warehouses.map((warehouse) => Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
          child: ListTile(
            leading: Icon(Icons.warehouse, color: AppColors.primaryColor, 
                         size: _responsiveValue(context, mobile: 24, tablet: 28)),
            title: Text(warehouse['name'], style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 18),
              fontWeight: FontWeight.w500
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(warehouse['location'], style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                )),
                Text('${warehouse['used_capacity']}/${warehouse['capacity']} sqm', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14)
                )),
              ],
            ),
            trailing: Chip(
              label: Text(warehouse['status'], style: TextStyle(
                fontFamily: 'Cairo', 
                color: Colors.white,
                fontSize: _responsiveValue(context, mobile: 10, tablet: 12)
              )),
              backgroundColor: warehouse['status'] == 'Active' ? Colors.green : Colors.orange,
            ),
            onTap: () => _showWarehouseDetails(warehouse),
          ),
        )),
      ],
    );
  }

  Widget _buildTransfersTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField(
                  value: _selectedFilter,
                  items: ['All', 'Pending', 'In Progress', 'Completed'].map((status) {
                    return DropdownMenuItem(value: status, child: Text(status));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Filter by Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
            children: [
              ..._filteredTransfers.map((transfer) => Card(
                elevation: 1,
                margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
                child: ListTile(
                  leading: Icon(_getTransferIcon(transfer['type']), color: AppColors.primaryColor,
                           size: _responsiveValue(context, mobile: 24, tablet: 28)),
                  title: Text(transfer['reference'], style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 14, tablet: 16),
                    fontWeight: FontWeight.w500
                  )),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${transfer['product']} • Qty: ${transfer['quantity']}', style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: _responsiveValue(context, mobile: 12, tablet: 14)
                      )),
                      Text('From: ${transfer['from_location']}', style: TextStyle(
                        fontFamily: 'Cairo', 
                        fontSize: _responsiveValue(context, mobile: 11, tablet: 13),
                        color: Colors.grey[600]
                      )),
                      Text('To: ${transfer['to_location']}', style: TextStyle(
                        fontFamily: 'Cairo', 
                        fontSize: _responsiveValue(context, mobile: 11, tablet: 13),
                        color: Colors.grey[600]
                      )),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(transfer['status'], style: TextStyle(
                      fontFamily: 'Cairo', 
                      color: Colors.white,
                      fontSize: _responsiveValue(context, mobile: 10, tablet: 12)
                    )),
                    backgroundColor: _getStatusColor(transfer['status']),
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMovementsTab() {
    return ListView(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      children: [
        ..._stockMovements.map((movement) => Card(
          elevation: 1,
          margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
          child: ListTile(
            leading: Icon(
              movement['quantity'] > 0 ? Icons.arrow_circle_up : Icons.arrow_circle_down,
              color: movement['quantity'] > 0 ? Colors.green : Colors.red,
              size: _responsiveValue(context, mobile: 24, tablet: 28),
            ),
            title: Text(movement['product'], style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 14, tablet: 16),
              fontWeight: FontWeight.w500
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ref: ${movement['reference']}', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14)
                )),
                Text('Date: ${movement['date']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 11, tablet: 13),
                  color: Colors.grey[600]
                )),
                if (movement['user'] != null) Text('By: ${movement['user']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 11, tablet: 13),
                  color: Colors.grey[600]
                )),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${movement['quantity'] > 0 ? '+' : ''}${movement['quantity']}',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: movement['quantity'] > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: _responsiveValue(context, mobile: 14, tablet: 16),
                  ),
                ),
                Text('Bal: ${movement['balance']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildPurchasingTab() {
    return ListView(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      children: [
        Text('Purchase Orders', style: TextStyle(
          fontFamily: 'Cairo', 
          fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
          fontWeight: FontWeight.bold
        )),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
        ..._purchaseOrders.map((po) => Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
          child: ListTile(
            leading: Icon(Icons.shopping_cart, color: AppColors.primaryColor,
                         size: _responsiveValue(context, mobile: 24, tablet: 28)),
            title: Text(po['reference'], style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 18),
              fontWeight: FontWeight.w500
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${po['product']} • Qty: ${po['quantity']}', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                )),
                Text('Vendor: ${po['vendor']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
                Text('Total: \$${po['total']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
                Text('Expected: ${po['expected_date']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
              ],
            ),
            trailing: Chip(
              label: Text(po['status'], style: TextStyle(
                fontFamily: 'Cairo', 
                color: Colors.white,
                fontSize: _responsiveValue(context, mobile: 10, tablet: 12)
              )),
              backgroundColor: _getStatusColor(po['status']),
            ),
          ),
        )),
        SizedBox(height: _responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
        Text('Low Stock Alerts', style: TextStyle(
          fontFamily: 'Cairo', 
          fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
          fontWeight: FontWeight.bold
        )),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
        ..._lowStockAlerts.map((alert) => Card(
          color: alert['status'] == 'Critical' ? Colors.red[50] : Colors.orange[50],
          elevation: 1,
          margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
          child: ListTile(
            leading: Icon(Icons.warning, color: alert['status'] == 'Critical' ? Colors.red : Colors.orange,
                         size: _responsiveValue(context, mobile: 24, tablet: 28)),
            title: Text(alert['product'], style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 18),
              fontWeight: FontWeight.w500
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current: ${alert['current_stock']} • Min: ${alert['min_stock']}', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                )),
                Text('Vendor: ${alert['vendor']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () => _createPurchaseOrder(alert),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: _responsiveValue(context, mobile: 12, tablet: 16),
                  vertical: _responsiveValue(context, mobile: 8, tablet: 12)
                ),
              ),
              child: Text('Order', style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: _responsiveValue(context, mobile: 12, tablet: 14)
              )),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildTrackingTab() {
    return ListView(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      children: [
        Text('Lot/Serial Tracking', style: TextStyle(
          fontFamily: 'Cairo', 
          fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
          fontWeight: FontWeight.bold
        )),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
        ..._lotsSerials.map((tracking) => Card(
          elevation: 1,
          margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
          child: ListTile(
            leading: Icon(Icons.confirmation_number, color: AppColors.primaryColor,
                         size: _responsiveValue(context, mobile: 24, tablet: 28)),
            title: Text(tracking['lot_number'] ?? tracking['serial_number'], style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 18),
              fontWeight: FontWeight.w500
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tracking['product'], style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                )),
                if (tracking['expiry_date'] != null)
                  Text('Expires: ${tracking['expiry_date']}', style: TextStyle(
                    fontFamily: 'Cairo', 
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                    color: Colors.grey[600]
                  )),
                if (tracking['quantity'] != null)
                  Text('Quantity: ${tracking['quantity']}', style: TextStyle(
                    fontFamily: 'Cairo', 
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                    color: Colors.grey[600]
                  )),
                Text('Location: ${tracking['location']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
                if (tracking['manufacture_date'] != null)
                  Text('Manufactured: ${tracking['manufacture_date']}', style: TextStyle(
                    fontFamily: 'Cairo', 
                    fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                    color: Colors.grey[600]
                  )),
              ],
            ),
            trailing: Chip(
              label: Text(tracking['status'], style: TextStyle(
                fontFamily: 'Cairo', 
                color: Colors.white,
                fontSize: _responsiveValue(context, mobile: 10, tablet: 12)
              )),
              backgroundColor: tracking['status'] == 'Active' ? Colors.green : Colors.blue,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildAdjustmentsTab() {
    return ListView(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      children: [
        Text('Inventory Adjustments', style: TextStyle(
          fontFamily: 'Cairo', 
          fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
          fontWeight: FontWeight.bold
        )),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
        ..._inventoryAdjustments.map((adjustment) => Card(
          elevation: 1,
          margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
          child: ListTile(
            leading: Icon(Icons.adjust, color: AppColors.primaryColor,
                         size: _responsiveValue(context, mobile: 24, tablet: 28)),
            title: Text(adjustment['reference'], style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 18),
              fontWeight: FontWeight.w500
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${adjustment['product']} • Qty: ${adjustment['quantity'] > 0 ? '+' : ''}${adjustment['quantity']}', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                )),
                Text('Reason: ${adjustment['reason']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
                Text('Date: ${adjustment['date']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
                Text('Approved by: ${adjustment['approved_by']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
              ],
            ),
            trailing: Chip(
              label: Text(adjustment['status'], style: TextStyle(
                fontFamily: 'Cairo', 
                color: Colors.white,
                fontSize: _responsiveValue(context, mobile: 10, tablet: 12)
              )),
              backgroundColor: _getStatusColor(adjustment['status']),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildScrapReturnsTab() {
    return ListView(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      children: [
        Text('Scrap & Returns', style: TextStyle(
          fontFamily: 'Cairo', 
          fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
          fontWeight: FontWeight.bold
        )),
        SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
        ..._scrapReturns.map((record) => Card(
          elevation: 1,
          margin: EdgeInsets.only(bottom: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
          child: ListTile(
            leading: Icon(record['type'] == 'Scrap' ? Icons.delete_outline : Icons.assignment_return,
                         color: record['type'] == 'Scrap' ? Colors.red : Colors.orange,
                         size: _responsiveValue(context, mobile: 24, tablet: 28)),
            title: Text(record['reference'], style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: _responsiveValue(context, mobile: 16, tablet: 18),
              fontWeight: FontWeight.w500
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${record['product']} • Qty: ${record['quantity']}', style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                )),
                Text('Reason: ${record['reason']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
                Text('Date: ${record['date']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
                Text('Location: ${record['location']}', style: TextStyle(
                  fontFamily: 'Cairo', 
                  fontSize: _responsiveValue(context, mobile: 12, tablet: 14),
                  color: Colors.grey[600]
                )),
              ],
            ),
            trailing: Chip(
              label: Text(record['status'], style: TextStyle(
                fontFamily: 'Cairo', 
                color: Colors.white,
                fontSize: _responsiveValue(context, mobile: 10, tablet: 12)
              )),
              backgroundColor: _getStatusColor(record['status']),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildReportsTab() {
    final totalValue = _products.map((p) => p['cost'] * p['quantity']).reduce((a, b) => a + b);
    final totalItems = _products.map((p) => p['quantity']).reduce((a, b) => a + b);
    final avgCost = totalItems > 0 ? totalValue / totalItems : 0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inventory Reports', style: TextStyle(
            fontFamily: 'Cairo', 
            fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
            fontWeight: FontWeight.bold
          )),
          SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
          
          // Summary Cards
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
            mainAxisSpacing: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
            childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.2 : 1.0,
            children: [
              _buildReportCard('Total Value', '\$${totalValue.toStringAsFixed(0)}', Colors.blue),
              _buildReportCard('Total Items', totalItems.toString(), Colors.green),
              _buildReportCard('Avg Cost', '\$${avgCost.toStringAsFixed(2)}', Colors.orange),
              _buildReportCard('Products', _products.length.toString(), Colors.purple),
            ],
          ),
          
          SizedBox(height: _responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
          Text('Stock Aging', style: TextStyle(
            fontFamily: 'Cairo', 
            fontSize: _responsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
            fontWeight: FontWeight.bold
          )),
          SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
          ..._products.map((product) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(product['name'], style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                    )),
                  ),
                  Text('${product['quantity']} units', style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 14, tablet: 16),
                    fontWeight: FontWeight.bold
                  )),
                ],
              ),
              SizedBox(height: 4),
              LinearProgressIndicator(
                value: product['quantity'] / product['max_stock'],
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  product['quantity'] / product['max_stock'] > 0.8 ? Colors.green :
                  product['quantity'] / product['max_stock'] > 0.5 ? Colors.blue : Colors.orange
                ),
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _getFloatingAction(),
      backgroundColor: AppColors.primaryColor,
      child: Icon(_getFloatingActionIcon(), color: Colors.white, 
                size: _responsiveValue(context, mobile: 24, tablet: 28)),
    );
  }

  VoidCallback _getFloatingAction() {
    switch (_selectedTabIndex) {
      case 1: return _showAddProductDialog;
      case 2: return () {}; // Add warehouse
      case 3: return _showInventoryTransfer;
      case 5: return () => _createPurchaseOrder(_lowStockAlerts.first);
      case 7: return _showAdjustStock;
      case 8: return _showScrapReturnDialog;
      default: return _showReceiveItems;
    }
  }

  IconData _getFloatingActionIcon() {
    switch (_selectedTabIndex) {
      case 1: return Icons.add;
      case 2: return Icons.add_business;
      case 3: return Icons.swap_horiz;
      case 5: return Icons.shopping_cart;
      case 7: return Icons.adjust;
      case 8: return Icons.delete_outline;
      default: return Icons.move_to_inbox;
    }
  }

  // Helper Widgets with responsive design
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: _responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
                Spacer(),
                if (color == Colors.red && value != '0')
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('!', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
            Text(value, style: TextStyle(
              fontFamily: 'Cairo', 
              fontSize: _responsiveValue(context, mobile: 18, tablet: 22, desktop: 26),
              fontWeight: FontWeight.bold
            )),
            SizedBox(height: _responsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
            Text(title, style: TextStyle(
              fontFamily: 'Cairo', 
              color: Colors.grey[600],
              fontSize: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    final isWideScreen = MediaQuery.of(context).size.width > 400;
    
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: isWideScreen ? 120 : 100,
        padding: EdgeInsets.all(_responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: _responsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),
            SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(_responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyle(
              fontFamily: 'Cairo', 
              fontSize: _responsiveValue(context, mobile: 18, tablet: 22, desktop: 26),
              fontWeight: FontWeight.bold, 
              color: color
            )),
            SizedBox(height: _responsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
            Text(title, style: TextStyle(
              fontFamily: 'Cairo', 
              color: color,
              fontSize: _responsiveValue(context, mobile: 12, tablet: 14, desktop: 16)
            )),
          ],
        ),
      ),
    );
  }
}

// Responsive Dialog Widget
class ResponsiveDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> actions;

  const ResponsiveDialog({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 600,
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Flexible(child: child),
            if (actions.isNotEmpty) ...[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Add Product Dialog
class AddProductDialog extends StatefulWidget {
  final Map<String, dynamic>? product;
  final Function(Map<String, dynamic>) onProductAdded;

  const AddProductDialog({super.key, this.product, required this.onProductAdded});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minStockController = TextEditingController();
  final TextEditingController _maxStockController = TextEditingController();
  final TextEditingController _vendorController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dimensionsController = TextEditingController();

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
      _barcodeController.text = widget.product!['barcode'] ?? '';
      _weightController.text = widget.product!['weight']?.toString() ?? '';
      _dimensionsController.text = widget.product!['dimensions'] ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _categoryController.dispose();
    _costController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _minStockController.dispose();
    _maxStockController.dispose();
    _vendorController.dispose();
    _barcodeController.dispose();
    _weightController.dispose();
    _dimensionsController.dispose();
    super.dispose();
  }

  double _responsiveValue(BuildContext context, {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return ResponsiveDialog(
      title: widget.product != null ? 'Edit Product' : 'Add New Product',
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final product = {
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
                'barcode': _barcodeController.text.isEmpty ? null : _barcodeController.text,
                'weight': _weightController.text.isEmpty ? null : double.parse(_weightController.text),
                'dimensions': _dimensionsController.text.isEmpty ? null : _dimensionsController.text,
              };
              widget.onProductAdded(product);
              Navigator.pop(context);
            }
          },
          child: Text(widget.product != null ? 'Update' : 'Add', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(
                  labelText: 'SKU',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              
              if (isMobile) ...[
                // Mobile layout - vertical
                TextFormField(
                  controller: _costController,
                  decoration: InputDecoration(labelText: 'Cost'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Sale Price'),
                  keyboardType: TextInputType.number,
                ),
              ] else ...[
                // Tablet/Desktop layout - horizontal
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _costController,
                        decoration: InputDecoration(labelText: 'Cost'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(labelText: 'Sale Price'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              
              if (isMobile) ...[
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                DropdownButtonFormField(
                  value: _selectedUOM,
                  items: ['Unit', 'Pack', 'Box', 'Pallet', 'Kg', 'Liter'].map((uom) {
                    return DropdownMenuItem(value: uom, child: Text(uom));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedUOM = value!),
                  decoration: InputDecoration(labelText: 'Unit of Measure'),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(labelText: 'Quantity'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedUOM,
                        items: ['Unit', 'Pack', 'Box', 'Pallet', 'Kg', 'Liter'].map((uom) {
                          return DropdownMenuItem(value: uom, child: Text(uom));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedUOM = value!),
                        decoration: InputDecoration(labelText: 'Unit of Measure'),
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              
              if (isMobile) ...[
                TextFormField(
                  controller: _minStockController,
                  decoration: InputDecoration(labelText: 'Min Stock'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _maxStockController,
                  decoration: InputDecoration(labelText: 'Max Stock'),
                  keyboardType: TextInputType.number,
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _minStockController,
                        decoration: InputDecoration(labelText: 'Min Stock'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _maxStockController,
                        decoration: InputDecoration(labelText: 'Max Stock'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              TextFormField(
                controller: _vendorController,
                decoration: InputDecoration(
                  labelText: 'Vendor',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              
              if (isMobile) ...[
                DropdownButtonFormField(
                  value: _selectedType,
                  items: ['Storable', 'Consumable', 'Service'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                  decoration: InputDecoration(labelText: 'Product Type'),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField(
                  value: _selectedTracking,
                  items: ['None', 'Lot', 'Serial'].map((tracking) {
                    return DropdownMenuItem(value: tracking, child: Text(tracking));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedTracking = value!),
                  decoration: InputDecoration(labelText: 'Tracking'),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedType,
                        items: ['Storable', 'Consumable', 'Service'].map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedType = value!),
                        decoration: InputDecoration(labelText: 'Product Type'),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedTracking,
                        items: ['None', 'Lot', 'Serial'].map((tracking) {
                          return DropdownMenuItem(value: tracking, child: Text(tracking));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedTracking = value!),
                        decoration: InputDecoration(labelText: 'Tracking'),
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              TextFormField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  labelText: 'Barcode (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              
              SizedBox(height: _responsiveValue(context, mobile: 8, tablet: 12)),
              
              if (isMobile) ...[
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _dimensionsController,
                  decoration: InputDecoration(labelText: 'Dimensions'),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        decoration: InputDecoration(labelText: 'Weight (kg)'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _dimensionsController,
                        decoration: InputDecoration(labelText: 'Dimensions'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Inventory Transfer Form
class InventoryTransferForm extends StatefulWidget {
  final Map<String, dynamic>? initialProduct;
  final Function(Map<String, dynamic>) onTransferCreated;
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> warehouses;

  const InventoryTransferForm({
    super.key,
    this.initialProduct,
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
  void initState() {
    super.initState();
    if (widget.initialProduct != null) {
      _selectedProduct = widget.initialProduct!['id'];
    }
  }

  double _responsiveValue(BuildContext context, {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      padding: EdgeInsets.all(_responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Create Transfer', style: TextStyle(
            fontFamily: 'Cairo', 
            fontSize: _responsiveValue(context, mobile: 18, tablet: 20, desktop: 22),
            fontWeight: FontWeight.bold
          )),
          SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: _selectedType,
                  items: ['Internal Transfer', 'Receipt', 'Delivery'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                  decoration: InputDecoration(
                    labelText: 'Transfer Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
                DropdownButtonFormField(
                  value: _selectedProduct,
                  items: widget.products.map((product) {
                    return DropdownMenuItem(
                      value: product['id'],
                      child: Text('${product['name']} (${product['sku']})'),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                  decoration: InputDecoration(
                    labelText: 'Product',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null ? 'Required' : null,
                ),
                SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
                
                if (isMobile) ...[
                  DropdownButtonFormField(
                    value: _selectedFromLocation,
                    items: widget.warehouses.map((warehouse) {
                      return DropdownMenuItem(
                        value: warehouse['id'],
                        child: Text(warehouse['name']),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedFromLocation = value! as String?),
                    decoration: InputDecoration(
                      labelText: 'From Location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null ? 'Required' : null,
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField(
                    value: _selectedToLocation,
                    items: widget.warehouses.map((warehouse) {
                      return DropdownMenuItem(
                        value: warehouse['id'],
                        child: Text(warehouse['name']),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedToLocation = value! as String?),
                    decoration: InputDecoration(
                      labelText: 'To Location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null ? 'Required' : null,
                  ),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          value: _selectedFromLocation,
                          items: widget.warehouses.map((warehouse) {
                            return DropdownMenuItem(
                              value: warehouse['id'],
                              child: Text(warehouse['name']),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => _selectedFromLocation = value! as String?),
                          decoration: InputDecoration(
                            labelText: 'From Location',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value == null ? 'Required' : null,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField(
                          value: _selectedToLocation,
                          items: widget.warehouses.map((warehouse) {
                            return DropdownMenuItem(
                              value: warehouse['id'],
                              child: Text(warehouse['name']),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => _selectedToLocation = value! as String?),
                          decoration: InputDecoration(
                            labelText: 'To Location',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value == null ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                ],
                
                SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    labelText: 'Notes (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: _responsiveValue(context, mobile: 20, tablet: 24, desktop: 28)),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: _responsiveValue(context, mobile: 12, tablet: 16)),
                  ),
                  child: Text('Cancel', style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                  )),
                ),
              ),
              SizedBox(width: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              Expanded(
                child: ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: _responsiveValue(context, mobile: 12, tablet: 16)),
                  ),
                  child: Text('Create Transfer', style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(context, mobile: 14, tablet: 16)
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Receive Items Dialog
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

  double _responsiveValue(BuildContext context, {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    
    return ResponsiveDialog(
      title: 'Receive Items',
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
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                value: _selectedProduct,
                items: widget.products.map((product) {
                  return DropdownMenuItem(
                    value: product['id'],
                    child: Text('${product['name']} (${product['sku']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                decoration: InputDecoration(
                  labelText: 'Product',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              DropdownButtonFormField(
                value: _selectedWarehouse,
                items: widget.warehouses.map((warehouse) {
                  return DropdownMenuItem(
                    value: warehouse['id'],
                    child: Text(warehouse['name']),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedWarehouse = value! as String?),
                decoration: InputDecoration(
                  labelText: 'Warehouse',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              TextFormField(
                controller: _purchaseOrderController,
                decoration: InputDecoration(
                  labelText: 'Purchase Order (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Stock Adjustment Dialog
class StockAdjustmentDialog extends StatefulWidget {
  final Map<String, dynamic>? product;
  final Function(Map<String, dynamic>) onAdjustmentCreated;
  final List<Map<String, dynamic>> products;

  const StockAdjustmentDialog({
    super.key,
    this.product,
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
  void initState() {
    super.initState();
    if (widget.product != null) {
      _selectedProduct = widget.product!['id'];
    }
  }

  double _responsiveValue(BuildContext context, {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return ResponsiveDialog(
      title: 'Stock Adjustment',
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
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                value: _selectedProduct,
                items: widget.products.map((product) {
                  return DropdownMenuItem(
                    value: product['id'],
                    child: Text('${product['name']} (Current: ${product['quantity']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                decoration: InputDecoration(
                  labelText: 'Product',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              
              if (isMobile) ...[
                DropdownButtonFormField(
                  value: _adjustmentType,
                  items: ['Increase', 'Decrease'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => _adjustmentType = value!),
                  decoration: InputDecoration(labelText: 'Adjustment Type'),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  value: _selectedReason,
                  items: ['Damaged', 'Found', 'Counting Error', 'Theft', 'Other'].map((reason) {
                    return DropdownMenuItem(value: reason, child: Text(reason));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedReason = value!),
                  decoration: InputDecoration(labelText: 'Reason'),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _adjustmentType,
                        items: ['Increase', 'Decrease'].map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) => setState(() => _adjustmentType = value!),
                        decoration: InputDecoration(labelText: 'Adjustment Type'),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedReason,
                        items: ['Damaged', 'Found', 'Counting Error', 'Theft', 'Other'].map((reason) {
                          return DropdownMenuItem(value: reason, child: Text(reason));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedReason = value!),
                        decoration: InputDecoration(labelText: 'Reason'),
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Additional Details (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Create Purchase Order Dialog
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

  double _responsiveValue(BuildContext context, {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialog(
      title: 'Create Purchase Order',
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.inventory_2),
              title: Text('Product: ${widget.alert['product']}', style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Text('Vendor: ${widget.alert['vendor']}', style: TextStyle(fontFamily: 'Cairo')),
            ),
            SizedBox(height: _responsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
            TextFormField(
              controller: _unitPriceController,
              decoration: InputDecoration(
                labelText: 'Unit Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'Notes (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

// Scrap Return Dialog
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

  double _responsiveValue(BuildContext context, {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return ResponsiveDialog(
      title: 'Scrap/Return Management',
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
                  content: Text('${_selectedType} record created successfully!', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: Text('Create Record', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMobile) ...[
                DropdownButtonFormField(
                  value: _selectedType,
                  items: ['Scrap', 'Return'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                  decoration: InputDecoration(labelText: 'Type'),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  value: _selectedStatus,
                  items: ['Pending Inspection', 'Approved', 'Completed'].map((status) {
                    return DropdownMenuItem(value: status, child: Text(status));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedStatus = value!),
                  decoration: InputDecoration(labelText: 'Status'),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedType,
                        items: ['Scrap', 'Return'].map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedType = value!),
                        decoration: InputDecoration(labelText: 'Type'),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedStatus,
                        items: ['Pending Inspection', 'Approved', 'Completed'].map((status) {
                          return DropdownMenuItem(value: status, child: Text(status));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedStatus = value!),
                        decoration: InputDecoration(labelText: 'Status'),
                      ),
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              DropdownButtonFormField(
                value: _selectedProduct,
                items: widget.products.map((product) {
                  return DropdownMenuItem(
                    value: product['id'],
                    child: Text('${product['name']} (${product['sku']})'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedProduct = value! as String?),
                decoration: InputDecoration(
                  labelText: 'Product',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              DropdownButtonFormField(
                value: _selectedWarehouse,
                items: widget.warehouses.map((warehouse) {
                  return DropdownMenuItem(
                    value: warehouse['id'],
                    child: Text(warehouse['name']),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedWarehouse = value! as String?),
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: _responsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Filter Dialog
class FilterDialog extends StatefulWidget {
  final Function(String) onFilterApplied;

  const FilterDialog({super.key, required this.onFilterApplied});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialog(
      title: 'Filter Products',
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onFilterApplied(_selectedFilter);
            Navigator.pop(context);
          },
          child: Text('Apply Filter', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: Text('All Products', style: TextStyle(fontFamily: 'Cairo')),
            value: 'All',
            groupValue: _selectedFilter,
            onChanged: (value) => setState(() => _selectedFilter = value!),
          ),
          RadioListTile(
            title: Text('Low Stock', style: TextStyle(fontFamily: 'Cairo')),
            value: 'Low Stock',
            groupValue: _selectedFilter,
            onChanged: (value) => setState(() => _selectedFilter = value!),
          ),
          RadioListTile(
            title: Text('Electronics', style: TextStyle(fontFamily: 'Cairo')),
            value: 'Electronics',
            groupValue: _selectedFilter,
            onChanged: (value) => setState(() => _selectedFilter = value!),
          ),
          RadioListTile(
            title: Text('Furniture', style: TextStyle(fontFamily: 'Cairo')),
            value: 'Furniture',
            groupValue: _selectedFilter,
            onChanged: (value) => setState(() => _selectedFilter = value!),
          ),
          RadioListTile(
            title: Text('Stationery', style: TextStyle(fontFamily: 'Cairo')),
            value: 'Stationery',
            groupValue: _selectedFilter,
            onChanged: (value) => setState(() => _selectedFilter = value!),
          ),
        ],
      ),
    );
  }
}