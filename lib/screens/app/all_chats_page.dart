// screens/app/all_chats_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/services/message_service.dart';
import 'package:vision_erp_app/screens/models/message_model.dart';
import 'package:vision_erp_app/screens/app/home_page.dart'; // ✅ إضافة استيراد HomePage

class AllChatsPage extends StatefulWidget {
  const AllChatsPage({super.key});

  @override
  State<AllChatsPage> createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  final MessageService _messageService = MessageService();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _newMessageController = TextEditingController();
  final TextEditingController _chatMessageController = TextEditingController();
  
  List<String> _categories = [];
  String _selectedCategory = 'All';
  List<MessageModel> _filteredMessages = [];
  List<String> _uniqueSenders = [];
  bool _showNewMessageDialog = false;
  bool _showChatDialog = false;
  String _newMessageReceiver = '';
  String _newMessageContent = '';
  String _currentChatSenderId = '';
  String _currentChatSenderName = '';
  MessageType _selectedMessageType = MessageType.direct;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _filterMessages();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _newMessageController.dispose();
    _chatMessageController.dispose();
    super.dispose();
  }

  void _loadCategories() {
    final categories = _messageService.getAvailableCategories();
    setState(() {
      _categories = ['All', ...categories];
    });
  }

  void _filterMessages() {
    setState(() {
      if (_selectedCategory == 'All') {
        _filteredMessages = _messageService.getAllMessages();
      } else {
        _filteredMessages = _messageService.getMessagesByCategory(_selectedCategory);
      }
      
      // استخراج المرسلين الفريدين
      _uniqueSenders = _filteredMessages
          .map((message) => message.senderId)
          .toSet()
          .toList();
      
      _filteredMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterMessages();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      _filterMessages();
    } else {
      setState(() {
        _filteredMessages = _messageService.getAllMessages().where((message) =>
          message.senderName.toLowerCase().contains(query.toLowerCase()) ||
          message.content.toLowerCase().contains(query.toLowerCase())
        ).toList();
        
        _uniqueSenders = _filteredMessages
            .map((message) => message.senderId)
            .toSet()
            .toList();
      });
    }
  }

  List<MessageModel> _getConversation(String senderId) {
    final allMessages = _messageService.getAllMessages();
    final conversation = allMessages.where((message) => 
      message.senderId == senderId || 
      message.receiverId == senderId
    ).toList();
    
    conversation.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return conversation;
  }

  MessageModel _getLastMessage(String senderId) {
    final conversation = _getConversation(senderId);
    return conversation.isNotEmpty ? conversation.last : MessageModel(
      id: '',
      senderId: senderId,
      senderName: 'Unknown',
      receiverId: '',
      content: 'No messages',
      timestamp: DateTime.now(),
      isIncoming: true,
      type: MessageType.direct,
      category: 'Direct',
      status: MessageStatus.read, 
      senderRole: '', 
      receiverName: '',
    );
  }

  int _getUnreadCount(String senderId) {
    final conversation = _getConversation(senderId);
    return conversation.where((message) => 
      message.isIncoming && message.status != MessageStatus.read
    ).length;
  }

  void _markConversationAsRead(String senderId) {
    final conversation = _getConversation(senderId);
    for (final message in conversation) {
      if (message.isIncoming && message.status != MessageStatus.read) {
        _messageService.markAsRead(message.id);
      }
    }
    _filterMessages();
  }

  void _openNewMessageDialog() {
    setState(() {
      _showNewMessageDialog = true;
      _newMessageReceiver = '';
      _newMessageContent = '';
      _selectedMessageType = MessageType.direct;
    });
  }

  void _sendNewMessage() {
    if (_newMessageReceiver.isEmpty || _newMessageContent.isEmpty) return;

    _messageService.sendMessage(
      receiverId: _newMessageReceiver,
      receiverName: _newMessageReceiver,
      content: _newMessageContent,
      type: _selectedMessageType,
      category: _getCategoryFromType(_selectedMessageType),
    );

    setState(() {
      _showNewMessageDialog = false;
    });
    _filterMessages();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message sent successfully'),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  // ✅ إضافة: دالة فتح محادثة
  void _openChat(String senderId, String senderName) {
    setState(() {
      _showChatDialog = true;
      _currentChatSenderId = senderId;
      _currentChatSenderName = senderName;
      _chatMessageController.clear();
    });
  }

  // ✅ إضافة: دالة إرسال رسالة في المحادثة
  void _sendChatMessage() {
    if (_chatMessageController.text.trim().isEmpty || _currentChatSenderId.isEmpty) return;

    _messageService.sendMessage(
      receiverId: _currentChatSenderId,
      receiverName: _currentChatSenderName,
      content: _chatMessageController.text.trim(),
      type: MessageType.direct,
      category: 'Direct',
    );

    _chatMessageController.clear();
    setState(() {});
    
    // إعادة تحميل المحادثات
    _filterMessages();
  }

  // ✅ إضافة: دالة إغلاق المحادثة
  void _closeChat() {
    setState(() {
      _showChatDialog = false;
      _currentChatSenderId = '';
      _currentChatSenderName = '';
    });
  }

  String _getCategoryFromType(MessageType type) {
    switch (type) {
      case MessageType.team:
        return 'Team';
      case MessageType.department:
        return 'HR Department';
      case MessageType.project:
        return 'Expansion Project';
      case MessageType.announcement:
        return 'Announcements';
      case MessageType.direct:
        return 'Direct';
    }
  }

  void _deleteConversation(String senderId) {
    final localizationService = Provider.of<LocalizationService>(context, listen: false);
    final isEnglish = localizationService.isEnglish();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEnglish ? 'Delete Conversation' : 'حذف المحادثة'),
        content: Text(isEnglish
            ? 'Are you sure you want to delete this entire conversation?'
            : 'هل أنت متأكد من حذف المحادثة بالكامل؟'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isEnglish ? 'Cancel' : 'إلغاء'),
          ),
          TextButton(
            onPressed: () {
              _messageService.deleteConversation(senderId);
              _filterMessages();
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isEnglish ? 'Conversation deleted' : 'تم حذف المحادثة'),
                  backgroundColor: AppColors.secondaryColor,
                ),
              );
            },
            child: Text(
              isEnglish ? 'Delete' : 'حذف',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryDisplayName(String category, bool isEnglish) {
    final categoryMap = {
      'All': isEnglish ? 'All' : 'الكل',
      'Team': isEnglish ? 'Team' : 'فريق العمل',
      'HR Department': isEnglish ? 'HR Department' : 'قسم الموارد البشرية',
      'Expansion Project': isEnglish ? 'Expansion Project' : 'مشروع التوسع',
      'Announcements': isEnglish ? 'Announcements' : 'الإعلانات',
      'Direct': isEnglish ? 'Direct' : 'مباشر',
    };
    
    return categoryMap[category] ?? category;
  }

  String _getMessageTypeDisplayName(MessageType type, bool isEnglish) {
    switch (type) {
      case MessageType.team:
        return isEnglish ? 'Team' : 'فريق';
      case MessageType.department:
        return isEnglish ? 'Department' : 'قسم';
      case MessageType.project:
        return isEnglish ? 'Project' : 'مشروع';
      case MessageType.announcement:
        return isEnglish ? 'Announcement' : 'إعلان';
      case MessageType.direct:
        return isEnglish ? 'Direct' : 'مباشر';
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Team':
        return AppColors.primaryColor;
      case 'HR Department':
        return Colors.green;
      case 'Expansion Project':
        return AppColors.secondaryColor;
      case 'Announcements':
        return Colors.purple;
      case 'Direct':
        return Colors.teal;
      default:
        return AppColors.accentBlue;
    }
  }

  IconData _getCategoryIcon(MessageType type) {
    switch (type) {
      case MessageType.team:
        return Icons.group;
      case MessageType.department:
        return Icons.business;
      case MessageType.project:
        return Icons.assignment;
      case MessageType.announcement:
        return Icons.announcement;
      case MessageType.direct:
        return Icons.person;
    }
  }

  String _formatTime(DateTime timestamp, bool isEnglish) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return isEnglish ? 'Now' : 'الآن';
    } else if (difference.inHours < 1) {
      return isEnglish 
          ? '${difference.inMinutes}m ago'
          : '${difference.inMinutes} دقيقة';
    } else if (difference.inDays < 1) {
      return isEnglish
          ? '${difference.inHours}h ago'
          : '${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return isEnglish
          ? '${difference.inDays}d ago'
          : '${difference.inDays} يوم';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  // ✅ إضافة: دالة بناء رسالة المحادثة
  Widget _buildChatMessage(MessageModel message, BuildContext context, bool isEnglish) {
    final isMe = !message.isIncoming;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.secondaryColor : AppColors.accentBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: isMe ? Colors.white : AppColors.textPrimary,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red, size: 18),
                      const SizedBox(width: 8),
                      Text(isEnglish ? 'Delete' : 'حذف'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'delete') {
                  _messageService.deleteMessage(message.id);
                  setState(() {});
                }
              },
              child: const Icon(Icons.more_vert, size: 16, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final isEnglish = localizationService.isEnglish();

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            leading: IconButton( // ✅ إضافة زر الرجوع في أعلى اليسار
              icon: Icon(Icons.arrow_back),
              color: AppColors.secondaryColor,
              onPressed: () {
                // العودة إلى HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            title: Text(
              isEnglish ? 'All Chats' : 'جميع المحادثات',
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_comment, color: Colors.white),
                onPressed: _openNewMessageDialog,
                tooltip: isEnglish ? 'New Message' : 'رسالة جديدة',
              ),
            ],
          ),
          body: Column(
            children: [
              // Search Bar
              _buildSearchBar(context, isEnglish),

              // Category Tabs
              _buildCategoryTabs(context, isEnglish),

              // Chats List
              Expanded(
                child: _buildChatsList(context, isEnglish),
              ),
            ],
          ),
        ),

        // New Message Dialog
        if (_showNewMessageDialog) _buildNewMessageDialog(context, isEnglish),

        // ✅ إضافة: Chat Dialog
        if (_showChatDialog) _buildChatDialog(context, isEnglish),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isEnglish) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: isEnglish ? 'Search conversations...' : 'ابحث في المحادثات...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context, bool isEnglish) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          final unreadCounts = _messageService.getUnreadCountByCategory();
          final unreadCount = category == 'All' 
              ? _messageService.getUnreadCount()
              : unreadCounts[category] ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_getCategoryDisplayName(category, isEnglish)),
                  if (unreadCount > 0) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
              selected: isSelected,
              onSelected: (_) => _onCategorySelected(category),
              backgroundColor: Colors.grey[100],
              selectedColor: AppColors.secondaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontFamily: 'Cairo',
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatsList(BuildContext context, bool isEnglish) {
    if (_uniqueSenders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isEnglish ? 'No conversations' : 'لا توجد محادثات',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isEnglish ? 'Start a new conversation' : 'ابدأ محادثة جديدة',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openNewMessageDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add_comment),
              label: Text(
                isEnglish ? 'New Message' : 'رسالة جديدة',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _uniqueSenders.length,
      itemBuilder: (context, index) {
        final senderId = _uniqueSenders[index];
        final lastMessage = _getLastMessage(senderId);
        final unreadCount = _getUnreadCount(senderId);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () {
              _markConversationAsRead(senderId);
              _openChat(senderId, lastMessage.senderName); // ✅ فتح المحادثة عند الضغط
            },
            leading: CircleAvatar(
              backgroundColor: _getCategoryColor(lastMessage.category),
              radius: 24,
              child: Icon(
                _getCategoryIcon(lastMessage.type),
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    lastMessage.senderName,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                      color: unreadCount > 0 ? AppColors.primaryColor : AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  lastMessage.content,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(lastMessage.timestamp, isEnglish),
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(lastMessage.category).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _getMessageTypeDisplayName(lastMessage.type, isEnglish),
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10,
                          color: _getCategoryColor(lastMessage.category),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              itemBuilder: (context) => [
                // ✅ إضافة: خيار Open Chat
                PopupMenuItem(
                  value: 'chat',
                  child: Row(
                    children: [
                      const Icon(Icons.chat, size: 18),
                      const SizedBox(width: 8),
                      Text(isEnglish ? 'Open Chat' : 'فتح المحادثة'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.red, size: 18),
                      const SizedBox(width: 8),
                      Text(isEnglish ? 'Delete' : 'حذف'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'chat') {
                  _openChat(senderId, lastMessage.senderName); // ✅ فتح المحادثة
                } else if (value == 'delete') {
                  _deleteConversation(senderId);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewMessageDialog(BuildContext context, bool isEnglish) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEnglish ? 'New Message' : 'رسالة جديدة',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            
            // Receiver Input
            TextField(
              onChanged: (value) => setState(() => _newMessageReceiver = value),
              decoration: InputDecoration(
                labelText: isEnglish ? 'Receiver' : 'المستلم',
                hintText: isEnglish ? 'Enter receiver name...' : 'أدخل اسم المستلم...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            
            // Message Type
            DropdownButtonFormField<MessageType>(
              value: _selectedMessageType,
              onChanged: (value) => setState(() => _selectedMessageType = value!),
              items: MessageType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                    _getMessageTypeDisplayName(type, isEnglish),
                    style: const TextStyle(fontFamily: 'Cairo'),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: isEnglish ? 'Message Type' : 'نوع الرسالة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 16),
            
            // Message Content
            TextField(
              onChanged: (value) => setState(() => _newMessageContent = value),
              maxLines: 4,
              decoration: InputDecoration(
                labelText: isEnglish ? 'Message' : 'الرسالة',
                hintText: isEnglish ? 'Type your message here...' : 'اكتب رسالتك هنا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            
            // Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => setState(() => _showNewMessageDialog = false),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isEnglish ? 'Cancel' : 'إلغاء',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _sendNewMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isEnglish ? 'Send' : 'إرسال',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ إضافة: دالة بناء دايالوج المحادثة
  Widget _buildChatDialog(BuildContext context, bool isEnglish) {
    final conversation = _getConversation(_currentChatSenderId);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _closeChat,
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: AppColors.primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _currentChatSenderName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: _closeChat,
                  ),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: conversation.isEmpty
                  ? Center(
                      child: Text(
                        isEnglish ? 'No messages' : 'لا توجد رسائل',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: conversation.length,
                      itemBuilder: (context, index) {
                        final message = conversation[index];
                        return _buildChatMessage(message, context, isEnglish);
                      },
                    ),
            ),

            // Input Field
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.borderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatMessageController,
                      decoration: InputDecoration(
                        hintText: isEnglish ? 'Type a message...' : 'اكتب رسالة...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.secondaryColor,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: _sendChatMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );  
  }
}