import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProjectsPage extends StatefulWidget {
  final dynamic user;
  
  const ProjectsPage({super.key, this.user});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample project data
  final List<Map<String, dynamic>> _projects = [
    {
      'id': 'P001', 
      'name': 'ERP System Development', 
      'client': 'Tech Solutions Inc.', 
      'status': 'in_progress',
      'priority': 'high',
      'progress': 65.0,
      'budget': 150000,
      'spent': 98000,
      'startDate': '2024-01-15',
      'endDate': '2024-06-30',
      'manager': 'Ahmed Mohamed',
      'teamSize': 8
    },
    {
      'id': 'P002', 
      'name': 'Mobile App Launch', 
      'client': 'Startup XYZ', 
      'status': 'planning',
      'priority': 'medium',
      'progress': 25.0,
      'budget': 75000,
      'spent': 15000,
      'startDate': '2024-03-01',
      'endDate': '2024-08-15',
      'manager': 'Sarah Ahmed',
      'teamSize': 5
    },
    {
      'id': 'P003', 
      'name': 'Website Redesign', 
      'client': 'Corporate Ltd.', 
      'status': 'completed',
      'priority': 'low',
      'progress': 100.0,
      'budget': 45000,
      'spent': 42000,
      'startDate': '2024-01-10',
      'endDate': '2024-04-20',
      'manager': 'Yasser Ali',
      'teamSize': 4
    },
    {
      'id': 'P004', 
      'name': 'Cloud Migration', 
      'client': 'Enterprise Corp', 
      'status': 'in_progress',
      'priority': 'high',
      'progress': 45.0,
      'budget': 200000,
      'spent': 110000,
      'startDate': '2024-02-01',
      'endDate': '2024-09-30',
      'manager': 'Ahmed Mohamed',
      'teamSize': 12
    },
    {
      'id': 'P005', 
      'name': 'CRM Implementation', 
      'client': 'Sales Company', 
      'status': 'on_hold',
      'priority': 'medium',
      'progress': 30.0,
      'budget': 90000,
      'spent': 28000,
      'startDate': '2024-03-15',
      'endDate': '2024-07-30',
      'manager': 'Sarah Ahmed',
      'teamSize': 6
    },
  ];

  final List<Map<String, dynamic>> _tasks = [
    {'id': 'T001', 'project': 'P001', 'title': 'Database Design', 'assignee': 'Ahmed', 'status': 'completed', 'dueDate': '2024-02-15', 'priority': 'high'},
    {'id': 'T002', 'project': 'P001', 'title': 'Backend Development', 'assignee': 'Mohamed', 'status': 'in_progress', 'dueDate': '2024-04-30', 'priority': 'high'},
    {'id': 'T003', 'project': 'P001', 'title': 'UI/UX Design', 'assignee': 'Sarah', 'status': 'in_progress', 'dueDate': '2024-03-30', 'priority': 'medium'},
    {'id': 'T004', 'project': 'P002', 'title': 'Market Research', 'assignee': 'Yasser', 'status': 'completed', 'dueDate': '2024-03-10', 'priority': 'medium'},
    {'id': 'T005', 'project': 'P002', 'title': 'Prototype Development', 'assignee': 'Ali', 'status': 'to_do', 'dueDate': '2024-05-15', 'priority': 'high'},
  ];

  final List<Map<String, dynamic>> _teamMembers = [
    {'id': 'TM001', 'name': 'Ahmed Mohamed', 'role': 'Project Manager', 'workload': 75, 'skills': ['Flutter', 'Dart', 'Firebase']},
    {'id': 'TM002', 'name': 'Sarah Ahmed', 'role': 'UI/UX Designer', 'workload': 60, 'skills': ['Figma', 'Adobe XD', 'Photoshop']},
    {'id': 'TM003', 'name': 'Yasser Ali', 'role': 'Backend Developer', 'workload': 85, 'skills': ['Node.js', 'MongoDB', 'Python']},
    {'id': 'TM004', 'name': 'Mohamed Hassan', 'role': 'Frontend Developer', 'workload': 70, 'skills': ['React', 'JavaScript', 'HTML/CSS']},
    {'id': 'TM005', 'name': 'Ali Naif', 'role': 'QA Engineer', 'workload': 55, 'skills': ['Testing', 'Automation', 'Selenium']},
  ];

  // Chart data
  List<ChartData> get _projectProgressData => _projects.map((project) {
    return ChartData(
      project['name'],
      project['progress'].toDouble(),
      _getStatusColor(project['status']),
    );
  }).toList();

  List<ChartData> get _budgetData => [
    ChartData('Planned', _projects.map((p) => p['budget']).reduce((a, b) => a + b).toDouble(), Colors.blue),
    ChartData('Actual', _projects.map((p) => p['spent']).reduce((a, b) => a + b).toDouble(), Colors.green),
    ChartData('Remaining', (_projects.map((p) => p['budget']).reduce((a, b) => a + b) - _projects.map((p) => p['spent']).reduce((a, b) => a + b)).toDouble(), Colors.orange),
  ];

  List<ChartData> get _teamWorkloadData => _teamMembers.map((member) {
    return ChartData(
      member['name'].split(' ')[0], // First name only
      member['workload'].toDouble(),
      _getWorkloadColor(member['workload']),
    );
  }).toList();

  List<ChartData> get _projectStatusData {
    final statusCount = {
      'Planning': 0,
      'In Progress': 0,
      'Completed': 0,
      'On Hold': 0,
    };
    
    for (var project in _projects) {
      final status = _getStatusText(project['status']);
      statusCount[status] = statusCount[status]! + 1;
    }
    
    return [
      ChartData('Planning', statusCount['Planning']!.toDouble(), Colors.blue),
      ChartData('In Progress', statusCount['In Progress']!.toDouble(), Colors.green),
      ChartData('Completed', statusCount['Completed']!.toDouble(), Colors.orange),
      ChartData('On Hold', statusCount['On Hold']!.toDouble(), Colors.red),
    ];
  }

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

  // Core Project Functions
  void _showProjectDetails(Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Project Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Project ID', project['id']),
              _buildDetailRow('Project Name', project['name']),
              _buildDetailRow('Client', project['client']),
              _buildDetailRow('Status', _getStatusText(project['status'])),
              _buildDetailRow('Priority', project['priority'].toString().toUpperCase()),
              _buildDetailRow('Progress', '${project['progress']}%'),
              _buildDetailRow('Budget', '\$${project['budget']}'),
              _buildDetailRow('Spent', '\$${project['spent']}'),
              _buildDetailRow('Manager', project['manager']),
              _buildDetailRow('Team Size', project['teamSize'].toString()),
              _buildDetailRow('Start Date', project['startDate']),
              _buildDetailRow('End Date', project['endDate']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _editProject(project),
            child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _editProject(Map<String, dynamic> project) {
    Navigator.pop(context); // Close details dialog first
    
    showDialog(
      context: context,
      builder: (context) => AddProjectDialog(
        project: project,
        onProjectAdded: (updatedProject) {
          setState(() {
            final index = _projects.indexWhere((p) => p['id'] == project['id']);
            if (index != -1) {
              _projects[index] = {..._projects[index], ...updatedProject};
            }
          });
        },
      ),
    );
  }

  void _deleteProject(Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Project', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to delete ${project['name']}?', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _projects.removeWhere((p) => p['id'] == project['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Project deleted successfully', style: TextStyle(fontFamily: 'Cairo'))),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddProjectDialog() {
    showDialog(
      context: context,
      builder: (context) => AddProjectDialog(
        onProjectAdded: (project) {
          setState(() {
            _projects.add(project);
          });
        },
      ),
    );
  }

  // Utility Functions
  String _getStatusText(String status) {
    switch (status) {
      case 'planning': return 'Planning';
      case 'in_progress': return 'In Progress';
      case 'on_hold': return 'On Hold';
      case 'completed': return 'Completed';
      default: return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed': return Colors.green;
      case 'in_progress': return Colors.blue;
      case 'on_hold': return Colors.orange;
      case 'planning': return Colors.grey;
      default: return Colors.grey;
    }
  }

  Color _getWorkloadColor(int workload) {
    if (workload > 80) return Colors.red;
    if (workload > 60) return Colors.orange;
    return Colors.green;
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

  // Filtered data based on search
  List<Map<String, dynamic>> get _filteredProjects {
    if (_searchQuery.isEmpty) return _projects;
    return _projects.where((project) =>
      project['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      project['client'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      project['manager'].toLowerCase().contains(_searchQuery.toLowerCase())
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
          'Project Management',
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
            Tab(text: 'Portfolio'),
            Tab(text: 'Tasks'),
            Tab(text: 'Timeline'),
            Tab(text: 'Resources'),
            Tab(text: 'Budget'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildPortfolioTab(),
          _buildTasksTab(),
          _buildTimelineTab(),
          _buildResourcesTab(),
          _buildBudgetTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    final totalProjects = _projects.length;
    final completedProjects = _projects.where((p) => p['status'] == 'completed').length;
    final inProgressProjects = _projects.where((p) => p['status'] == 'in_progress').length;
    final overdueProjects = _projects.where((p) => p['progress'] < 100 && DateTime.parse(p['endDate']).isBefore(DateTime.now())).length;
    final totalBudget = _projects.map((p) => p['budget']).reduce((a, b) => a + b);
    final totalSpent = _projects.map((p) => p['spent']).reduce((a, b) => a + b);
    final budgetUsage = totalBudget > 0 ? (totalSpent / totalBudget * 100) : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // KPI Cards - Fixed layout
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildStatCard('Total Projects', totalProjects.toString(), Colors.blue, Icons.assignment),
              _buildStatCard('Completed', completedProjects.toString(), Colors.green, Icons.check_circle),
              _buildStatCard('In Progress', inProgressProjects.toString(), Colors.orange, Icons.trending_up),
              _buildStatCard('Overdue', overdueProjects.toString(), Colors.red, Icons.warning),
              _buildStatCard('Budget Usage', '${budgetUsage.toStringAsFixed(1)}%', Colors.purple, Icons.attach_money),
              _buildStatCard('Total Budget', '\$${totalBudget.toStringAsFixed(0)}', Colors.teal, Icons.account_balance_wallet),
            ],
          ),

          SizedBox(height: 20),

          // Charts Section
          Text('Project Analytics', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),

          // Project Progress Chart - FIXED
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Project Progress', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                      ),
                      primaryYAxis: NumericAxis(
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                        minimum: 0,
                        maximum: 100,
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        BarSeries<ChartData, String>(
                          dataSource: _projectProgressData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(fontFamily: 'Cairo', fontSize: 10),
                          ),
                          name: 'Progress %',
                        )
                      ],
                      tooltipBehavior: TooltipBehavior(enable: true),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Project Status Distribution - NEW PIE CHART
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Project Status Distribution', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: SfCircularChart(
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        textStyle: TextStyle(fontFamily: 'Cairo'),
                      ),
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: _projectStatusData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(fontFamily: 'Cairo'),
                          ),
                        )
                      ],
                      tooltipBehavior: TooltipBehavior(enable: true),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Budget Overview Chart - FIXED
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Budget Overview', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                      ),
                      primaryYAxis: NumericAxis(
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                        numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 0),
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          dataSource: _budgetData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(fontFamily: 'Cairo'),
                          ),
                          name: 'Amount',
                        )
                      ],
                      tooltipBehavior: TooltipBehavior(enable: true),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Recent Activity
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Activity', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                      Chip(
                        label: Text('${_tasks.length} tasks', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ..._tasks.take(3).map((task) => _buildActivityItem(task)),
                  if (_tasks.length > 3)
                    Center(
                      child: TextButton(
                        onPressed: () {
                          _tabController.animateTo(2); // Navigate to Tasks tab
                        },
                        child: Text('View All Tasks', style: TextStyle(fontFamily: 'Cairo')),
                      ),
                    ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPortfolioTab() {
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
                    hintText: 'Search projects...',
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
                onPressed: _showProjectFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredProjects.length,
            itemBuilder: (context, index) {
              final project = _filteredProjects[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.assignment, color: AppColors.primaryColor),
                  ),
                  title: Text(project['name'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${project['client']} - ${project['manager']}', style: TextStyle(fontFamily: 'Cairo')),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: project['progress'] / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(project['status'])),
                      ),
                      SizedBox(height: 4),
                      Text('${project['progress']}% Complete', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('View Details', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showProjectDetails(project),
                      ),
                      PopupMenuItem(
                        child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _editProject(project),
                      ),
                      PopupMenuItem(
                        child: Text('Delete', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _deleteProject(project),
                      ),
                    ],
                  ),
                  onTap: () => _showProjectDetails(project),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._tasks.map((task) => _buildTaskCard(task)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _showAddTaskDialog,
            icon: Icon(Icons.add),
            label: Text('Add New Task', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Project Timeline', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 400,
                    child: CustomGanttChart(projects: _projects),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Team Workload', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                      ),
                      primaryYAxis: NumericAxis(
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                        minimum: 0,
                        maximum: 100,
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        BarSeries<ChartData, String>(
                          dataSource: _teamWorkloadData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(fontFamily: 'Cairo'),
                          ),
                          name: 'Workload %',
                        )
                      ],
                      tooltipBehavior: TooltipBehavior(enable: true),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          ..._teamMembers.map((member) => _buildTeamMemberCard(member)),
        ],
      ),
    );
  }

  Widget _buildBudgetTab() {
    final totalBudget = _projects.map((p) => p['budget']).reduce((a, b) => a + b);
    final totalSpent = _projects.map((p) => p['spent']).reduce((a, b) => a + b);
    final remainingBudget = totalBudget - totalSpent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Financial Overview', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  _buildFinancialMetric('Total Budget', '\$${totalBudget.toStringAsFixed(0)}', Colors.blue),
                  _buildFinancialMetric('Total Spent', '\$${totalSpent.toStringAsFixed(0)}', Colors.orange),
                  _buildFinancialMetric('Remaining Budget', '\$${remainingBudget.toStringAsFixed(0)}', Colors.green),
                  _buildFinancialMetric('Budget Utilization', '${(totalSpent / totalBudget * 100).toStringAsFixed(1)}%', Colors.purple),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Project Budget Breakdown', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._projects.map((project) => _buildProjectBudgetItem(project)),
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
      case 1: // Portfolio
        return FloatingActionButton(
          onPressed: _showAddProjectDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 2: // Tasks
        return FloatingActionButton(
          onPressed: _showAddTaskDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add_task, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: _showAddProjectDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
    }
  }

  // Helper Widgets
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return SizedBox(
      width: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(height: 8),
              Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600], fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> task) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          task['status'] == 'completed' ? Icons.check_circle : 
          task['status'] == 'in_progress' ? Icons.play_arrow : Icons.pending,
          color: task['status'] == 'completed' ? Colors.green : 
                 task['status'] == 'in_progress' ? Colors.blue : Colors.orange,
        ),
        title: Text(task['title'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Text('Assigned to: ${task['assignee']}', style: TextStyle(fontFamily: 'Cairo')),
        trailing: Text(task['dueDate'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.task, color: AppColors.primaryColor),
        title: Text(task['title'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Project: ${_projects.firstWhere((p) => p['id'] == task['project'])['name']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Assignee: ${task['assignee']} • Due: ${task['dueDate']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Chip(
          label: Text(task['status'].replaceAll('_', ' '), style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          backgroundColor: _getStatusColor(task['status']),
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(Map<String, dynamic> member) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Text(member['name'][0], style: TextStyle(color: AppColors.primaryColor)),
        ),
        title: Text(member['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(member['role'], style: TextStyle(fontFamily: 'Cairo')),
            SizedBox(height: 4),
            LinearProgressIndicator(
              value: member['workload'] / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(_getWorkloadColor(member['workload'])),
            ),
            Text('Workload: ${member['workload']}%', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialMetric(String title, String value, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(Icons.attach_money, color: color),
        title: Text(title, style: TextStyle(fontFamily: 'Cairo')),
        trailing: Text(value, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }

  Widget _buildProjectBudgetItem(Map<String, dynamic> project) {
    final remaining = project['budget'] - project['spent'];
    final utilization = (project['spent'] / project['budget'] * 100);
    
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(Icons.assignment, color: AppColors.primaryColor),
        title: Text(project['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Budget: \$${project['budget']} • Spent: \$${project['spent']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Remaining: \$$remaining • Utilization: ${utilization.toStringAsFixed(1)}%', 
              style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Chip(
          label: Text('${project['progress']}%', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          backgroundColor: _getStatusColor(project['status']),
        ),
      ),
    );
  }

  void _showProjectFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Projects', style: TextStyle(fontFamily: 'Cairo')),
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

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Task', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Task creation functionality to be implemented', style: TextStyle(fontFamily: 'Cairo')),
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

// Chart Data Model
class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, this.color);
}

// Custom Gantt Chart Widget
class CustomGanttChart extends StatelessWidget {
  final List<Map<String, dynamic>> projects;

  const CustomGanttChart({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2, child: Text('Project Name', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Timeline', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('Progress', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          // Tasks
          ...List.generate(projects.length, (index) => _buildGanttRow(projects[index])),
        ],
      ),
    );
  }

  Widget _buildGanttRow(Map<String, dynamic> project) {
    Color getStatusColor(String status) {
      switch (status) {
        case 'completed': return Colors.green;
        case 'in_progress': return Colors.blue;
        case 'on_hold': return Colors.orange;
        case 'planning': return Colors.grey;
        default: return Colors.grey;
      }
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(project['name'], style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 2,
            child: Text('${_formatDate(project['startDate'])} - ${_formatDate(project['endDate'])}', 
              style: TextStyle(fontFamily: 'Cairo')),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: project['progress'] / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(getStatusColor(project['status'])),
                  ),
                ),
                SizedBox(width: 8),
                Text('${project['progress']}%', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Add Project Dialog
class AddProjectDialog extends StatefulWidget {
  final Map<String, dynamic>? project;
  final Function(Map<String, dynamic>) onProjectAdded;

  const AddProjectDialog({super.key, this.project, required this.onProjectAdded});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _clientController = TextEditingController();
  final _budgetController = TextEditingController();
  String _selectedStatus = 'planning';
  String _selectedPriority = 'medium';

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _nameController.text = widget.project!['name'];
      _clientController.text = widget.project!['client'];
      _budgetController.text = widget.project!['budget'].toString();
      _selectedStatus = widget.project!['status'];
      _selectedPriority = widget.project!['priority'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.project == null ? 'Add New Project' : 'Edit Project', 
                style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Project Name'),
                validator: (value) => value!.isEmpty ? 'Please enter project name' : null,
              ),
              TextFormField(
                controller: _clientController,
                decoration: InputDecoration(labelText: 'Client'),
                validator: (value) => value!.isEmpty ? 'Please enter client name' : null,
              ),
              TextFormField(
                controller: _budgetController,
                decoration: InputDecoration(labelText: 'Budget'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter budget' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedStatus,
                items: ['planning', 'in_progress', 'on_hold', 'completed']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status.replaceAll('_', ' ')),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
                decoration: InputDecoration(labelText: 'Status'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedPriority,
                items: ['high', 'medium', 'low']
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedPriority = value!),
                decoration: InputDecoration(labelText: 'Priority'),
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
              widget.onProjectAdded({
                'id': widget.project?['id'] ?? 'P${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'client': _clientController.text,
                'status': _selectedStatus,
                'priority': _selectedPriority,
                'progress': widget.project?['progress'] ?? 0.0,
                'budget': int.parse(_budgetController.text),
                'spent': widget.project?['spent'] ?? 0,
                'startDate': widget.project?['startDate'] ?? '2024-01-01',
                'endDate': widget.project?['endDate'] ?? '2024-12-31',
                'manager': widget.project?['manager'] ?? 'Project Manager',
                'teamSize': widget.project?['teamSize'] ?? 1,
              });
              Navigator.pop(context);
            }
          },
          child: Text(widget.project == null ? 'Add Project' : 'Update Project', 
                    style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}