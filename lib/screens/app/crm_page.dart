import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class CustomerRelationsPage extends StatefulWidget {
  const CustomerRelationsPage({super.key, UserModel? user});

  @override
  State<CustomerRelationsPage> createState() => _CustomerRelationsPageState();
}

class _CustomerRelationsPageState extends State<CustomerRelationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  // Sample CRM Data
  final List<Map<String, dynamic>> _leads = [
    {
      'id': 'L001',
      'name': 'Mohamed Al-Rashid',
      'company': 'Al-Rashid Trading',
      'email': 'm.alsharif@alrashid.com',
      'phone': '+966 50 123 4567',
      'source': 'Website Form',
      'status': 'New',
      'priority': 'High',
      'value': 50000.0,
      'assigned_to': 'Ahmed Hassan',
      'created_date': '2024-01-15',
      'last_contact': '2024-01-20',
      'score': 85,
      'industry': 'Trading',
      'location': 'Riyadh',
    },
    {
      'id': 'L002',
      'name': 'Sarah Al-Mansour',
      'company': 'Mansour Group',
      'email': 'sarah@mansourgroup.com',
      'phone': '+966 55 987 6543',
      'source': 'Referral',
      'status': 'Contacted',
      'priority': 'Medium',
      'value': 120000.0,
      'assigned_to': 'Fatima Ahmed',
      'created_date': '2024-01-12',
      'last_contact': '2024-01-18',
      'score': 72,
      'industry': 'Construction',
      'location': 'Jeddah',
    },
  ];

  final List<Map<String, dynamic>> _customers = [
    {
      'id': 'C001',
      'name': 'Abdullah Al-Saud',
      'company': 'Saudi Industrial Co.',
      'email': 'a.alsaud@saudiindustrial.com',
      'phone': '+966 11 234 5678',
      'type': 'VIP',
      'status': 'Active',
      'value': 450000.0,
      'since': '2022-03-15',
      'location': 'Riyadh',
      'industry': 'Manufacturing',
      'contacts': [
        {
          'name': 'Khalid Al-Saud',
          'position': 'Procurement Manager',
          'email': 'k.alsaud@sic.com',
          'phone': '+966 50 111 2222'
        },
        {
          'name': 'Nora Al-Saud',
          'position': 'Finance Director',
          'email': 'n.alsaud@sic.com',
          'phone': '+966 55 333 4444'
        },
      ],
      'addresses': {
        'billing': 'Industrial Zone, Riyadh 12345',
        'shipping': 'Warehouse District, Riyadh 12346'
      },
    },
    {
      'id': 'C002',
      'name': 'Lama Al-Ghamdi',
      'company': 'Ghamdi Retail Chain',
      'email': 'lama@ghamdiretail.com',
      'phone': '+966 12 345 6789',
      'type': 'Regular',
      'status': 'Active',
      'value': 280000.0,
      'since': '2023-06-20',
      'location': 'Jeddah',
      'industry': 'Retail',
      'contacts': [
        {
          'name': 'Omar Al-Ghamdi',
          'position': 'Operations Manager',
          'email': 'omar@ghamdiretail.com',
          'phone': '+966 50 555 6666'
        },
      ],
      'addresses': {
        'billing': 'Commercial Street, Jeddah 23456',
        'shipping': 'Retail Center, Jeddah 23457'
      },
    },
  ];

  final List<Map<String, dynamic>> _opportunities = [
    {
      'id': 'OP001',
      'name': 'Enterprise Software License',
      'customer': 'Saudi Industrial Co.',
      'customer_id': 'C001',
      'stage': 'Proposal',
      'value': 150000.0,
      'probability': 75,
      'close_date': '2024-02-28',
      'assigned_to': 'Ahmed Hassan',
      'created_date': '2024-01-10',
      'last_activity': '2024-01-22',
      'products': ['ERP License', 'Support Package'],
      'competitors': ['Oracle', 'SAP'],
      'notes': 'Customer interested in full implementation',
    },
    {
      'id': 'OP002',
      'name': 'Retail POS System',
      'customer': 'Ghamdi Retail Chain',
      'customer_id': 'C002',
      'stage': 'Qualified',
      'value': 80000.0,
      'probability': 50,
      'close_date': '2024-03-15',
      'assigned_to': 'Fatima Ahmed',
      'created_date': '2024-01-18',
      'last_activity': '2024-01-25',
      'products': ['POS Hardware', 'Software License'],
      'competitors': ['Local POS Providers'],
      'notes': 'Need to schedule demo',
    },
  ];

  final List<Map<String, dynamic>> _activities = [
    {
      'id': 'ACT001',
      'type': 'Call',
      'subject': 'Follow-up on proposal',
      'customer': 'Saudi Industrial Co.',
      'due_date': '2024-01-25',
      'status': 'Completed',
      'assigned_to': 'Ahmed Hassan',
      'priority': 'High',
      'notes': 'Customer requested additional features',
    },
    {
      'id': 'ACT002',
      'type': 'Meeting',
      'subject': 'Product Demo',
      'customer': 'Ghamdi Retail Chain',
      'due_date': '2024-01-30',
      'status': 'Scheduled',
      'assigned_to': 'Fatima Ahmed',
      'priority': 'Medium',
      'notes': 'Prepare demo materials',
    },
    {
      'id': 'ACT003',
      'type': 'Email',
      'subject': 'Quote Follow-up',
      'customer': 'Al-Rashid Trading',
      'due_date': '2024-01-26',
      'status': 'Overdue',
      'assigned_to': 'Ahmed Hassan',
      'priority': 'High',
      'notes': 'Send updated pricing',
    },
  ];

  final List<Map<String, dynamic>> _quotations = [
    {
      'id': 'Q001',
      'number': 'QT-2024-001',
      'customer': 'Saudi Industrial Co.',
      'customer_id': 'C001',
      'opportunity_id': 'OP001',
      'amount': 150000.0,
      'status': 'Sent',
      'valid_until': '2024-02-15',
      'created_date': '2024-01-20',
      'products': [
        {'name': 'ERP License', 'quantity': 50, 'price': 2000.0},
        {'name': 'Support Package', 'quantity': 1, 'price': 50000.0},
      ],
    },
    {
      'id': 'Q002',
      'number': 'QT-2024-002',
      'customer': 'Ghamdi Retail Chain',
      'customer_id': 'C002',
      'opportunity_id': 'OP002',
      'amount': 80000.0,
      'status': 'Draft',
      'valid_until': '2024-03-01',
      'created_date': '2024-01-22',
      'products': [
        {'name': 'POS Hardware', 'quantity': 10, 'price': 5000.0},
        {'name': 'Software License', 'quantity': 10, 'price': 3000.0},
      ],
    },
  ];

  final List<Map<String, dynamic>> _salesTeam = [
    {
      'name': 'Ahmed Hassan',
      'email': 'ahmed@company.com',
      'phone': '+966 50 111 2222',
      'target': 1000000.0,
      'achieved': 650000.0
    },
    {
      'name': 'Fatima Ahmed',
      'email': 'fatima@company.com',
      'phone': '+966 55 333 4444',
      'target': 800000.0,
      'achieved': 520000.0
    },
    {
      'name': 'Khalid Omar',
      'email': 'khalid@company.com',
      'phone': '+966 54 555 6666',
      'target': 600000.0,
      'achieved': 380000.0
    },
  ];

  // Pipeline stages
  final List<String> _pipelineStages = [
    'New',
    'Qualified',
    'Proposal',
    'Negotiation',
    'Won',
    'Lost'
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String get selectedFilter => _selectedFilter;

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

  // Core CRM Functions
  void _showLeadDetails(Map<String, dynamic> lead) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lead Details',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Lead ID', lead['id']),
              _buildDetailRow('Name', lead['name']),
              _buildDetailRow('Company', lead['company']),
              _buildDetailRow('Email', lead['email']),
              _buildDetailRow('Phone', lead['phone']),
              _buildDetailRow('Source', lead['source']),
              _buildDetailRow('Status', lead['status']),
              _buildDetailRow('Priority', lead['priority']),
              _buildDetailRow('Value', '\$${lead['value']}'),
              _buildDetailRow('Assigned To', lead['assigned_to']),
              _buildDetailRow('Lead Score', '${lead['score']}/100'),
              _buildDetailRow('Industry', lead['industry']),
              _buildDetailRow('Location', lead['location']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _convertLeadToOpportunity(lead),
            child: Text('Convert to Opportunity',
                style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _convertLeadToOpportunity(Map<String, dynamic> lead) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => CreateOpportunityDialog(
        lead: lead,
        onOpportunityCreated: (opportunity) {
          setState(() {
            _opportunities.add(opportunity);
            _leads.removeWhere((l) => l['id'] == lead['id']);
          });
        },
      ),
    );
  }

  void _showCustomerDetails(Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Customer Details',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer ID', customer['id']),
              _buildDetailRow('Name', customer['name']),
              _buildDetailRow('Company', customer['company']),
              _buildDetailRow('Email', customer['email']),
              _buildDetailRow('Phone', customer['phone']),
              _buildDetailRow('Type', customer['type']),
              _buildDetailRow('Status', customer['status']),
              _buildDetailRow('Total Value', '\$${customer['value']}'),
              _buildDetailRow('Customer Since', customer['since']),
              _buildDetailRow('Industry', customer['industry']),
              _buildDetailRow('Location', customer['location']),
              SizedBox(height: 16),
              Text('Contact Persons:',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ...customer['contacts'].map<Widget>((contact) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('• ${contact['name']} - ${contact['position']}',
                        style: TextStyle(fontFamily: 'Cairo')),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _createOpportunityForCustomer(customer),
            child: Text('Create Opportunity',
                style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _createOpportunityForCustomer(Map<String, dynamic> customer) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => CreateOpportunityDialog(
        customer: customer,
        onOpportunityCreated: (opportunity) {
          setState(() {
            _opportunities.add(opportunity);
          });
        },
      ),
    );
  }

  void _showOpportunityDetails(Map<String, dynamic> opportunity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Opportunity Details',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Opportunity ID', opportunity['id']),
              _buildDetailRow('Name', opportunity['name']),
              _buildDetailRow('Customer', opportunity['customer']),
              _buildDetailRow('Stage', opportunity['stage']),
              _buildDetailRow('Value', '\$${opportunity['value']}'),
              _buildDetailRow('Probability', '${opportunity['probability']}%'),
              _buildDetailRow('Close Date', opportunity['close_date']),
              _buildDetailRow('Assigned To', opportunity['assigned_to']),
              SizedBox(height: 16),
              Text('Products:',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ...opportunity['products'].map<Widget>((product) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('• $product',
                        style: TextStyle(fontFamily: 'Cairo')),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _createQuotation(opportunity),
            child:
                Text('Create Quotation', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _createQuotation(Map<String, dynamic> opportunity) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => CreateQuotationDialog(
        opportunity: opportunity,
        onQuotationCreated: (quotation) {
          setState(() {
            _quotations.add(quotation);
          });
        },
      ),
    );
  }

  void _showAddLeadDialog() {
    showDialog(
      context: context,
      builder: (context) => AddLeadDialog(
        onLeadAdded: (lead) {
          setState(() {
            _leads.add(lead);
          });
        },
      ),
    );
  }

  void _showAddActivityDialog() {
    showDialog(
      context: context,
      builder: (context) => AddActivityDialog(
        onActivityAdded: (activity) {
          setState(() {
            _activities.add(activity);
          });
        },
        customers: _customers,
        opportunities: _opportunities,
      ),
    );
  }

  void _showPipelineView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PipelineViewPage(
          opportunities: _opportunities,
          onOpportunityUpdated: (updatedOpportunities) {
            setState(() {
              // Update opportunities with new stages
            });
          },
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
          Text('$label: ',
              style:
                  TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
      case 'Active':
      case 'Sent':
        return Colors.blue;
      case 'Contacted':
      case 'Scheduled':
        return Colors.orange;
      case 'Qualified':
      case 'Completed':
        return Colors.green;
      case 'Proposal':
        return Colors.purple;
      case 'Negotiation':
        return Colors.deepOrange;
      case 'Won':
        return Colors.green;
      case 'Lost':
        return Colors.red;
      case 'Overdue':
        return Colors.red;
      case 'Draft':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'Call':
        return Icons.phone;
      case 'Email':
        return Icons.email;
      case 'Meeting':
        return Icons.people;
      case 'Task':
        return Icons.task;
      default:
        return Icons.event;
    }
  }

  void _showLeadFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterBottomSheet(
        onFilterApplied: (filter) {
          setState(() {
            _selectedFilter = filter;
          });
        },
      ),
    );
  }

  void _showCustomerFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterBottomSheet(
        onFilterApplied: (filter) {
          setState(() {
            _selectedFilter = filter;
          });
        },
      ),
    );
  }

  // Filtered data based on search
  List<Map<String, dynamic>> get _filteredLeads {
    if (_searchQuery.isEmpty) return _leads;
    return _leads
        .where((lead) =>
            lead['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            lead['company']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            lead['email'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<Map<String, dynamic>> get _filteredCustomers {
    if (_searchQuery.isEmpty) return _customers;
    return _customers
        .where((customer) =>
            customer['name']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            customer['company']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            customer['email']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Dashboard Widgets
  Widget _buildStatCard(
      String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  Text(value,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color)),
                ],
              ),
              SizedBox(height: 8),
              Text(title,
                  style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String text, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 100,
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                SizedBox(height: 8),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activities',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ..._activities.take(3).map((activity) => Column(
                  children: [
                    ListTile(
                      leading: Icon(_getActivityIcon(activity['type']),
                          color: _getStatusColor(activity['status'])),
                      title: Text(activity['subject'],
                          style: TextStyle(fontFamily: 'Cairo')),
                      subtitle: Text(
                          '${activity['customer']} • ${activity['due_date']}',
                          style: TextStyle(fontFamily: 'Cairo')),
                      trailing: Chip(
                        label: Text(activity['status'],
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 10,
                                color: Colors.white)),
                        backgroundColor: _getStatusColor(activity['status']),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    Divider(height: 1),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPerformers() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Performers',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ..._salesTeam.map((salesperson) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.1),
                        child: Text(salesperson['name'][0],
                            style: TextStyle(color: AppColors.primaryColor)),
                      ),
                      title: Text(salesperson['name'],
                          style: TextStyle(fontFamily: 'Cairo')),
                      subtitle: LinearProgressIndicator(
                        value: salesperson['achieved'] / salesperson['target'],
                        backgroundColor: Colors.grey[300],
                        color: AppColors.primaryColor,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$${salesperson['achieved']}',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold)),
                          Text(
                              '${((salesperson['achieved'] / salesperson['target']) * 100).toStringAsFixed(1)}%',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildOverdueActivities() {
    final overdueActivities =
        _activities.where((a) => a['status'] == 'Overdue').toList();

    return Card(
      color: Colors.red.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Text('Overdue Activities',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            SizedBox(height: 8),
            ...overdueActivities.map((activity) => ListTile(
                  leading: Icon(_getActivityIcon(activity['type']),
                      color: Colors.red),
                  title: Text(activity['subject'],
                      style: TextStyle(fontFamily: 'Cairo', color: Colors.red)),
                  subtitle: Text(
                      '${activity['customer']} • Due: ${activity['due_date']}',
                      style: TextStyle(fontFamily: 'Cairo')),
                  trailing: IconButton(
                    icon: Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        activity['status'] = 'Completed';
                      });
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        switch (_selectedTabIndex) {
          case 1: // Leads
            _showAddLeadDialog();
            break;
          case 2: // Customers
            _showAddActivityDialog();
            break;
          case 3: // Opportunities
            _createOpportunityForCustomer(_customers.first);
            break;
          case 4: // Activities
            _showAddActivityDialog();
            break;
          case 5: // Quotations
            _createQuotation(_opportunities.first);
            break;
          default:
            _showAddLeadDialog();
        }
      },
      child: Icon(Icons.add, color: Colors.white),
    );
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
          'Customer Relations Management',
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
            Tab(text: 'Leads'),
            Tab(text: 'Customers'),
            Tab(text: 'Opportunities'),
            Tab(text: 'Activities'),
            Tab(text: 'Quotations'),
            Tab(text: 'Pipeline'),
            Tab(text: 'Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildLeadsTab(),
          _buildCustomersTab(),
          _buildOpportunitiesTab(),
          _buildActivitiesTab(),
          _buildQuotationsTab(),
          _buildPipelineTab(),
          _buildReportsTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    final totalLeads = _leads.length;
    final totalOpportunities = _opportunities.length;
    final totalOpportunityValue =
        _opportunities.map((o) => o['value']).fold(0.0, (a, b) => a + b);
    final overdueActivities =
        _activities.where((a) => a['status'] == 'Overdue').length;
    final todayActivities =
        _activities.where((a) => a['due_date'] == '2024-01-25').length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
          Row(
            children: [
              _buildStatCard('Total Leads', totalLeads.toString(), Colors.blue,
                  Icons.people),
              SizedBox(width: 12),
              _buildStatCard('Opportunities', totalOpportunities.toString(),
                  Colors.green, Icons.trending_up),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(
                  'Pipeline Value',
                  '\$${totalOpportunityValue.toStringAsFixed(0)}',
                  Colors.orange,
                  Icons.attach_money),
              SizedBox(width: 12),
              _buildStatCard('Activities Today', todayActivities.toString(),
                  Colors.purple, Icons.calendar_today),
            ],
          ),
          SizedBox(height: 20),

          // Quick Actions
          Text('Quick Actions',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton('Add Lead', Icons.person_add, Colors.blue,
                  _showAddLeadDialog),
              _buildActionButton('Add Activity', Icons.calendar_today,
                  Colors.green, _showAddActivityDialog),
              _buildActionButton('Create Quote', Icons.description,
                  Colors.orange, () => _createQuotation(_opportunities.first)),
              _buildActionButton('View Pipeline', Icons.account_tree,
                  Colors.purple, _showPipelineView),
              _buildActionButton(
                  'Customer Lookup', Icons.search, Colors.teal, () {}),
              _buildActionButton('Quick Call', Icons.phone, Colors.red, () {}),
            ],
          ),

          // Recent Activities
          SizedBox(height: 20),
          _buildRecentActivities(),

          // Top Performers
          SizedBox(height: 20),
          _buildTopPerformers(),

          // Overdue Activities
          if (overdueActivities > 0) ...[
            SizedBox(height: 20),
            _buildOverdueActivities(),
          ],
        ],
      ),
    );
  }

  Widget _buildLeadsTab() {
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
                    hintText: 'Search leads...',
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
                onPressed: _showLeadFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredLeads.length,
            itemBuilder: (context, index) {
              final lead = _filteredLeads[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.person, color: AppColors.primaryColor),
                  ),
                  title:
                      Text(lead['name'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('${lead['company']} • ${lead['email']}',
                      style: TextStyle(fontFamily: 'Cairo')),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('View Details',
                            style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showLeadDetails(lead),
                      ),
                      PopupMenuItem(
                        child: Text('Convert to Opportunity',
                            style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _convertLeadToOpportunity(lead),
                      ),
                      PopupMenuItem(
                        child: Text('Schedule Activity',
                            style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showAddActivityDialog(),
                      ),
                    ],
                  ),
                  onTap: () => _showLeadDetails(lead),
                ),
              );
            },
          ),
        ),
      ],
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
                    backgroundColor: customer['type'] == 'VIP'
                        ? Colors.amber.withOpacity(0.1)
                        : AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(
                      customer['type'] == 'VIP' ? Icons.star : Icons.business,
                      color: customer['type'] == 'VIP'
                          ? Colors.amber
                          : AppColors.primaryColor,
                    ),
                  ),
                  title: Text(customer['name'],
                      style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text(
                      '${customer['company']} • ${customer['email']}',
                      style: TextStyle(fontFamily: 'Cairo')),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('View Details',
                            style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showCustomerDetails(customer),
                      ),
                      PopupMenuItem(
                        child: Text('Create Opportunity',
                            style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _createOpportunityForCustomer(customer),
                      ),
                      PopupMenuItem(
                        child: Text('Schedule Activity',
                            style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showAddActivityDialog(),
                      ),
                    ],
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

  Widget _buildOpportunitiesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Sales Opportunities',
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ..._opportunities.map((opportunity) => Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      _getStatusColor(opportunity['stage']).withOpacity(0.1),
                  child: Icon(Icons.trending_up,
                      color: _getStatusColor(opportunity['stage'])),
                ),
                title: Text(opportunity['name'],
                    style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${opportunity['customer']} • \$${opportunity['value']}',
                        style: TextStyle(fontFamily: 'Cairo')),
                    Text(
                        'Close: ${opportunity['close_date']} • ${opportunity['probability']}% probability',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Colors.grey)),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Chip(
                      label: Text(opportunity['stage'],
                          style: TextStyle(
                              fontFamily: 'Cairo', color: Colors.white)),
                      backgroundColor: _getStatusColor(opportunity['stage']),
                    ),
                    SizedBox(height: 4),
                    Text(opportunity['assigned_to'],
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  ],
                ),
                onTap: () => _showOpportunityDetails(opportunity),
              ),
            )),
      ],
    );
  }

  Widget _buildActivitiesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Activities & Tasks',
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ..._activities.map((activity) => Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  _getActivityIcon(activity['type']),
                  color: _getStatusColor(activity['status']),
                ),
                title: Text(activity['subject'],
                    style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${activity['customer']} • Due: ${activity['due_date']}',
                        style: TextStyle(fontFamily: 'Cairo')),
                    if (activity['notes'] != null &&
                        activity['notes'].isNotEmpty)
                      Text(activity['notes'],
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: Colors.grey)),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Chip(
                      label: Text(activity['status'],
                          style: TextStyle(
                              fontFamily: 'Cairo', color: Colors.white)),
                      backgroundColor: _getStatusColor(activity['status']),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(activity['priority'])
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: _getPriorityColor(activity['priority'])),
                      ),
                      child: Text(activity['priority'],
                          style: TextStyle(
                            color: _getPriorityColor(activity['priority']),
                            fontFamily: 'Cairo',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildQuotationsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Quotations',
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ..._quotations.map((quotation) => Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(Icons.description, color: AppColors.primaryColor),
                title: Text(quotation['number'],
                    style: TextStyle(fontFamily: 'Cairo')),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${quotation['customer']} • \$${quotation['amount']}',
                        style: TextStyle(fontFamily: 'Cairo')),
                    Text('Valid until: ${quotation['valid_until']}',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Colors.grey)),
                  ],
                ),
                trailing: Chip(
                  label: Text(quotation['status'],
                      style:
                          TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: _getStatusColor(quotation['status']),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildPipelineTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Sales Pipeline',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              ..._pipelineStages.map((stage) {
                final stageOpportunities =
                    _opportunities.where((o) => o['stage'] == stage).toList();
                final stageValue = stageOpportunities
                    .map((o) => o['value'])
                    .fold(0.0, (a, b) => a + b);

                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(stage,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Chip(
                              label: Text('${stageOpportunities.length} deals',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.white)),
                              backgroundColor: _getStatusColor(stage),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('\$${stageValue.toStringAsFixed(0)}',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(stage))),
                        SizedBox(height: 12),
                        ...stageOpportunities
                            .take(3)
                            .map((opportunity) => Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: _getStatusColor(stage)
                                            .withOpacity(0.1),
                                        child: Text('\$${opportunity['value']}',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      title: Text(opportunity['name'],
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14)),
                                      subtitle: Text(opportunity['customer'],
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 12)),
                                      trailing: Text(
                                          '${opportunity['probability']}%',
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Divider(height: 1),
                                  ],
                                )),
                        if (stageOpportunities.length > 3)
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                                '+ ${stageOpportunities.length - 3} more opportunities',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    color: Colors.grey)),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReportsTab() {
    final totalWon = _opportunities.where((o) => o['stage'] == 'Won').length;
    final totalLost = _opportunities.where((o) => o['stage'] == 'Lost').length;
    final conversionRate = totalWon + totalLost > 0
        ? (totalWon / (totalWon + totalLost) * 100)
        : 0;
    final totalRevenue = _opportunities
        .where((o) => o['stage'] == 'Won')
        .map((o) => o['value'])
        .fold(0.0, (a, b) => a + b);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Key Metrics
          Row(
            children: [
              _buildReportCard(
                  'Conversion Rate',
                  '${conversionRate.toStringAsFixed(1)}%',
                  Icons.trending_up,
                  Colors.green),
              SizedBox(width: 12),
              _buildReportCard(
                  'Total Revenue',
                  '\$${totalRevenue.toStringAsFixed(0)}',
                  Icons.attach_money,
                  Colors.blue),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildReportCard('Won Deals', totalWon.toString(),
                  Icons.check_circle, Colors.green),
              SizedBox(width: 12),
              _buildReportCard(
                  'Lost Deals', totalLost.toString(), Icons.cancel, Colors.red),
            ],
          ),

          SizedBox(height: 20),

          // Performance Charts
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sales Performance',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._salesTeam.map((salesperson) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(salesperson['name'],
                                  style: TextStyle(fontFamily: 'Cairo')),
                            ),
                            Expanded(
                              flex: 3,
                              child: LinearProgressIndicator(
                                value: salesperson['achieved'] /
                                    salesperson['target'],
                                backgroundColor: Colors.grey[300],
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '\$${salesperson['achieved']} / \$${salesperson['target']}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Cairo', fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Pipeline Analysis
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pipeline Analysis',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._pipelineStages.map((stage) {
                    final stageCount =
                        _opportunities.where((o) => o['stage'] == stage).length;
                    final stageValue = _opportunities
                        .where((o) => o['stage'] == stage)
                        .map((o) => o['value'])
                        .fold(0.0, (a, b) => a + b);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(stage,
                                style: TextStyle(fontFamily: 'Cairo')),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('$stageCount deals',
                                style: TextStyle(
                                    fontFamily: 'Cairo', color: Colors.grey)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text('\$${stageValue.toStringAsFixed(0)}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold)),
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

  Widget _buildReportCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              SizedBox(height: 8),
              Text(value,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(title,
                  style: TextStyle(
                      fontFamily: 'Cairo', color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// Supporting Dialog Classes
class AddLeadDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onLeadAdded;

  const AddLeadDialog({super.key, required this.onLeadAdded});

  @override
  State<AddLeadDialog> createState() => _AddLeadDialogState();
}

class _AddLeadDialogState extends State<AddLeadDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedSource = 'Website Form';
  String _selectedPriority = 'Medium';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Lead',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Name', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(
                    labelText: 'Company', border: OutlineInputBorder()),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: 'Phone', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedSource,
                decoration: InputDecoration(
                    labelText: 'Source', border: OutlineInputBorder()),
                items: [
                  'Website Form',
                  'Referral',
                  'Social Media',
                  'Event',
                  'Cold Call'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSource = value!;
                  });
                },
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedPriority,
                decoration: InputDecoration(
                    labelText: 'Priority', border: OutlineInputBorder()),
                items: ['High', 'Medium', 'Low'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value!;
                  });
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
              final newLead = {
                'id': 'L${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'company': _companyController.text,
                'email': _emailController.text,
                'phone': _phoneController.text,
                'source': _selectedSource,
                'status': 'New',
                'priority': _selectedPriority,
                'value': 0.0,
                'assigned_to': 'Ahmed Hassan',
                'created_date': '2024-01-25',
                'last_contact': '',
                'score': 50,
                'industry': 'General',
                'location': 'Riyadh',
              };
              widget.onLeadAdded(newLead);
              Navigator.pop(context);
            }
          },
          child: Text('Add Lead', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class AddActivityDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onActivityAdded;
  final List<Map<String, dynamic>> customers;
  final List<Map<String, dynamic>> opportunities;

  const AddActivityDialog({
    super.key,
    required this.onActivityAdded,
    required this.customers,
    required this.opportunities,
  });

  @override
  State<AddActivityDialog> createState() => _AddActivityDialogState();
}

class _AddActivityDialogState extends State<AddActivityDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _selectedType = 'Call';
  String _selectedCustomer = '';
  String _selectedPriority = 'Medium';
  final DateTime _selectedDate = DateTime.now().add(Duration(days: 1));
  DateTime get selectedDate => _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.customers.isNotEmpty) {
      _selectedCustomer = widget.customers.first['name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Schedule Activity',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: _selectedType,
                decoration: InputDecoration(
                    labelText: 'Activity Type', border: OutlineInputBorder()),
                items: ['Call', 'Email', 'Meeting', 'Task', 'Follow-up']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                    labelText: 'Subject', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter subject' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedCustomer,
                decoration: InputDecoration(
                    labelText: 'Customer', border: OutlineInputBorder()),
                items: widget.customers.map((customer) {
                  return DropdownMenuItem<String>(
                    value: customer['name'],
                    child: Text(customer['name'],
                        style: TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCustomer = value!;
                  });
                },
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedPriority,
                decoration: InputDecoration(
                    labelText: 'Priority', border: OutlineInputBorder()),
                items: ['High', 'Medium', 'Low'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value!;
                  });
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                    labelText: 'Notes', border: OutlineInputBorder()),
                maxLines: 3,
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
              final newActivity = {
                'id': 'ACT${DateTime.now().millisecondsSinceEpoch}',
                'type': _selectedType,
                'subject': _subjectController.text,
                'customer': _selectedCustomer,
                'due_date': '2024-01-26',
                'status': 'Scheduled',
                'assigned_to': 'Ahmed Hassan',
                'priority': _selectedPriority,
                'notes': _notesController.text,
              };
              widget.onActivityAdded(newActivity);
              Navigator.pop(context);
            }
          },
          child: Text('Schedule', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class CreateOpportunityDialog extends StatefulWidget {
  final Map<String, dynamic>? lead;
  final Map<String, dynamic>? customer;
  final Function(Map<String, dynamic>) onOpportunityCreated;

  const CreateOpportunityDialog({
    super.key,
    this.lead,
    this.customer,
    required this.onOpportunityCreated,
  });

  @override
  State<CreateOpportunityDialog> createState() =>
      _CreateOpportunityDialogState();
}

class _CreateOpportunityDialogState extends State<CreateOpportunityDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _closeDateController = TextEditingController();
  String _selectedStage = 'New';
  int _probability = 10;

  @override
  void initState() {
    super.initState();
    if (widget.lead != null) {
      _nameController.text = '${widget.lead!['company']} Opportunity';
      _valueController.text = widget.lead!['value'].toString();
    } else if (widget.customer != null) {
      _nameController.text = '${widget.customer!['company']} Opportunity';
    }
    _closeDateController.text = '2024-02-28';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Opportunity',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Opportunity Name',
                    border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _valueController,
                decoration: InputDecoration(
                    labelText: 'Expected Value', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter value' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedStage,
                decoration: InputDecoration(
                    labelText: 'Stage', border: OutlineInputBorder()),
                items: [
                  'New',
                  'Qualified',
                  'Proposal',
                  'Negotiation',
                  'Won',
                  'Lost'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontFamily: 'Cairo')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStage = value!;
                    // Update probability based on stage
                    switch (value) {
                      case 'New':
                        _probability = 10;
                        break;
                      case 'Qualified':
                        _probability = 25;
                        break;
                      case 'Proposal':
                        _probability = 50;
                        break;
                      case 'Negotiation':
                        _probability = 75;
                        break;
                      case 'Won':
                        _probability = 100;
                        break;
                      case 'Lost':
                        _probability = 0;
                        break;
                    }
                  });
                },
              ),
              SizedBox(height: 12),
              Text('Probability: $_probability%',
                  style: TextStyle(fontFamily: 'Cairo')),
              Slider(
                value: _probability.toDouble(),
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _probability = value.toInt();
                  });
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _closeDateController,
                decoration: InputDecoration(
                    labelText: 'Close Date', border: OutlineInputBorder()),
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
              final newOpportunity = {
                'id': 'OP${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'customer': widget.lead != null
                    ? widget.lead!['company']
                    : widget.customer!['company'],
                'customer_id':
                    widget.lead != null ? '' : widget.customer!['id'],
                'stage': _selectedStage,
                'value': double.parse(_valueController.text),
                'probability': _probability,
                'close_date': _closeDateController.text,
                'assigned_to': 'Ahmed Hassan',
                'created_date': '2024-01-25',
                'last_activity': '2024-01-25',
                'products': ['Product Package'],
                'competitors': [],
                'notes':
                    'Created from ${widget.lead != null ? 'lead' : 'customer'}',
              };
              widget.onOpportunityCreated(newOpportunity);
              Navigator.pop(context);
            }
          },
          child: Text('Create', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class CreateQuotationDialog extends StatefulWidget {
  final Map<String, dynamic> opportunity;
  final Function(Map<String, dynamic>) onQuotationCreated;

  const CreateQuotationDialog({
    super.key,
    required this.opportunity,
    required this.onQuotationCreated,
  });

  @override
  State<CreateQuotationDialog> createState() => _CreateQuotationDialogState();
}

class _CreateQuotationDialogState extends State<CreateQuotationDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _validUntilController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _validUntilController.text = '2024-02-15';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Quotation',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Opportunity: ${widget.opportunity['name']}',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Customer: ${widget.opportunity['customer']}',
                  style: TextStyle(fontFamily: 'Cairo')),
              SizedBox(height: 8),
              Text('Value: \$${widget.opportunity['value']}',
                  style: TextStyle(fontFamily: 'Cairo')),
              SizedBox(height: 16),
              TextFormField(
                controller: _validUntilController,
                decoration: InputDecoration(
                    labelText: 'Valid Until', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter validity date' : null,
              ),
              SizedBox(height: 12),
              Text('Products:',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ...widget.opportunity['products'].map<Widget>((product) =>
                  ListTile(
                    leading:
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                    title: Text(product,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
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
            if (_formKey.currentState!.validate()) {
              final newQuotation = {
                'id': 'Q${DateTime.now().millisecondsSinceEpoch}',
                'number': 'QT-2024-00${_quotations.length + 1}',
                'customer': widget.opportunity['customer'],
                'customer_id': widget.opportunity['customer_id'],
                'opportunity_id': widget.opportunity['id'],
                'amount': widget.opportunity['value'],
                'status': 'Draft',
                'valid_until': _validUntilController.text,
                'created_date': '2024-01-25',
                'products': widget.opportunity['products']
                    .map((product) => {
                          'name': product,
                          'quantity': 1,
                          'price': widget.opportunity['value'] /
                              widget.opportunity['products'].length
                        })
                    .toList(),
              };
              widget.onQuotationCreated(newQuotation);
              Navigator.pop(context);
            }
          },
          child:
              Text('Create Quotation', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class PipelineViewPage extends StatelessWidget {
  final List<Map<String, dynamic>> opportunities;
  final Function(List<Map<String, dynamic>>) onOpportunityUpdated;

  const PipelineViewPage({
    super.key,
    required this.opportunities,
    required this.onOpportunityUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Pipeline', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Drag opportunities between stages',
                style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildPipelineStage('New',
                      opportunities.where((o) => o['stage'] == 'New').toList()),
                  _buildPipelineStage(
                      'Qualified',
                      opportunities
                          .where((o) => o['stage'] == 'Qualified')
                          .toList()),
                  _buildPipelineStage(
                      'Proposal',
                      opportunities
                          .where((o) => o['stage'] == 'Proposal')
                          .toList()),
                  _buildPipelineStage(
                      'Negotiation',
                      opportunities
                          .where((o) => o['stage'] == 'Negotiation')
                          .toList()),
                  _buildPipelineStage('Won',
                      opportunities.where((o) => o['stage'] == 'Won').toList()),
                  _buildPipelineStage(
                      'Lost',
                      opportunities
                          .where((o) => o['stage'] == 'Lost')
                          .toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineStage(
      String stage, List<Map<String, dynamic>> stageOpportunities) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(stage,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${stageOpportunities.length}',
                      style:
                          TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: _getStatusColor(stage),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...stageOpportunities
                .map((opportunity) => Draggable<Map<String, dynamic>>(
                      data: opportunity,
                      feedback: Material(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(opportunity['name'],
                                style: TextStyle(fontFamily: 'Cairo')),
                          ),
                        ),
                      ),
                      childWhenDragging: Container(),
                      child: Card(
                        color: _getStatusColor(stage).withOpacity(0.1),
                        child: ListTile(
                          title: Text(opportunity['name'],
                              style: TextStyle(fontFamily: 'Cairo')),
                          subtitle: Text(
                              '\$${opportunity['value']} • ${opportunity['probability']}%',
                              style: TextStyle(fontFamily: 'Cairo')),
                          trailing: Icon(Icons.drag_handle,
                              color: _getStatusColor(stage)),
                        ),
                      ),
                    )),
            if (stageOpportunities.isEmpty)
              Container(
                padding: EdgeInsets.all(16),
                child: Text('No opportunities in this stage',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Qualified':
        return Colors.orange;
      case 'Proposal':
        return Colors.purple;
      case 'Negotiation':
        return Colors.deepOrange;
      case 'Won':
        return Colors.green;
      case 'Lost':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class FilterBottomSheet extends StatelessWidget {
  final Function(String) onFilterApplied;

  const FilterBottomSheet({super.key, required this.onFilterApplied});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Filter Options',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ...['All', 'High Priority', 'Overdue', 'This Week', 'This Month']
              .map((filter) => ListTile(
                    title: Text(filter, style: TextStyle(fontFamily: 'Cairo')),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      onFilterApplied(filter);
                      Navigator.pop(context);
                    },
                  )),
        ],
      ),
    );
  }
}

// Sample data for quotations (needed in CreateQuotationDialog)
List<Map<String, dynamic>> _quotations = [];

