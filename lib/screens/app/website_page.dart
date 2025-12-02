import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class WebsitePage extends StatefulWidget {
  final UserModel? user;
  
  const WebsitePage({super.key, this.user});

  @override
  State<WebsitePage> createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Sample data for demonstration
  final List<Map<String, dynamic>> _websites = [
    {
      'id': 'WS001',
      'name': 'Main Company Website',
      'domain': 'www.company.com',
      'status': 'Online',
      'theme': 'Business Pro',
      'visitorsToday': 245,
      'visitorsThisMonth': 5240,
      'ordersToday': 12,
      'leadsToday': 8,
      'seoScore': 85,
      'lastUpdated': '2024-01-15'
    },
    {
      'id': 'WS002', 
      'name': 'E-commerce Store',
      'domain': 'shop.company.com',
      'status': 'Online',
      'theme': 'Shop Master',
      'visitorsToday': 189,
      'visitorsThisMonth': 3890,
      'ordersToday': 23,
      'leadsToday': 5,
      'seoScore': 78,
      'lastUpdated': '2024-01-14'
    },
    {
      'id': 'WS003',
      'name': 'Blog Portal',
      'domain': 'blog.company.com', 
      'status': 'Maintenance',
      'theme': 'Minimal Blog',
      'visitorsToday': 67,
      'visitorsThisMonth': 1560,
      'ordersToday': 0,
      'leadsToday': 3,
      'seoScore': 92,
      'lastUpdated': '2024-01-10'
    },
  ];

  final List<Map<String, dynamic>> _pages = [
    {
      'id': 'P001',
      'title': 'Home',
      'url': '/',
      'status': 'Published',
      'visitors': 1250,
      'lastModified': '2024-01-15',
      'seoScore': 88,
      'author': 'Admin'
    },
    {
      'id': 'P002',
      'title': 'About Us',
      'url': '/about',
      'status': 'Published', 
      'visitors': 890,
      'lastModified': '2024-01-12',
      'seoScore': 76,
      'author': 'Admin'
    },
    {
      'id': 'P003',
      'title': 'Services',
      'url': '/services',
      'status': 'Draft',
      'visitors': 0,
      'lastModified': '2024-01-14',
      'seoScore': 65,
      'author': 'Editor'
    },
    {
      'id': 'P004',
      'title': 'Contact',
      'url': '/contact',
      'status': 'Published',
      'visitors': 670,
      'lastModified': '2024-01-10',
      'seoScore': 82,
      'author': 'Admin'
    },
  ];

  final List<Map<String, dynamic>> _blogPosts = [
    {
      'id': 'B001',
      'title': 'Introducing Our New Product Line',
      'category': 'News',
      'status': 'Published',
      'publishDate': '2024-01-15',
      'author': 'John Smith',
      'views': 1245,
      'comments': 23,
      'featured': true
    },
    {
      'id': 'B002',
      'title': 'Industry Trends 2024',
      'category': 'Insights',
      'status': 'Published',
      'publishDate': '2024-01-12',
      'author': 'Sarah Johnson',
      'views': 890,
      'comments': 15,
      'featured': true
    },
    {
      'id': 'B003',
      'title': 'Customer Success Story',
      'category': 'Case Studies',
      'status': 'Draft',
      'publishDate': '2024-01-18',
      'author': 'Mike Davis',
      'views': 0,
      'comments': 0,
      'featured': false
    },
  ];

  final List<Map<String, dynamic>> _mediaLibrary = [
    {
      'id': 'M001',
      'name': 'company-hero.jpg',
      'type': 'image',
      'size': '2.4 MB',
      'dimensions': '1920x1080',
      'uploadDate': '2024-01-15',
      'usage': 5,
      'folder': 'Homepage'
    },
    {
      'id': 'M002',
      'name': 'product-catalog.pdf',
      'type': 'document',
      'size': '4.2 MB',
      'dimensions': '-',
      'uploadDate': '2024-01-14',
      'usage': 2,
      'folder': 'Documents'
    },
    {
      'id': 'M003',
      'name': 'team-photo.jpg',
      'type': 'image',
      'size': '3.1 MB',
      'dimensions': '1200x800',
      'uploadDate': '2024-01-12',
      'usage': 3,
      'folder': 'About'
    },
  ];

  final List<Map<String, dynamic>> _forms = [
    {
      'id': 'F001',
      'name': 'Contact Form',
      'type': 'Contact',
      'submissions': 45,
      'conversionRate': '12%',
      'lastSubmission': '2024-01-15',
      'status': 'Active'
    },
    {
      'id': 'F002',
      'name': 'Newsletter Signup',
      'type': 'Subscription',
      'submissions': 89,
      'conversionRate': '8%',
      'lastSubmission': '2024-01-14',
      'status': 'Active'
    },
    {
      'id': 'F003',
      'name': 'Job Application',
      'type': 'Career',
      'submissions': 12,
      'conversionRate': '5%',
      'lastSubmission': '2024-01-13',
      'status': 'Active'
    },
  ];

  final List<Map<String, dynamic>> _analytics = [
    {
      'period': 'Today',
      'visitors': 245,
      'pageViews': 890,
      'bounceRate': '32%',
      'avgSession': '00:03:45',
      'conversions': 8
    },
    {
      'period': 'This Week',
      'visitors': 1560,
      'pageViews': 5230,
      'bounceRate': '28%',
      'avgSession': '00:04:12',
      'conversions': 45
    },
    {
      'period': 'This Month',
      'visitors': 5240,
      'pageViews': 18900,
      'bounceRate': '30%',
      'avgSession': '00:03:58',
      'conversions': 167
    },
  ];

  final List<Map<String, dynamic>> _themes = [
    {
      'id': 'T001',
      'name': 'Business Pro',
      'category': 'Corporate',
      'status': 'Active',
      'customizable': true,
      'responsive': true,
      'preview': 'business_pro'
    },
    {
      'id': 'T002',
      'name': 'Shop Master',
      'category': 'E-commerce',
      'status': 'Active',
      'customizable': true,
      'responsive': true,
      'preview': 'shop_master'
    },
    {
      'id': 'T003',
      'name': 'Minimal Blog',
      'category': 'Blog',
      'status': 'Inactive',
      'customizable': true,
      'responsive': true,
      'preview': 'minimal_blog'
    },
  ];

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

  // Core Website Functions
  void _showWebsiteDetails(Map<String, dynamic> website) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Website Details',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Website Name', website['name']),
              _buildDetailRow('Domain', website['domain']),
              _buildDetailRow('Status', website['status']),
              _buildDetailRow('Theme', website['theme']),
              _buildDetailRow(
                  'Visitors Today', website['visitorsToday'].toString()),
              _buildDetailRow('Visitors This Month',
                  website['visitorsThisMonth'].toString()),
              _buildDetailRow('SEO Score', '${website['seoScore']}%'),
              _buildDetailRow('Last Updated', website['lastUpdated']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _editWebsite(website),
            child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _editWebsite(Map<String, dynamic> website) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AddWebsiteDialog(
        website: website,
        onWebsiteAdded: (updatedWebsite) {
          setState(() {
            final index = _websites.indexWhere((w) => w['id'] == website['id']);
            if (index != -1) {
              _websites[index] = {..._websites[index], ...updatedWebsite};
            }
          });
        },
      ),
    );
  }

  void _showAddWebsiteDialog() {
    showDialog(
      context: context,
      builder: (context) => AddWebsiteDialog(
        onWebsiteAdded: (website) {
          setState(() {
            _websites.add(website);
          });
        },
      ),
    );
  }

  void _showPageBuilder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageBuilderPage(
          onPageSaved: (newPage) {
            setState(() {
              _pages.add(newPage);
            });
          },
        ),
      ),
    );
  }

  void _showSEOTools() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SEOToolsSheet(
        onSEOSaved: (seoData) {
          // Handle SEO data saving
        },
      ),
    );
  }

  void _showMediaLibrary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaLibraryPage(
          mediaItems: _mediaLibrary,
          onMediaUpdated: (updatedMedia) {
            setState(() {
              // Update media library
            });
          },
        ),
      ),
    );
  }

  void _showFormBuilder() {
    showDialog(
      context: context,
      builder: (context) => FormBuilderDialog(
        onFormCreated: (newForm) {
          setState(() {
            _forms.add(newForm);
          });
        },
      ),
    );
  }

  void _showThemeCustomizer() {
    showDialog(
      context: context,
      builder: (context) => ThemeCustomizerDialog(
        themes: _themes,
        onThemeChanged: (theme) {
          // Handle theme change
        },
      ),
    );
  }

  void _showAnalyticsDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalyticsDetailPage(analytics: _analytics),
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
    switch (status.toLowerCase()) {
      case 'online':
      case 'published':
      case 'active':
        return Colors.green;
      case 'draft':
        return Colors.orange;
      case 'maintenance':
      case 'inactive':
        return Colors.red;
      default:
        return Colors.grey;
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
          'Website Management',
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
            Tab(text: 'Pages'),
            Tab(text: 'Blog'),
            Tab(text: 'Media'),
            Tab(text: 'Forms'),
            Tab(text: 'SEO'),
            Tab(text: 'Themes'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildPagesTab(),
          _buildBlogTab(),
          _buildMediaTab(),
          _buildFormsTab(),
          _buildSEOTab(),
          _buildThemesTab(),
          _buildAnalyticsTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    final totalWebsites = _websites.length;
    final totalVisitors = _websites.fold<int>(0, (sum, website) => sum + website['visitorsToday'] as int);
    final totalOrders = _websites.fold<int>(0, (sum, website) => sum + website['ordersToday'] as int);
    final totalLeads = _websites.fold<int>(0, (sum, website) => sum + website['leadsToday'] as int);
    final avgSEOScore = _websites.isNotEmpty ? _websites.fold<double>(0.0, (double sum, website) => sum + (website['seoScore'] as int).toDouble()) / _websites.length : 0.0;


    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
          Row(
            children: [
              _buildStatCard('Websites', totalWebsites.toString(), Colors.blue, Icons.language),
              SizedBox(width: 12),
              _buildStatCard('Visitors Today', totalVisitors.toString(), Colors.green, Icons.people),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Orders Today', totalOrders.toString(), Colors.orange, Icons.shopping_cart),
              SizedBox(width: 12),
              _buildStatCard('Leads Today', totalLeads.toString(), Colors.red, Icons.trending_up),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Avg SEO Score', '${avgSEOScore.toStringAsFixed(0)}%', Colors.teal, Icons.analytics),
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
              _buildActionButton('Build Page', Icons.dashboard, Colors.blue, _showPageBuilder),
              _buildActionButton('SEO Tools', Icons.trending_up, Colors.green, _showSEOTools),
              _buildActionButton('Media Library', Icons.photo_library, Colors.orange, _showMediaLibrary),
              _buildActionButton('Create Form', Icons.list_alt, Colors.purple, _showFormBuilder),
              _buildActionButton('Customize Theme', Icons.palette, Colors.brown, _showThemeCustomizer),
              _buildActionButton('View Analytics', Icons.analytics, Colors.red, _showAnalyticsDetails),
              _buildActionButton('Add Website', Icons.add, Colors.teal, _showAddWebsiteDialog),
            ],
          ),

          // Recent Websites
          SizedBox(height: 20),
          _buildRecentWebsites(),

          // Performance Overview
          SizedBox(height: 20),
          _buildPerformanceOverview(),
        ],
      ),
    );
  }

  Widget _buildPagesTab() {
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
                    hintText: 'Search pages...',
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
                onPressed: _showPageFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.article, color: AppColors.primaryColor),
                  ),
                  title: Text(page['title'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(page['url'], style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(page['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              page['status'],
                              style: TextStyle(
                                color: _getStatusColor(page['status']),
                                fontSize: 10,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('${page['visitors']} visitors', style: TextStyle(fontFamily: 'Cairo', fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _editPage(page),
                      ),
                      PopupMenuItem(
                        child: Text('View', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _viewPage(page),
                      ),
                      PopupMenuItem(
                        child: Text('SEO', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _optimizePageSEO(page),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBlogTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._blogPosts.map((post) => _buildBlogPostCard(post)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _createBlogPost,
            icon: Icon(Icons.add),
            label: Text('Create New Post', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: _mediaLibrary.length,
      itemBuilder: (context, index) {
        final media = _mediaLibrary[index];
        return _buildMediaItem(media);
      },
    );
  }

  Widget _buildFormsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._forms.map((form) => _buildFormCard(form)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _showFormBuilder,
            icon: Icon(Icons.add),
            label: Text('Create New Form', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSEOTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSEOScoreCard(),
          SizedBox(height: 20),
          _buildKeywordAnalysis(),
          SizedBox(height: 20),
          _buildSEOSuggestions(),
        ],
      ),
    );
  }

  Widget _buildThemesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: _themes.length,
      itemBuilder: (context, index) {
        final theme = _themes[index];
        return _buildThemeCard(theme);
      },
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildAnalyticsOverview(),
          SizedBox(height: 20),
          ..._analytics.map((data) => _buildAnalyticsCard(data)),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 0: // Dashboard
        return FloatingActionButton(
          onPressed: _showAddWebsiteDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      case 1: // Pages
        return FloatingActionButton(
          onPressed: _showPageBuilder,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.dashboard, color: Colors.white),
        );
      case 2: // Blog
        return FloatingActionButton(
          onPressed: _createBlogPost,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.post_add, color: Colors.white),
        );
      case 3: // Media
        return FloatingActionButton(
          onPressed: _uploadMedia,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.upload, color: Colors.white),
        );
      case 4: // Forms
        return FloatingActionButton(
          onPressed: _showFormBuilder,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.list_alt, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: _showAddWebsiteDialog,
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

  Widget _buildRecentWebsites() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Websites', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('${_websites.length} sites', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 12),
            ..._websites.take(3).map((website) => _buildWebsiteItem(website)),
          ],
        ),
      ),
    );
  }

  Widget _buildWebsiteItem(Map<String, dynamic> website) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(website['status']).withOpacity(0.1),
          child: Icon(Icons.language, color: _getStatusColor(website['status'])),
        ),
        title: Text(website['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(website['domain'], style: TextStyle(fontFamily: 'Cairo')),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(website['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    website['status'],
                    style: TextStyle(
                      color: _getStatusColor(website['status']),
                      fontSize: 10,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.people, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text('${website['visitorsToday']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 10)),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text('${website['seoScore']}%', style: TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 10)),
              backgroundColor: website['seoScore'] >= 80 ? Colors.green : 
                             website['seoScore'] >= 60 ? Colors.orange : Colors.red,
            ),
          ],
        ),
        onTap: () => _showWebsiteDetails(website),
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Performance Overview', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildPerformanceMetric('Page Load Time', '1.2s', Colors.green),
            _buildPerformanceMetric('Uptime', '99.9%', Colors.green),
            _buildPerformanceMetric('Mobile Score', '95/100', Colors.orange),
            _buildPerformanceMetric('Accessibility', '88/100', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetric(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Cairo')),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(value, style: TextStyle(fontFamily: 'Cairo', color: color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogPostCard(Map<String, dynamic> post) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Icon(Icons.article, color: AppColors.primaryColor),
        ),
        title: Text(post['title'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${post['category']} • ${post['author']}', style: TextStyle(fontFamily: 'Cairo')),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(post['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    post['status'],
                    style: TextStyle(
                      color: _getStatusColor(post['status']),
                      fontSize: 10,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.visibility, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text('${post['views']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 10)),
                SizedBox(width: 8),
                Icon(Icons.comment, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text('${post['comments']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 10)),
              ],
            ),
          ],
        ),
        trailing: post['featured'] ? Icon(Icons.star, color: Colors.amber) : null,
      ),
    );
  }

  Widget _buildMediaItem(Map<String, dynamic> media) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Icon(
                  media['type'] == 'image' ? Icons.photo : Icons.description,
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  media['name'],
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '${media['size']} • ${media['folder']}',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(Map<String, dynamic> form) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Icon(Icons.list_alt, color: AppColors.primaryColor),
        ),
        title: Text(form['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(form['type'], style: TextStyle(fontFamily: 'Cairo')),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.download, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text('${form['submissions']} submissions', style: TextStyle(fontFamily: 'Cairo', fontSize: 10)),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(form['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    form['status'],
                    style: TextStyle(
                      color: _getStatusColor(form['status']),
                      fontSize: 10,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Chip(
          label: Text(form['conversionRate'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white, fontSize: 10)),
          backgroundColor: form['conversionRate'] == '12%' ? Colors.green : 
                         form['conversionRate'] == '8%' ? Colors.orange : Colors.blue,
        ),
      ),
    );
  }

  Widget _buildSEOScoreCard() {
    final avgScore = _websites.isNotEmpty ? _websites.fold<double>(0.0, (double sum, website) => sum + (website['seoScore'] as int).toDouble()) / _websites.length : 0.0;
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Overall SEO Score', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: avgScore / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    avgScore >= 80 ? Colors.green : 
                    avgScore >= 60 ? Colors.orange : Colors.red,
                  ),
                ),
                Text(
                  '${avgScore.toStringAsFixed(0)}%',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              avgScore >= 80 ? 'Excellent SEO Performance' :
              avgScore >= 60 ? 'Good SEO Performance' : 'Needs SEO Improvement',
              style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeywordAnalysis() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Keyword Analysis', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildKeywordItem('ERP Software', 45, Colors.green),
            _buildKeywordItem('Business Management', 32, Colors.orange),
            _buildKeywordItem('Cloud Solutions', 28, Colors.blue),
            _buildKeywordItem('Digital Transformation', 19, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildKeywordItem(String keyword, int score, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(keyword, style: TextStyle(fontFamily: 'Cairo')),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$score', style: TextStyle(fontFamily: 'Cairo', color: color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSEOSuggestions() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SEO Suggestions', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildSuggestionItem('Improve page load speed', 'High Priority', Colors.red),
            _buildSuggestionItem('Add meta descriptions', 'Medium Priority', Colors.orange),
            _buildSuggestionItem('Optimize images', 'Medium Priority', Colors.orange),
            _buildSuggestionItem('Fix broken links', 'Low Priority', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(String suggestion, String priority, Color color) {
    return ListTile(
      leading: Icon(Icons.lightbulb_outline, color: color),
      title: Text(suggestion, style: TextStyle(fontFamily: 'Cairo')),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(priority, style: TextStyle(fontFamily: 'Cairo', color: color, fontSize: 10)),
      ),
    );
  }

  Widget _buildThemeCard(Map<String, dynamic> theme) {
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Icon(Icons.palette, color: AppColors.primaryColor, size: 50),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    theme['name'],
                    style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    theme['category'],
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(theme['status']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          theme['status'],
                          style: TextStyle(
                            color: _getStatusColor(theme['status']),
                            fontSize: 10,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      Spacer(),
                      if (theme['status'] == 'Active')
                        Icon(Icons.check_circle, color: Colors.green, size: 16),
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

  Widget _buildAnalyticsOverview() {
    final today = _analytics.firstWhere((a) => a['period'] == 'Today');
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today\'s Overview', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
              children: [
                _buildAnalyticsMetric('Visitors', today['visitors'].toString(), Icons.people),
                _buildAnalyticsMetric('Page Views', today['pageViews'].toString(), Icons.visibility),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildAnalyticsMetric('Bounce Rate', today['bounceRate'], Icons.trending_down),
                _buildAnalyticsMetric('Avg Session', today['avgSession'], Icons.timer),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsMetric(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(Map<String, dynamic> data) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Icon(Icons.analytics, color: AppColors.primaryColor),
        ),
        title: Text(data['period'], style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.people, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text('${data['visitors']} visitors', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                SizedBox(width: 8),
                Icon(Icons.visibility, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text('${data['pageViews']} views', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.trending_up, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text('${data['conversions']} conversions', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data['bounceRate'], style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            Text('Bounce', style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Placeholder functions for actions
  void _showPageFilter() {}
  void _editPage(Map<String, dynamic> page) {}
  void _viewPage(Map<String, dynamic> page) {}
  void _optimizePageSEO(Map<String, dynamic> page) {}
  void _createBlogPost() {}
  void _uploadMedia() {}
}

// Additional Dialog and Page Classes

class AddWebsiteDialog extends StatefulWidget {
  final Map<String, dynamic>? website;
  final Function(Map<String, dynamic>) onWebsiteAdded;

  const AddWebsiteDialog({super.key, this.website, required this.onWebsiteAdded});

  @override
  State<AddWebsiteDialog> createState() => _AddWebsiteDialogState();
}

class _AddWebsiteDialogState extends State<AddWebsiteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _domainController = TextEditingController();
  String _selectedTheme = 'Business Pro';
  String _selectedStatus = 'Online';

  @override
  void initState() {
    super.initState();
    if (widget.website != null) {
      _nameController.text = widget.website!['name'];
      _domainController.text = widget.website!['domain'];
      _selectedTheme = widget.website!['theme'];
      _selectedStatus = widget.website!['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.website == null ? 'Add New Website' : 'Edit Website', 
                style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Website Name'),
                validator: (value) => value!.isEmpty ? 'Please enter website name' : null,
              ),
              TextFormField(
                controller: _domainController,
                decoration: InputDecoration(labelText: 'Domain'),
                validator: (value) => value!.isEmpty ? 'Please enter domain' : null,
              ),
              DropdownButtonFormField(
                initialValue: _selectedTheme,
                items: ['Business Pro', 'Shop Master', 'Minimal Blog']
                    .map((theme) => DropdownMenuItem(value: theme, child: Text(theme)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedTheme = value!),
                decoration: InputDecoration(labelText: 'Theme'),
              ),
              DropdownButtonFormField(
                initialValue: _selectedStatus,
                items: ['Online', 'Maintenance', 'Offline']
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
              widget.onWebsiteAdded({
                'id': widget.website?['id'] ?? 'WS00${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'domain': _domainController.text,
                'status': _selectedStatus,
                'theme': _selectedTheme,
                'visitorsToday': widget.website?['visitorsToday'] ?? 0,
                'visitorsThisMonth': widget.website?['visitorsThisMonth'] ?? 0,
                'ordersToday': widget.website?['ordersToday'] ?? 0,
                'leadsToday': widget.website?['leadsToday'] ?? 0,
                'seoScore': widget.website?['seoScore'] ?? 75,
                'lastUpdated': _formatDate(DateTime.now()),
              });
              Navigator.pop(context);
            }
          },
          child: Text(widget.website == null ? 'Add Website' : 'Update Website', 
                    style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class PageBuilderPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onPageSaved;

  const PageBuilderPage({super.key, required this.onPageSaved});

  @override
  State<PageBuilderPage> createState() => _PageBuilderPageState();
}

class _PageBuilderPageState extends State<PageBuilderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Builder', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, size: 80, color: AppColors.primaryColor),
            SizedBox(height: 20),
            Text('Drag & Drop Page Builder', style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Build beautiful pages with our intuitive drag & drop interface', 
                 style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                widget.onPageSaved({
                  'id': 'P00${DateTime.now().millisecondsSinceEpoch}',
                  'title': 'New Page',
                  'url': '/new-page',
                  'status': 'Draft',
                  'visitors': 0,
                  'lastModified': _formatDate(DateTime.now()),
                  'seoScore': 65,
                  'author': 'Current User'
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.add),
              label: Text('Create New Page', style: TextStyle(fontFamily: 'Cairo')),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class SEOToolsSheet extends StatelessWidget {
  final Function(Map<String, dynamic>) onSEOSaved;

  const SEOToolsSheet({super.key, required this.onSEOSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SEO Tools', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _buildSEOTool('Keyword Analysis', Icons.search, Colors.blue),
          _buildSEOTool('Meta Tags Generator', Icons.tag, Colors.green),
          _buildSEOTool('Sitemap Generator', Icons.map, Colors.orange),
          _buildSEOTool('URL Redirects', Icons.link, Colors.purple),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  Widget _buildSEOTool(String title, IconData icon, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontFamily: 'Cairo')),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class MediaLibraryPage extends StatelessWidget {
  final List<Map<String, dynamic>> mediaItems;
  final Function(List<Map<String, dynamic>>) onMediaUpdated;

  const MediaLibraryPage({super.key, required this.mediaItems, required this.onMediaUpdated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Library', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          final media = mediaItems[index];
          return _buildMediaItem(media);
        },
      ),
    );
  }

  Widget _buildMediaItem(Map<String, dynamic> media) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Icon(
                  media['type'] == 'image' ? Icons.photo : Icons.description,
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  media['name'],
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '${media['size']} • Used ${media['usage']} times',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormBuilderDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onFormCreated;

  const FormBuilderDialog({super.key, required this.onFormCreated});

  @override
  State<FormBuilderDialog> createState() => _FormBuilderDialogState();
}

class _FormBuilderDialogState extends State<FormBuilderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedType = 'Contact';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Form', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Form Name'),
              validator: (value) => value!.isEmpty ? 'Please enter form name' : null,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              initialValue: _selectedType,
              items: ['Contact', 'Subscription', 'Career', 'Service Request']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedType = value!),
              decoration: InputDecoration(labelText: 'Form Type'),
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
            if (_formKey.currentState!.validate()) {
              widget.onFormCreated({
                'id': 'F00${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'type': _selectedType,
                'submissions': 0,
                'conversionRate': '0%',
                'lastSubmission': '-',
                'status': 'Active'
              });
              Navigator.pop(context);
            }
          },
          child: Text('Create Form', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class ThemeCustomizerDialog extends StatelessWidget {
  final List<Map<String, dynamic>> themes;
  final Function(Map<String, dynamic>) onThemeChanged;

  const ThemeCustomizerDialog({super.key, required this.themes, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Theme Customizer', style: TextStyle(fontFamily: 'Cairo')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...themes.map((theme) => _buildThemeOption(theme, context)),
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

  Widget _buildThemeOption(Map<String, dynamic> theme, BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.palette, color: AppColors.primaryColor),
        title: Text(theme['name'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Text(theme['category'], style: TextStyle(fontFamily: 'Cairo')),
        trailing: theme['status'] == 'Active' ? Icon(Icons.check_circle, color: Colors.green) : null,
        onTap: () {
          onThemeChanged(theme);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class AnalyticsDetailPage extends StatelessWidget {
  final List<Map<String, dynamic>> analytics;

  const AnalyticsDetailPage({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Analytics', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...analytics.map((data) => _buildAnalyticsDetailCard(data)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsDetailCard(Map<String, dynamic> data) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['period'], style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildDetailMetric('Visitors', data['visitors'].toString()),
            _buildDetailMetric('Page Views', data['pageViews'].toString()),
            _buildDetailMetric('Bounce Rate', data['bounceRate']),
            _buildDetailMetric('Average Session', data['avgSession']),
            _buildDetailMetric('Conversions', data['conversions'].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailMetric(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Cairo')),
          Text(value, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}