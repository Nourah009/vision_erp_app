import 'package:flutter/material.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';


class AccountingPage extends StatefulWidget {
  final UserModel? user;
  
  const AccountingPage({super.key, this.user});

  @override
  State<AccountingPage> createState() => _AccountingPageState();
}

class _AccountingPageState extends State<AccountingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample financial data
  final Map<String, dynamic> _financialSummary = {
    'cashBalance': 125000.00,
    'accountsReceivable': 75000.00,
    'accountsPayable': 45000.00,
    'netProfit': 35000.00,
    'totalRevenue': 200000.00,
    'totalExpenses': 165000.00,
    'currentAssets': 250000.00,
    'currentLiabilities': 80000.00,
  };

  // Sample transactions
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'T001',
      'date': '2024-01-15',
      'description': 'Client Payment - Project Alpha',
      'account': 'Accounts Receivable',
      'debit': 0.0,
      'credit': 5000.0,
      'type': 'Revenue',
      'status': 'Completed'
    },
    {
      'id': 'T002',
      'date': '2024-01-14',
      'description': 'Office Rent',
      'account': 'Rent Expense',
      'debit': 2000.0,
      'credit': 0.0,
      'type': 'Expense',
      'status': 'Completed'
    },
    {
      'id': 'T003',
      'date': '2024-01-13',
      'description': 'Software Subscription',
      'account': 'Software Expense',
      'debit': 300.0,
      'credit': 0.0,
      'type': 'Expense',
      'status': 'Completed'
    },
    {
      'id': 'T004',
      'date': '2024-01-12',
      'description': 'Consulting Revenue',
      'account': 'Service Revenue',
      'debit': 0.0,
      'credit': 7500.0,
      'type': 'Revenue',
      'status': 'Pending'
    },
  ];

  // Sample invoices
  final List<Map<String, dynamic>> _invoices = [
    {
      'id': 'INV-001',
      'customer': 'Tech Solutions Ltd',
      'date': '2024-01-15',
      'dueDate': '2024-02-15',
      'amount': 15000.00,
      'status': 'Paid',
      'items': [
        {'description': 'Web Development', 'quantity': 1, 'price': 15000.00}
      ]
    },
    {
      'id': 'INV-002',
      'customer': 'Global Marketing Inc',
      'date': '2024-01-10',
      'dueDate': '2024-02-10',
      'amount': 8500.00,
      'status': 'Overdue',
      'items': [
        {'description': 'Digital Marketing', 'quantity': 1, 'price': 8500.00}
      ]
    },
    {
      'id': 'INV-003',
      'customer': 'StartUp Innovations',
      'date': '2024-01-08',
      'dueDate': '2024-02-08',
      'amount': 12000.00,
      'status': 'Pending',
      'items': [
        {'description': 'Mobile App Development', 'quantity': 1, 'price': 12000.00}
      ]
    },
  ];

  // Sample chart of accounts
  final List<Map<String, dynamic>> _chartOfAccounts = [
    {'code': '1000', 'name': 'Cash', 'type': 'Asset', 'balance': 125000.00},
    {'code': '1100', 'name': 'Accounts Receivable', 'type': 'Asset', 'balance': 75000.00},
    {'code': '1200', 'name': 'Inventory', 'type': 'Asset', 'balance': 50000.00},
    {'code': '2000', 'name': 'Accounts Payable', 'type': 'Liability', 'balance': 45000.00},
    {'code': '3000', 'name': 'Owner\'s Equity', 'type': 'Equity', 'balance': 150000.00},
    {'code': '4000', 'name': 'Service Revenue', 'type': 'Revenue', 'balance': 200000.00},
    {'code': '5000', 'name': 'Rent Expense', 'type': 'Expense', 'balance': 24000.00},
    {'code': '5100', 'name': 'Salary Expense', 'type': 'Expense', 'balance': 120000.00},
  ];

  // Sample financial reports
  final List<Map<String, dynamic>> _reports = [
    {
      'name': 'Profit & Loss Statement',
      'period': 'January 2024',
      'type': 'Income Statement',
      'generated': '2024-01-31'
    },
    {
      'name': 'Balance Sheet',
      'period': 'January 2024',
      'type': 'Balance Sheet',
      'generated': '2024-01-31'
    },
    {
      'name': 'Cash Flow Statement',
      'period': 'January 2024',
      'type': 'Cash Flow',
      'generated': '2024-01-31'
    },
  ];

  // Sample tax records
  final List<Map<String, dynamic>> _taxRecords = [
    {
      'period': 'Q4 2023',
      'type': 'VAT',
      'amount': 15000.00,
      'dueDate': '2024-01-20',
      'status': 'Paid',
      'filedDate': '2024-01-15'
    },
    {
      'period': 'Q1 2024',
      'type': 'VAT',
      'amount': 18000.00,
      'dueDate': '2024-04-20',
      'status': 'Pending',
      'filedDate': ''
    },
  ];

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

  // Core Accounting Functions
  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (context) => TransactionDialog(
        onTransactionAdded: (transaction) {
          setState(() {
            _transactions.insert(0, transaction);
          });
        },
      ),
    );
  }

  void _showCreateInvoiceDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateInvoiceDialog(
        onInvoiceCreated: (invoice) {
          setState(() {
            _invoices.insert(0, invoice);
          });
        },
      ),
    );
  }

  void _showInvoiceDetails(Map<String, dynamic> invoice, int index) {
    showDialog(
      context: context,
      builder: (context) => InvoiceDetailsDialog(
        invoice: invoice,
        onMarkAsPaid: () => _markInvoiceAsPaid(index),
      ),
    );
  }

  void _markInvoiceAsPaid(int index) {
    setState(() {
      _invoices[index]['status'] = 'Paid';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invoice ${_invoices[index]['id']} marked as paid', 
                  style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showFinancialReport() {
    showDialog(
      context: context,
      builder: (context) => FinancialReportDialog(
        financialSummary: _financialSummary,
        transactions: _transactions,
      ),
    );
  }

  void _showTaxCalculation() {
    showDialog(
      context: context,
      builder: (context) => TaxCalculatorDialog(
        onTaxCalculated: (taxRecord) {
          setState(() {
            _taxRecords.add(taxRecord);
          });
        },
      ),
    );
  }

  void _showAccountDetails(Map<String, dynamic> account) {
    showDialog(
      context: context,
      builder: (context) => AccountDetailsDialog(
        account: account,
        transactions: _transactions.where((t) => t['account'] == account['name']).toList(),
      ),
    );
  }

  void _showReconciliation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BankReconciliationSheet(
        transactions: _transactions,
        onReconciled: (reconciledTransactions) {
          setState(() {
            for (var transaction in reconciledTransactions) {
              final index = _transactions.indexWhere((t) => t['id'] == transaction['id']);
              if (index != -1) {
                _transactions[index]['status'] = 'Reconciled';
              }
            }
          });
        },
      ),
    );
  }

  // Utility Functions
  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  Color _getAmountColor(double amount, String type) {
    if (type == 'Revenue') return Colors.green;
    if (type == 'Expense') return Colors.red;
    return Colors.blue;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
      case 'Completed':
      case 'Reconciled':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Filtered data based on search
  List<Map<String, dynamic>> get _filteredTransactions {
    if (_searchQuery.isEmpty) return _transactions;
    return _transactions.where((transaction) =>
      transaction['description'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      transaction['account'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      transaction['type'].toLowerCase().contains(_searchQuery.toLowerCase())
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
          'Accounting Management',
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
            Tab(text: 'Transactions'),
            Tab(text: 'Invoices'),
            Tab(text: 'Accounts'),
            Tab(text: 'Reports'),
            Tab(text: 'Tax'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildTransactionsTab(),
          _buildInvoicesTab(),
          _buildAccountsTab(),
          _buildReportsTab(),
          _buildTaxTab(),
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
          // Financial Overview Cards
          Row(
            children: [
              _buildFinancialCard('Cash Balance', _financialSummary['cashBalance'], 
                                Colors.green, Icons.account_balance_wallet),
              SizedBox(width: 12),
              _buildFinancialCard('Accounts Receivable', _financialSummary['accountsReceivable'], 
                                Colors.blue, Icons.receipt),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildFinancialCard('Accounts Payable', _financialSummary['accountsPayable'], 
                                Colors.orange, Icons.payment),
              SizedBox(width: 12),
              _buildFinancialCard('Net Profit', _financialSummary['netProfit'], 
                                Colors.teal, Icons.trending_up),
            ],
          ),

          // Quick Actions
          SizedBox(height: 20),
          Text('Quick Actions', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton('New Transaction', Icons.add_chart, Colors.blue, _showAddTransactionDialog),
              _buildActionButton('Create Invoice', Icons.receipt_long, Colors.green, _showCreateInvoiceDialog),
              _buildActionButton('Bank Reconciliation', Icons.account_balance, Colors.orange, _showReconciliation),
              _buildActionButton('Financial Reports', Icons.analytics, Colors.purple, _showFinancialReport),
              _buildActionButton('Tax Calculator', Icons.calculate, Colors.red, _showTaxCalculation),
              _buildActionButton('Chart of Accounts', Icons.list_alt, Colors.teal, () {}),
            ],
          ),

          // Recent Transactions
          SizedBox(height: 20),
          _buildRecentTransactions(),

          // Invoice Status Summary
          SizedBox(height: 20),
          _buildInvoiceSummary(),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
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
                    hintText: 'Search transactions...',
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
                onPressed: _showTransactionFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredTransactions.length,
            itemBuilder: (context, index) {
              final transaction = _filteredTransactions[index];
              return _buildTransactionCard(transaction, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInvoicesTab() {
    final pendingInvoices = _invoices.where((invoice) => invoice['status'] == 'Pending').toList();
    final overdueInvoices = _invoices.where((invoice) => invoice['status'] == 'Overdue').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Invoice Summary Cards
          Row(
            children: [
              _buildInvoiceStatCard('Total Invoices', _invoices.length.toString(), Colors.blue),
              SizedBox(width: 12),
              _buildInvoiceStatCard('Pending', pendingInvoices.length.toString(), Colors.orange),
              SizedBox(width: 12),
              _buildInvoiceStatCard('Overdue', overdueInvoices.length.toString(), Colors.red),
            ],
          ),
          SizedBox(height: 20),

          // Invoices List
          Text('All Invoices', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._invoices.asMap().entries.map((entry) {
            final index = entry.key;
            final invoice = entry.value;
            return _buildInvoiceCard(invoice, index);
          }),
        ],
      ),
    );
  }

  Widget _buildAccountsTab() {
    final assets = _chartOfAccounts.where((account) => account['type'] == 'Asset').toList();
    final liabilities = _chartOfAccounts.where((account) => account['type'] == 'Liability').toList();
    final equity = _chartOfAccounts.where((account) => account['type'] == 'Equity').toList();
    final revenue = _chartOfAccounts.where((account) => account['type'] == 'Revenue').toList();
    final expenses = _chartOfAccounts.where((account) => account['type'] == 'Expense').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAccountTypeSection('Assets', assets, Colors.green),
          SizedBox(height: 16),
          _buildAccountTypeSection('Liabilities', liabilities, Colors.orange),
          SizedBox(height: 16),
          _buildAccountTypeSection('Equity', equity, Colors.blue),
          SizedBox(height: 16),
          _buildAccountTypeSection('Revenue', revenue, Colors.teal),
          SizedBox(height: 16),
          _buildAccountTypeSection('Expenses', expenses, Colors.red),
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
          Text('Financial Reports', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._reports.map((report) => _buildReportCard(report)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _showFinancialReport,
            icon: Icon(Icons.add),
            label: Text('Generate New Report', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxTab() {
    final pendingTaxes = _taxRecords.where((tax) => tax['status'] == 'Pending').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tax Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Tax Overview', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTaxStatItem('Total VAT', _formatCurrency(15000.00)),
                      _buildTaxStatItem('Pending', pendingTaxes.length.toString()),
                      _buildTaxStatItem('Next Due', 'Apr 20, 2024'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // Tax Records
          Text('Tax Records', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._taxRecords.map((tax) => _buildTaxCard(tax)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _showTaxCalculation,
            icon: Icon(Icons.calculate),
            label: Text('Tax Calculator', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 1: // Transactions
        return FloatingActionButton(
          onPressed: _showAddTransactionDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 2: // Invoices
        return FloatingActionButton(
          onPressed: _showCreateInvoiceDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.receipt_long, color: Colors.white),
        );
      case 3: // Accounts
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add_chart, color: Colors.white),
        );
      case 4: // Reports
        return FloatingActionButton(
          onPressed: _showFinancialReport,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.analytics, color: Colors.white),
        );
      case 5: // Tax
        return FloatingActionButton(
          onPressed: _showTaxCalculation,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.calculate, color: Colors.white),
        );
      default: // Dashboard
        return FloatingActionButton(
          onPressed: _showAddTransactionDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
    }
  }

  // Helper Widgets
  Widget _buildFinancialCard(String title, double amount, Color color, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 20),
                  SizedBox(width: 8),
                  Text(title, style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600])),
                ],
              ),
              SizedBox(height: 8),
              Text(_formatCurrency(amount), 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildTransactionCard(Map<String, dynamic> transaction, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getAmountColor(transaction['debit'] > 0 ? transaction['debit'] : transaction['credit'], transaction['type']).withOpacity(0.1),
          child: Icon(
            transaction['type'] == 'Revenue' ? Icons.arrow_downward : Icons.arrow_upward,
            color: _getAmountColor(transaction['debit'] > 0 ? transaction['debit'] : transaction['credit'], transaction['type']),
            size: 20,
          ),
        ),
        title: Text(transaction['description'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(transaction['account'], style: TextStyle(fontFamily: 'Cairo')),
            Text(transaction['date'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              transaction['debit'] > 0 ? _formatCurrency(transaction['debit']) : _formatCurrency(transaction['credit']),
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: _getAmountColor(transaction['debit'] > 0 ? transaction['debit'] : transaction['credit'], transaction['type']),
              ),
            ),
            Chip(
              label: Text(transaction['status'], style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: Colors.white)),
              backgroundColor: _getStatusColor(transaction['status']),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(invoice['status']).withOpacity(0.1),
          child: Icon(Icons.receipt, color: _getStatusColor(invoice['status'])),
        ),
        title: Text('Invoice ${invoice['id']}', style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(invoice['customer'], style: TextStyle(fontFamily: 'Cairo')),
            Text('Due: ${invoice['dueDate']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(_formatCurrency(invoice['amount']),
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            Chip(
              label: Text(invoice['status'], style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: Colors.white)),
              backgroundColor: _getStatusColor(invoice['status']),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        onTap: () => _showInvoiceDetails(invoice, index),
      ),
    );
  }

  Widget _buildAccountTypeSection(String title, List<Map<String, dynamic>> accounts, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 8),
            ...accounts.map((account) => _buildAccountItem(account)),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem(Map<String, dynamic> account) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[100],
        child: Text(account['code'], style: TextStyle(fontFamily: 'Cairo', fontSize: 10)),
      ),
      title: Text(account['name'], style: TextStyle(fontFamily: 'Cairo')),
      subtitle: Text(account['type'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      trailing: Text(_formatCurrency(account['balance']), 
                style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      onTap: () => _showAccountDetails(account),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.picture_as_pdf, color: Colors.red),
        title: Text(report['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Text('${report['type']} - ${report['period']}', style: TextStyle(fontFamily: 'Cairo')),
        trailing: IconButton(
          icon: Icon(Icons.download),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildTaxCard(Map<String, dynamic> tax) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.receipt_long, color: Colors.blue),
        title: Text('${tax['type']} - ${tax['period']}', style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ${_formatCurrency(tax['amount'])}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Due: ${tax['dueDate']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Chip(
          label: Text(tax['status'], style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: Colors.white)),
          backgroundColor: _getStatusColor(tax['status']),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final recentTransactions = _transactions.take(5).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${recentTransactions.length} transactions', 
                          style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 12),
            ...recentTransactions.map((transaction) => _buildRecentTransactionItem(transaction)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactionItem(Map<String, dynamic> transaction) {
    return ListTile(
      leading: Icon(
        transaction['type'] == 'Revenue' ? Icons.arrow_downward : Icons.arrow_upward,
        color: _getAmountColor(transaction['debit'] > 0 ? transaction['debit'] : transaction['credit'], transaction['type']),
      ),
      title: Text(transaction['description'], style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
      subtitle: Text(transaction['date'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      trailing: Text(
        transaction['debit'] > 0 ? _formatCurrency(transaction['debit']) : _formatCurrency(transaction['credit']),
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          color: _getAmountColor(transaction['debit'] > 0 ? transaction['debit'] : transaction['credit'], transaction['type']),
        ),
      ),
    );
  }

  Widget _buildInvoiceSummary() {
    final totalAmount = _invoices.fold(0.0, (sum, invoice) => sum + invoice['amount']);
    final pendingAmount = _invoices.where((i) => i['status'] == 'Pending').fold(0.0, (sum, invoice) => sum + invoice['amount']);
    final overdueAmount = _invoices.where((i) => i['status'] == 'Overdue').fold(0.0, (sum, invoice) => sum + invoice['amount']);
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invoice Summary', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildInvoiceSummaryItem('Total Amount', _formatCurrency(totalAmount), Colors.blue),
            _buildInvoiceSummaryItem('Pending Amount', _formatCurrency(pendingAmount), Colors.orange),
            _buildInvoiceSummaryItem('Overdue Amount', _formatCurrency(overdueAmount), Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceSummaryItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Cairo')),
          Text(value, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildInvoiceStatCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              Text(title, style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaxStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
        Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _showTransactionFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Transactions', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add filter options here
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

// Interactive Dialogs and Sheets
class TransactionDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onTransactionAdded;

  const TransactionDialog({super.key, required this.onTransactionAdded});

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedType = 'Expense';
  String _selectedAccount = 'Rent Expense';
  DateTime _selectedDate = DateTime.now();

  final List<String> _accountTypes = ['Revenue', 'Expense'];
  final List<String> _accounts = ['Rent Expense', 'Salary Expense', 'Software Expense', 'Service Revenue', 'Product Revenue'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Transaction', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                initialValue: _selectedType,
                items: _accountTypes
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(labelText: 'Transaction Type'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedAccount,
                items: _accounts
                    .map((account) => DropdownMenuItem(value: account, child: Text(account)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedAccount = value!),
                decoration: InputDecoration(labelText: 'Account'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter description' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter amount' : null,
              ),
              ListTile(
                title: Text('Date: ${_formatDate(_selectedDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _selectedDate = date);
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
              final amount = double.parse(_amountController.text);
              widget.onTransactionAdded({
                'id': 'T${DateTime.now().millisecondsSinceEpoch}',
                'date': _formatDate(_selectedDate),
                'description': _descriptionController.text,
                'account': _selectedAccount,
                'debit': _selectedType == 'Expense' ? amount : 0.0,
                'credit': _selectedType == 'Revenue' ? amount : 0.0,
                'type': _selectedType,
                'status': 'Completed'
              });
              Navigator.pop(context);
            }
          },
          child: Text('Add Transaction', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class CreateInvoiceDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onInvoiceCreated;

  const CreateInvoiceDialog({super.key, required this.onInvoiceCreated});

  @override
  State<CreateInvoiceDialog> createState() => _CreateInvoiceDialogState();
}

class _CreateInvoiceDialogState extends State<CreateInvoiceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _invoiceDate = DateTime.now();
  DateTime _dueDate = DateTime.now().add(Duration(days: 30));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Invoice', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _customerController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) => value!.isEmpty ? 'Please enter customer name' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter description' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter amount' : null,
              ),
              ListTile(
                title: Text('Invoice Date: ${_formatDate(_invoiceDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _invoiceDate = date);
                },
              ),
              ListTile(
                title: Text('Due Date: ${_formatDate(_dueDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _invoiceDate,
                    firstDate: _invoiceDate,
                    lastDate: DateTime(2025),
                  );
                  if (date != null) setState(() => _dueDate = date);
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
              widget.onInvoiceCreated({
                'id': 'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                'customer': _customerController.text,
                'date': _formatDate(_invoiceDate),
                'dueDate': _formatDate(_dueDate),
                'amount': double.parse(_amountController.text),
                'status': 'Pending',
                'items': [
                  {
                    'description': _descriptionController.text,
                    'quantity': 1,
                    'price': double.parse(_amountController.text)
                  }
                ]
              });
              Navigator.pop(context);
            }
          },
          child: Text('Create Invoice', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class InvoiceDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> invoice;
  final VoidCallback onMarkAsPaid;

  const InvoiceDetailsDialog({super.key, required this.invoice, required this.onMarkAsPaid});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Invoice ${invoice['id']}', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('Customer', invoice['customer']),
            _buildDetailRow('Invoice Date', invoice['date']),
            _buildDetailRow('Due Date', invoice['dueDate']),
            _buildDetailRow('Status', invoice['status']),
            _buildDetailRow('Amount', '\$${invoice['amount'].toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Text('Items:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ...(invoice['items'] as List).map((item) => _buildItemRow(item)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
        ),
        if (invoice['status'] == 'Pending')
          ElevatedButton(
            onPressed: () {
              onMarkAsPaid();
              Navigator.pop(context);
            },
            child: Text('Mark as Paid', style: TextStyle(fontFamily: 'Cairo')),
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
          Text(value, style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(item['description'], style: TextStyle(fontFamily: 'Cairo'))),
          Text('\$${item['price'].toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }
}

class FinancialReportDialog extends StatelessWidget {
  final Map<String, dynamic> financialSummary;
  final List<Map<String, dynamic>> transactions;

  const FinancialReportDialog({
    super.key,
    required this.financialSummary,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final totalRevenue = transactions.where((t) => t['type'] == 'Revenue').fold(0.0, (sum, t) => sum + t['credit']);
    final totalExpenses = transactions.where((t) => t['type'] == 'Expense').fold(0.0, (sum, t) => sum + t['debit']);
    final netProfit = totalRevenue - totalExpenses;

    return AlertDialog(
      title: Text('Financial Report', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildReportSection('Revenue', totalRevenue, Colors.green),
            _buildReportSection('Expenses', totalExpenses, Colors.red),
            _buildReportSection('Net Profit', netProfit, Colors.blue),
            SizedBox(height: 16),
            _buildFinancialMetric('Cash Balance', financialSummary['cashBalance']),
            _buildFinancialMetric('Accounts Receivable', financialSummary['accountsReceivable']),
            _buildFinancialMetric('Accounts Payable', financialSummary['accountsPayable']),
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
            // Export report
          },
          child: Text('Export PDF', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  Widget _buildReportSection(String title, double amount, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: ListTile(
        title: Text(title, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        trailing: Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }

  Widget _buildFinancialMetric(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Cairo')),
          Text('\$${value.toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class TaxCalculatorDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onTaxCalculated;

  const TaxCalculatorDialog({super.key, required this.onTaxCalculated});

  @override
  State<TaxCalculatorDialog> createState() => _TaxCalculatorDialogState();
}

class _TaxCalculatorDialogState extends State<TaxCalculatorDialog> {
  final _incomeController = TextEditingController();
  final _expensesController = TextEditingController();
  final _taxRateController = TextEditingController(text: '15');
  double _taxAmount = 0.0;

  void _calculateTax() {
    final income = double.tryParse(_incomeController.text) ?? 0;
    final expenses = double.tryParse(_expensesController.text) ?? 0;
    final taxRate = double.tryParse(_taxRateController.text) ?? 15;
    
    setState(() {
      _taxAmount = (income - expenses) * (taxRate / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tax Calculator', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _incomeController,
              decoration: InputDecoration(labelText: 'Total Income'),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateTax(),
            ),
            TextFormField(
              controller: _expensesController,
              decoration: InputDecoration(labelText: 'Total Expenses'),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateTax(),
            ),
            TextFormField(
              controller: _taxRateController,
              decoration: InputDecoration(labelText: 'Tax Rate (%)'),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateTax(),
            ),
            SizedBox(height: 16),
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tax Amount: \$${_taxAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
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
            final now = DateTime.now();
            final quarter = ((now.month - 1) ~/ 3) + 1;
            widget.onTaxCalculated({
              'period': 'Q$quarter ${now.year}',
              'type': 'VAT',
              'amount': _taxAmount,
              'dueDate': _formatDate(DateTime.now().add(Duration(days: 90))),
              'status': 'Pending',
              'filedDate': ''
            });
            Navigator.pop(context);
          },
          child: Text('Save Calculation', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class AccountDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> account;
  final List<Map<String, dynamic>> transactions;

  const AccountDetailsDialog({
    super.key,
    required this.account,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Account Details', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('Account Code', account['code']),
            _buildDetailRow('Account Name', account['name']),
            _buildDetailRow('Account Type', account['type']),
            _buildDetailRow('Current Balance', '\$${account['balance'].toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Text('Recent Transactions:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            ...transactions.take(3).map((transaction) => _buildTransactionItem(transaction)),
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
          Text(value, style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    return ListTile(
      title: Text(transaction['description'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      subtitle: Text(transaction['date'], style: TextStyle(fontFamily: 'Cairo', fontSize: 10)),
      trailing: Text(
        transaction['debit'] > 0 ? '-\$${transaction['debit']}' : '+\$${transaction['credit']}',
        style: TextStyle(
          fontFamily: 'Cairo',
          color: transaction['debit'] > 0 ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}

class BankReconciliationSheet extends StatefulWidget {
  final List<Map<String, dynamic>> transactions;
  final Function(List<Map<String, dynamic>>) onReconciled;

  const BankReconciliationSheet({
    super.key,
    required this.transactions,
    required this.onReconciled,
  });

  @override
  State<BankReconciliationSheet> createState() => _BankReconciliationSheetState();
}

class _BankReconciliationSheetState extends State<BankReconciliationSheet> {
  final List<Map<String, dynamic>> _selectedTransactions = [];

  @override
  Widget build(BuildContext context) {
    final unreconciledTransactions = widget.transactions.where((t) => t['status'] != 'Reconciled').toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Bank Reconciliation', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Select transactions to reconcile:', style: TextStyle(fontFamily: 'Cairo')),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: unreconciledTransactions.length,
              itemBuilder: (context, index) {
                final transaction = unreconciledTransactions[index];
                return CheckboxListTile(
                  title: Text(transaction['description'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('${transaction['date']} - \$${transaction['debit'] > 0 ? transaction['debit'] : transaction['credit']}',
                          style: TextStyle(fontFamily: 'Cairo')),
                  value: _selectedTransactions.contains(transaction),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedTransactions.add(transaction);
                      } else {
                        _selectedTransactions.remove(transaction);
                      }
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Selected: ${_selectedTransactions.length}', style: TextStyle(fontFamily: 'Cairo')),
              ElevatedButton(
                onPressed: _selectedTransactions.isEmpty ? null : () {
                  widget.onReconciled(_selectedTransactions);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${_selectedTransactions.length} transactions reconciled', 
                            style: TextStyle(fontFamily: 'Cairo'))),
                  );
                },
                child: Text('Reconcile Selected', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}