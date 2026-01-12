import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';

// Data models for VAT
class VATData {
  final String period;
  final double outputTax;
  final double inputTax;
  final double netVAT;

  VATData(this.period, this.outputTax, this.inputTax, this.netVAT);
}

class VATTransaction {
  final String id;
  final String type;
  final String partner;
  final DateTime date;
  final double amount;
  final double vatAmount;
  final String status;
  final String vatRate;

  VATTransaction({
    required this.id,
    required this.type,
    required this.partner,
    required this.date,
    required this.amount,
    required this.vatAmount,
    required this.status,
    required this.vatRate,
  });
}

class PieData {
  final String category;
  final double value;
  final Color color;

  PieData(this.category, this.value, this.color);
}

class ValueAddedTaxPage extends StatefulWidget {
  const ValueAddedTaxPage({super.key, UserModel? user});

  @override
  State<ValueAddedTaxPage> createState() => _ValueAddedTaxPageState();
}

class _ValueAddedTaxPageState extends State<ValueAddedTaxPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // VAT Dashboard Data
  final List<Map<String, dynamic>> _vatKPIs = [
    {
      'title': 'VAT Collected',
      'value': '\$45,820',
      'change': '+12%',
      'icon': Icons.arrow_upward,
      'color': Colors.green,
      'trend': 'up'
    },
    {
      'title': 'VAT Paid',
      'value': '\$32,150',
      'change': '+8%',
      'icon': Icons.arrow_downward,
      'color': ThemeCollection.matisse,
      'trend': 'up'
    },
    {
      'title': 'Net VAT Payable',
      'value': '\$13,670',
      'change': '+15%',
      'icon': Icons.account_balance,
      'color': ThemeCollection.diSerria,
      'trend': 'up'
    },
    {
      'title': 'VAT Invoices',
      'value': '1,247',
      'change': '+5%',
      'icon': Icons.receipt,
      'color': Colors.purple,
      'trend': 'up'
    },
  ];

  final List<VATData> _vatTrends = [
    VATData('Jan', 42000, 35000, 7000),
    VATData('Feb', 45000, 32000, 13000),
    VATData('Mar', 48000, 38000, 10000),
    VATData('Apr', 52000, 42000, 10000),
    VATData('May', 55000, 45000, 10000),
    VATData('Jun', 58000, 44000, 14000),
  ];

  final List<PieData> _vatByType = [
    PieData('Standard Rate (15%)', 65, ThemeCollection.matisse),
    PieData('Zero Rate', 20, Colors.green),
    PieData('Exempt', 10, ThemeCollection.diSerria),
    PieData('Reverse Charge', 5, Colors.purple),
  ];

  final List<VATTransaction> _vatTransactions = [
    VATTransaction(
      id: 'INV-001',
      type: 'Sales',
      partner: 'Customer A',
      date: DateTime.now().subtract(const Duration(days: 2)),
      amount: 10000,
      vatAmount: 1500,
      status: 'Paid',
      vatRate: '15%',
    ),
    VATTransaction(
      id: 'BILL-001',
      type: 'Purchase',
      partner: 'Supplier X',
      date: DateTime.now().subtract(const Duration(days: 3)),
      amount: 8000,
      vatAmount: 1200,
      status: 'Paid',
      vatRate: '15%',
    ),
    VATTransaction(
      id: 'INV-002',
      type: 'Sales',
      partner: 'Customer B',
      date: DateTime.now().subtract(const Duration(days: 5)),
      amount: 15000,
      vatAmount: 2250,
      status: 'Pending',
      vatRate: '15%',
    ),
    VATTransaction(
      id: 'BILL-002',
      type: 'Purchase',
      partner: 'Supplier Y',
      date: DateTime.now().subtract(const Duration(days: 7)),
      amount: 12000,
      vatAmount: 1800,
      status: 'Paid',
      vatRate: '15%',
    ),
  ];

  // Filters
  DateTime _selectedFromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _selectedToDate = DateTime.now();
  String _selectedVATRate = 'All';
  String _selectedTransactionType = 'All';
  String _selectedStatus = 'All';
  bool _autoRefresh = true;

  // VAT Configuration
  final List<Map<String, dynamic>> _vatRates = [
    {'rate': '15%', 'type': 'Standard', 'description': 'Standard VAT Rate'},
    {'rate': '0%', 'type': 'Zero', 'description': 'Zero Rated Supplies'},
    {'rate': 'Exempt', 'type': 'Exempt', 'description': 'Exempt from VAT'},
    {'rate': 'Reverse', 'type': 'Reverse', 'description': 'Reverse Charge'},
  ];

  final List<Map<String, dynamic>> _vatSettings = [
    {'key': 'TRN', 'value': '123456789012345', 'editable': true},
    {'key': 'Tax Period', 'value': 'Monthly', 'editable': true},
    {'key': 'Filing Deadline', 'value': '28th of following month', 'editable': false},
    {'key': 'Currency', 'value': 'SAR', 'editable': true},
  ];

  // Tab categories
  final List<String> _vatTabs = [
    'Dashboard',
    'VAT Return',
    'Sales VAT',
    'Purchase VAT',
    'Reports',
    'Configuration',
    'Audit'
  ];

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Responsive value helper
  T _responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  int _getCrossAxisCount() {
    return _responsiveValue(
      mobile: 2,
      tablet: 4,
      desktop: 4,
    );
  }

  double _getChartHeight() {
    return _responsiveValue(
      mobile: 250,
      tablet: 300,
      desktop: 350,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _vatTabs.length, vsync: this);
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

  // Core VAT Functions
  void _generateVATReturn() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Generate VAT Return', 
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ThemeCollection.matisse)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.description, size: 48, color: ThemeCollection.matisse.withOpacity(0.7)),
            const SizedBox(height: 16),
            Text('Generate VAT return for the selected period?', 
              style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text('${DateFormat('MMM dd, yyyy').format(_selectedFromDate)} - ${DateFormat('MMM dd, yyyy').format(_selectedToDate)}', 
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ThemeCollection.matisse)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', 
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.jumbo)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showVATReturnProgress();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeCollection.matisse,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Generate', 
              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showVATReturnProgress() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeCollection.matisse)),
              const SizedBox(height: 20),
              Text('Generating VAT Return...', 
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ThemeCollection.matisse)),
              const SizedBox(height: 8),
              Text('Calculating tax liabilities and credits', 
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      _showVATReturnResult();
    });
  }

  void _showVATReturnResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('VAT Return Generated', 
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ThemeCollection.matisse)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 48, color: Colors.green),
            const SizedBox(height: 16),
            Text('VAT Return Summary', 
              style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildVATReturnSummary(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', 
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.jumbo)),
          ),
          ElevatedButton(
            onPressed: () => _exportVATReturn('PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeCollection.matisse,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Export', 
              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildVATReturnSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Total Sales VAT', '\$45,820'),
          _buildSummaryRow('Total Purchase VAT', '\$32,150'),
          _buildSummaryRow('Net VAT Payable', '\$13,670', isTotal: true),
          _buildSummaryRow('Due Date', DateFormat('MMM dd, yyyy').format(DateTime.now().add(const Duration(days: 15)))),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, 
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            )),
          Text(value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: isTotal ? ThemeCollection.matisse : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            )),
        ],
      ),
    );
  }

  void _exportVATReturn(String format) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeCollection.matisse)),
              const SizedBox(height: 20),
              Text('Exporting VAT Return...', 
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ThemeCollection.matisse)),
              const SizedBox(height: 8),
              Text('Format: $format', 
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
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
              Text('VAT Return exported as $format successfully!', 
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
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
          data: Theme.of(context).brightness == Brightness.dark 
              ? ThemeData.dark().copyWith(
                  primaryColor: ThemeCollection.matisse,
                  colorScheme: const ColorScheme.dark(primary: ThemeCollection.matisse),
                  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                )
              : ThemeData.light().copyWith(
                  primaryColor: ThemeCollection.matisse,
                  colorScheme: const ColorScheme.light(primary: ThemeCollection.matisse),
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

  void _showVATSettings() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('VAT Settings', 
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ThemeCollection.matisse)),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._vatSettings.map((setting) => _buildSettingRow(setting, setState)),
                  const SizedBox(height: 16),
                  Divider(color: ThemeCollection.matisse.withOpacity(0.2)),
                  const SizedBox(height: 16),
                  Text('VAT Rates', 
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ThemeCollection.matisse)),
                  ..._vatRates.map((rate) => _buildVATRateRow(rate)),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.jumbo)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('VAT settings updated successfully!', style: Theme.of(context).textTheme.bodyMedium),
                    backgroundColor: ThemeCollection.matisse,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: ThemeCollection.matisse),
              child: Text('Save', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(Map<String, dynamic> setting, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(setting['key'], 
              style: Theme.of(context).textTheme.bodyMedium),
          ),
          Expanded(
            flex: 3,
            child: setting['editable'] 
                ? TextFormField(
                    initialValue: setting['value'],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: ThemeCollection.matisse),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : Text(setting['value'], 
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.jumbo)),
          ),
        ],
      ),
    );
  }

  Widget _buildVATRateRow(Map<String, dynamic> rate) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: ThemeCollection.matisse.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(rate['rate'], 
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ThemeCollection.matisse,
                fontWeight: FontWeight.bold,
              )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rate['type'], 
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                Text(rate['description'], 
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 18, color: ThemeCollection.matisse),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void _addVATTransaction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAddTransactionSheet(),
    );
  }

  Widget _buildAddTransactionSheet() {
    return Container(
      padding: EdgeInsets.all(_responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
          Text('Add VAT Transaction', 
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ThemeCollection.matisse)),
          const SizedBox(height: 16),
          _buildFormField('Transaction Type', Icons.receipt),
          const SizedBox(height: 12),
          _buildFormField('Partner', Icons.person),
          const SizedBox(height: 12),
          _buildFormField('Amount', Icons.attach_money),
          const SizedBox(height: 12),
          _buildFormField('VAT Rate', Icons.percent),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ThemeCollection.matisse),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: _responsiveValue(mobile: 12, tablet: 14, desktop: 16)),
                  ),
                  child: Text('Cancel', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('VAT transaction added successfully!', style: Theme.of(context).textTheme.bodyMedium),
                        backgroundColor: ThemeCollection.matisse,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeCollection.matisse,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: _responsiveValue(mobile: 12, tablet: 14, desktop: 16)),
                  ),
                  child: Text('Add', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
          SizedBox(height: _responsiveValue(mobile: 20, tablet: 24, desktop: 28)),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse),
        prefixIcon: Icon(icon, color: ThemeCollection.matisse),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeCollection.matisse),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeCollection.matisse, width: 2),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 2,
        shadowColor: ThemeCollection.matisse.withOpacity(0.1),
        title: Text(
          'Value Added Tax (VAT)',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: ThemeCollection.matisse,
            fontWeight: FontWeight.bold,
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
              child: Icon(Icons.settings, color: ThemeCollection.matisse, size: 20),
            ),
            onPressed: _showVATSettings,
            tooltip: 'VAT Settings',
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
              if (value == 'generate_return') {
                _generateVATReturn();
              } else if (value == 'export_all') _exportVATReturn('Excel');
              else if (value == 'add_transaction') _addVATTransaction();
            },
            itemBuilder: (context) => [
              _buildPopupMenuItem('Generate VAT Return', 'generate_return', Icons.description),
              _buildPopupMenuItem('Export All Data', 'export_all', Icons.download),
              _buildPopupMenuItem('Add Transaction', 'add_transaction', Icons.add),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_responsiveValue(mobile: 80, tablet: 90, desktop: 100)),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _responsiveValue(mobile: 16, tablet: 20, desktop: 24),
                  vertical: _responsiveValue(mobile: 8, tablet: 10, desktop: 12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
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
                      hintText: 'Search VAT transactions...',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.jumbo),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: ThemeCollection.matisse),
                      suffixIcon: _searchQuery.isNotEmpty ? IconButton(
                        icon: Icon(Icons.clear, color: ThemeCollection.matisse),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      ) : null,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: _responsiveValue(mobile: 16, tablet: 20, desktop: 24),
                        vertical: _responsiveValue(mobile: 12, tablet: 14, desktop: 16),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              // Tab Bar
              TabBar(
                controller: _tabController,
                isScrollable: _responsiveValue(mobile: true, tablet: true, desktop: false),
                labelColor: ThemeCollection.matisse,
                unselectedLabelColor: ThemeCollection.matisse.withOpacity(0.5),
                indicatorColor: ThemeCollection.matisse,
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.symmetric(
                  horizontal: _responsiveValue(mobile: 8, tablet: 12, desktop: 16),
                ),
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _responsiveValue(mobile: 12, tablet: 14, desktop: 16),
                ),
                unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: _responsiveValue(mobile: 12, tablet: 14, desktop: 16),
                ),
                tabs: _vatTabs.map((tab) => Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: _responsiveValue(mobile: 8, tablet: 12, desktop: 16),
                      vertical: _responsiveValue(mobile: 4, tablet: 6, desktop: 8),
                    ),
                    child: Text(tab, textAlign: TextAlign.center),
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
                _buildVATDashboard(),
                _buildVATReturn(),
                _buildSalesVAT(),
                _buildPurchaseVAT(),
                _buildVATReports(),
                _buildVATConfiguration(),
                _buildVATAudit(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addVATTransaction,
        backgroundColor: ThemeCollection.matisse,
        child: Icon(Icons.add, color: Colors.white),
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
          Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse)),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
      child: _responsiveValue(
        mobile: _buildMobileFilterBar(),
        tablet: _buildTabletFilterBar(),
        desktop: _buildDesktopFilterBar(),
      ),
    );
  }

  Widget _buildMobileFilterBar() {
    return Column(
      children: [
        // Date Range
        InkWell(
          onTap: _showDateRangePicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
                    Text(
                      '${_selectedFromDate.day}/${_selectedFromDate.month}/${_selectedFromDate.year} - ${_selectedToDate.day}/${_selectedToDate.month}/${_selectedToDate.year}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ThemeCollection.matisse,
                        fontWeight: FontWeight.w600,
                      ),
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
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedVATRate,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  dropdownColor: Theme.of(context).cardColor,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ThemeCollection.matisse,
                    fontWeight: FontWeight.w600,
                  ),
                  items: ['All', 'Standard (15%)', 'Zero Rate', 'Exempt', 'Reverse Charge'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedVATRate = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
              ),
              child: IconButton(
                icon: Icon(Icons.filter_alt, color: ThemeCollection.matisse),
                onPressed: _showAdvancedFilters,
                tooltip: 'Advanced Filters',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletFilterBar() {
    return Row(
      children: [
        // Date Range
        Expanded(
          child: InkWell(
            onTap: _showDateRangePicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
                      Text(
                        '${_selectedFromDate.day}/${_selectedFromDate.month}/${_selectedFromDate.year} - ${_selectedToDate.day}/${_selectedToDate.month}/${_selectedToDate.year}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ThemeCollection.matisse,
                          fontWeight: FontWeight.w600,
                        ),
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
        
        // VAT Rate Filter
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
            ),
            child: DropdownButtonFormField<String>(
              initialValue: _selectedVATRate,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: InputBorder.none,
                isDense: true,
              ),
              dropdownColor: Theme.of(context).cardColor,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ThemeCollection.matisse,
                fontWeight: FontWeight.w600,
              ),
              items: ['All', 'Standard (15%)', 'Zero Rate', 'Exempt', 'Reverse Charge'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedVATRate = value!;
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Advanced Filters
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
                Text('Filters', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.matisse)),
              ],
            ),
            onPressed: _showAdvancedFilters,
            tooltip: 'Advanced Filters',
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopFilterBar() {
    return Row(
      children: [
        // Date Range
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: _showDateRangePicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.jumbo)),
                      Text(
                        '${_selectedFromDate.day}/${_selectedFromDate.month}/${_selectedFromDate.year} - ${_selectedToDate.day}/${_selectedToDate.month}/${_selectedToDate.year}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ThemeCollection.matisse,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeCollection.matisse.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.calendar_today, size: 20, color: ThemeCollection.matisse),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // VAT Rate Filter
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
            ),
            child: DropdownButtonFormField<String>(
              initialValue: _selectedVATRate,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                border: InputBorder.none,
                isDense: true,
              ),
              dropdownColor: Theme.of(context).cardColor,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ThemeCollection.matisse,
                fontWeight: FontWeight.w600,
              ),
              items: ['All', 'Standard (15%)', 'Zero Rate', 'Exempt', 'Reverse Charge'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ThemeCollection.matisse)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedVATRate = value!;
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Transaction Type Filter
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ThemeCollection.matisse.withOpacity(0.3)),
            ),
            child: DropdownButtonFormField<String>(
              initialValue: _selectedTransactionType,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                border: InputBorder.none,
                isDense: true,
              ),
              dropdownColor: Theme.of(context).cardColor,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ThemeCollection.matisse,
                fontWeight: FontWeight.w600,
              ),
              items: ['All', 'Sales', 'Purchase', 'Credit Note', 'Debit Note'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ThemeCollection.matisse)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTransactionType = value!;
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Advanced Filters
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
                Icon(Icons.filter_alt, color: ThemeCollection.matisse, size: 24),
                const SizedBox(width: 8),
                Text('Advanced Filters', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ThemeCollection.matisse)),
              ],
            ),
            onPressed: _showAdvancedFilters,
            tooltip: 'Advanced Filters',
          ),
        ),
      ],
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

  Widget _buildAdvancedFiltersSheet() {
    return Container(
      padding: EdgeInsets.all(_responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ThemeCollection.matisse)),
          const SizedBox(height: 16),
          
          // Transaction Type
          DropdownButtonFormField(
            initialValue: _selectedTransactionType,
            decoration: InputDecoration(
              labelText: 'Transaction Type',
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ThemeCollection.matisse),
              ),
            ),
            dropdownColor: Theme.of(context).cardColor,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse),
            items: ['All', 'Sales', 'Purchase', 'Credit Note', 'Debit Note'].map((type) => 
              DropdownMenuItem(value: type, child: Text(type, style: Theme.of(context).textTheme.bodyMedium))).toList(),
            onChanged: (value) => setState(() => _selectedTransactionType = value!),
          ),
          const SizedBox(height: 12),
          
          // Status
          DropdownButtonFormField(
            initialValue: _selectedStatus,
            decoration: InputDecoration(
              labelText: 'Status',
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ThemeCollection.matisse),
              ),
            ),
            dropdownColor: Theme.of(context).cardColor,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse),
            items: ['All', 'Paid', 'Pending', 'Overdue', 'Draft'].map((status) => 
              DropdownMenuItem(value: status, child: Text(status, style: Theme.of(context).textTheme.bodyMedium))).toList(),
            onChanged: (value) => setState(() => _selectedStatus = value!),
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
                    padding: EdgeInsets.symmetric(vertical: _responsiveValue(mobile: 12, tablet: 14, desktop: 16)),
                  ),
                  child: Text('Cancel', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.matisse)),
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
                    padding: EdgeInsets.symmetric(vertical: _responsiveValue(mobile: 12, tablet: 14, desktop: 16)),
                  ),
                  child: Text('Apply Filters', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _applyAdvancedFilters() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.filter_alt, color: Colors.white),
            const SizedBox(width: 8),
            Text('Advanced filters applied!', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
          ],
        ),
        backgroundColor: ThemeCollection.matisse,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Main Tab Content Builders
  Widget _buildVATDashboard() {
    return RefreshIndicator(
      onRefresh: () async => _refreshData(),
      backgroundColor: ThemeCollection.matisse,
      color: Colors.white,
      displacement: 40,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
        child: Column(
          children: [
            // KPI Cards
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(),
                crossAxisSpacing: _responsiveValue(mobile: 12, tablet: 16, desktop: 20),
                mainAxisSpacing: _responsiveValue(mobile: 12, tablet: 16, desktop: 20),
                childAspectRatio: _responsiveValue(mobile: 1.1, tablet: 1.2, desktop: 1.3),
              ),
              itemCount: _vatKPIs.length,
              itemBuilder: (context, index) => _buildKPICard(_vatKPIs[index]),
            ),
            SizedBox(height: _responsiveValue(mobile: 16, tablet: 20, desktop: 24)),

            // Charts Section
            _buildChartsSection(),

            SizedBox(height: _responsiveValue(mobile: 16, tablet: 20, desktop: 24)),

            // Recent Transactions
            _buildRecentTransactions(),

            SizedBox(height: _responsiveValue(mobile: 16, tablet: 20, desktop: 24)),

            // VAT Deadlines
            _buildVATDeadlines(),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard(Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
        padding: EdgeInsets.all(_responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(_responsiveValue(mobile: 8, tablet: 10, desktop: 12)),
                  decoration: BoxDecoration(
                    color: data['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(data['icon'] as IconData, color: data['color'], 
                    size: _responsiveValue(mobile: 20, tablet: 24, desktop: 28)),
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
                        size: _responsiveValue(mobile: 12, tablet: 14, desktop: 16),
                        color: data['trend'] == 'up' ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(data['change'], 
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: data['trend'] == 'up' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: _responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
            Text(data['title'], 
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ThemeCollection.jumbo,
                fontWeight: FontWeight.w500,
              )),
            SizedBox(height: _responsiveValue(mobile: 4, tablet: 6, desktop: 8)),
            Text(data['value'], 
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: ThemeCollection.matisse,
                fontSize: _responsiveValue(mobile: 18, tablet: 20, desktop: 24),
              )),
            SizedBox(height: _responsiveValue(mobile: 8, tablet: 10, desktop: 12)),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
        color: Theme.of(context).cardColor,
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
        padding: EdgeInsets.all(_responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('VAT Overview', 
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ThemeCollection.matisse,
                fontWeight: FontWeight.bold,
              )),
            SizedBox(height: _responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
            _responsiveValue(
              mobile: Column(
                children: [
                  _buildVATTrendChart(),
                  const SizedBox(height: 16),
                  _buildVATDistributionChart(),
                ],
              ),
              tablet: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildVATTrendChart(),
                  ),
                  SizedBox(width: _responsiveValue(mobile: 0, tablet: 16, desktop: 20)),
                  Expanded(
                    flex: 1,
                    child: _buildVATDistributionChart(),
                  ),
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildVATTrendChart(),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: _buildVATDistributionChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVATTrendChart() {
    return Container(
      height: _getChartHeight(),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: SfCartesianChart(
        margin: EdgeInsets.all(_responsiveValue(mobile: 8, tablet: 12, desktop: 16)),
        primaryXAxis: CategoryAxis(
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          axisLine: AxisLine(color: ThemeCollection.matisse.withOpacity(0.3)),
        ),
        primaryYAxis: NumericAxis(
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          axisLine: AxisLine(color: ThemeCollection.matisse.withOpacity(0.3)),
          numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
        ),
        series: <CartesianSeries<VATData, String>>[
          LineSeries<VATData, String>(
            dataSource: _vatTrends,
            xValueMapper: (VATData data, _) => data.period,
            yValueMapper: (VATData data, _) => data.outputTax,
            name: 'Output Tax',
            color: ThemeCollection.matisse,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
          LineSeries<VATData, String>(
            dataSource: _vatTrends,
            xValueMapper: (VATData data, _) => data.period,
            yValueMapper: (VATData data, _) => data.inputTax,
            name: 'Input Tax',
            color: ThemeCollection.diSerria,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
          LineSeries<VATData, String>(
            dataSource: _vatTrends,
            xValueMapper: (VATData data, _) => data.period,
            yValueMapper: (VATData data, _) => data.netVAT,
            name: 'Net VAT',
            color: Colors.green,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: Legend(
          isVisible: _responsiveValue(mobile: false, tablet: true, desktop: true),
          position: LegendPosition.top,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  Widget _buildVATDistributionChart() {
    return Container(
      height: _getChartHeight(),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: SfCircularChart(
        margin: EdgeInsets.all(_responsiveValue(mobile: 8, tablet: 12, desktop: 16)),
        series: <CircularSeries>[
          PieSeries<PieData, String>(
            dataSource: _vatByType,
            xValueMapper: (PieData data, _) => data.category,
            yValueMapper: (PieData data, _) => data.value,
            dataLabelMapper: (PieData data, _) => '${data.value}%',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: Theme.of(context).textTheme.bodySmall!,
            ),
            pointColorMapper: (PieData data, _) => data.color,
            explode: true,
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final filteredTransactions = _vatTransactions.where((transaction) {
      if (_searchQuery.isNotEmpty) {
        return transaction.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               transaction.partner.toLowerCase().contains(_searchQuery.toLowerCase());
      }
      return true;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
        padding: EdgeInsets.all(_responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent VAT Transactions', 
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ThemeCollection.matisse,
                    fontWeight: FontWeight.bold,
                  )),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ThemeCollection.matisse.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.download, color: ThemeCollection.matisse, size: 18),
                  ),
                  onPressed: () => _exportVATReturn('CSV'),
                ),
              ],
            ),
            SizedBox(height: _responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
            ...filteredTransactions.map((transaction) => _buildTransactionCard(transaction)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(VATTransaction transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(_responsiveValue(mobile: 8, tablet: 10, desktop: 12)),
            decoration: BoxDecoration(
              color: transaction.type == 'Sales' 
                  ? Colors.green.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.type == 'Sales' ? Icons.arrow_upward : Icons.arrow_downward,
              color: transaction.type == 'Sales' ? Colors.green : Colors.blue,
              size: _responsiveValue(mobile: 18, tablet: 20, desktop: 24),
            ),
          ),
          SizedBox(width: _responsiveValue(mobile: 8, tablet: 12, desktop: 16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.id, 
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeCollection.matisse,
                  )),
                SizedBox(height: _responsiveValue(mobile: 2, tablet: 4, desktop: 6)),
                Text(transaction.partner, 
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
                SizedBox(height: _responsiveValue(mobile: 2, tablet: 4, desktop: 6)),
                Text(DateFormat('MMM dd, yyyy').format(transaction.date), 
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${transaction.amount}', 
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ThemeCollection.matisse,
                )),
              SizedBox(height: _responsiveValue(mobile: 2, tablet: 4, desktop: 6)),
              Text('VAT: \$${transaction.vatAmount}', 
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
              SizedBox(height: _responsiveValue(mobile: 4, tablet: 6, desktop: 8)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: transaction.status == 'Paid' 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(transaction.status, 
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: transaction.status == 'Paid' ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVATDeadlines() {
    final deadlines = [
      {'period': 'Q1 2024', 'dueDate': 'Apr 28, 2024', 'status': 'Submitted', 'color': Colors.green},
      {'period': 'Q2 2024', 'dueDate': 'Jul 28, 2024', 'status': 'Upcoming', 'color': Colors.orange},
      {'period': 'Q3 2024', 'dueDate': 'Oct 28, 2024', 'status': 'Pending', 'color': Colors.blue},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
        padding: EdgeInsets.all(_responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('VAT Filing Deadlines', 
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ThemeCollection.matisse,
                fontWeight: FontWeight.bold,
              )),
            SizedBox(height: _responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
            ...deadlines.map((deadline) => _buildDeadlineCard(deadline)),
          ],
        ),
      ),
    );
  }

  Widget _buildDeadlineCard(Map<String, dynamic> deadline) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeCollection.matisse.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(_responsiveValue(mobile: 8, tablet: 10, desktop: 12)),
            decoration: BoxDecoration(
              color: deadline['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.calendar_today, color: deadline['color'], 
              size: _responsiveValue(mobile: 18, tablet: 20, desktop: 24)),
          ),
          SizedBox(width: _responsiveValue(mobile: 8, tablet: 12, desktop: 16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deadline['period'], 
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeCollection.matisse,
                  )),
                SizedBox(height: _responsiveValue(mobile: 2, tablet: 4, desktop: 6)),
                Text('Due: ${deadline['dueDate']}', 
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ThemeCollection.jumbo)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: deadline['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(deadline['status'], 
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: deadline['color'],
                fontWeight: FontWeight.bold,
              )),
          ),
        ],
      ),
    );
  }

  // Other tab content methods (simplified for brevity)
  Widget _buildVATReturn() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        children: [
          _buildSectionCard(
            'VAT Return Preparation',
            'Prepare and submit your VAT return for the selected period',
            Icons.description,
            _generateVATReturn,
          ),
          SizedBox(height: _responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
          _buildVATReturnSummary(),
        ],
      ),
    );
  }

  Widget _buildSalesVAT() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        children: [
          _buildSectionCard(
            'Sales VAT Summary',
            'View VAT collected from customers and sales transactions',
            Icons.trending_up,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseVAT() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        children: [
          _buildSectionCard(
            'Purchase VAT Summary',
            'View VAT paid to suppliers and purchase transactions',
            Icons.trending_down,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVATReports() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        children: [
          _buildSectionCard(
            'VAT Audit Report',
            'Generate comprehensive VAT audit reports',
            Icons.assessment,
            () => _exportVATReturn('PDF'),
          ),
          SizedBox(height: _responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
          _buildSectionCard(
            'VAT Reconciliation',
            'Reconcile VAT accounts with general ledger',
            Icons.compare_arrows,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVATConfiguration() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        children: [
          _buildSectionCard(
            'VAT Settings',
            'Configure VAT rates, periods, and company information',
            Icons.settings,
            _showVATSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildVATAudit() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(_responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
      child: Column(
        children: [
          _buildSectionCard(
            'VAT Audit Trail',
            'View complete audit trail of VAT transactions',
            Icons.history,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, String description, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(_responsiveValue(mobile: 16, tablet: 20, desktop: 24)),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ThemeCollection.matisse.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(_responsiveValue(mobile: 10, tablet: 12, desktop: 14)),
              decoration: BoxDecoration(
                color: ThemeCollection.matisse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: ThemeCollection.matisse, 
                size: _responsiveValue(mobile: 20, tablet: 24, desktop: 28)),
            ),
            SizedBox(width: _responsiveValue(mobile: 12, tablet: 16, desktop: 20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, 
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: ThemeCollection.matisse,
                      fontWeight: FontWeight.bold,
                    )),
                  SizedBox(height: _responsiveValue(mobile: 4, tablet: 6, desktop: 8)),
                  Text(description, 
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ThemeCollection.jumbo)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: ThemeCollection.matisse, 
              size: _responsiveValue(mobile: 14, tablet: 16, desktop: 18)),
          ],
        ),
      ),
    );
  }

  void _refreshData({bool silent = false}) {
    if (!silent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.refresh, color: Colors.white),
              const SizedBox(width: 8),
              Text('VAT data refreshed successfully!', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
            ],
          ),
          backgroundColor: ThemeCollection.matisse,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }
}