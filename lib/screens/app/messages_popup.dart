// screens/app/widgets/messages_popup.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/message_service.dart';
import 'package:vision_erp_app/screens/models/message_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';

class MessagesPopup extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onMessageRead;
  final VoidCallback? onViewAllChats;

  const MessagesPopup({
    super.key,
    required this.onClose,
    required this.onMessageRead,
    this.onViewAllChats,
  });

  @override
  State<MessagesPopup> createState() => _MessagesPopupState();
}

class _MessagesPopupState extends State<MessagesPopup> {
  final MessageService _messageService = MessageService();
  List<String> _categories = [];
  String _selectedCategory = 'All';
  List<MessageModel> _filteredMessages = [];
  String? _selectedSender;
  final TextEditingController _replyController = TextEditingController();
  bool _showChatView = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _filterMessages();
  }

  @override
  void dispose() {
    _replyController.dispose();
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
      _filteredMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _showChatView = false;
      _selectedSender = null;
    });
    _filterMessages();
  }

  void _onMessageTap(MessageModel message) {
    if (message.isIncoming && message.status != MessageStatus.read) {
      _messageService.markAsRead(message.id);
      widget.onMessageRead();
      _filterMessages();
    }
  }

  void _openChat(MessageModel message) {
    setState(() {
      _showChatView = true;
      _selectedSender = message.senderId;
    });
  }

  void _sendReply() {
    if (_replyController.text.trim().isEmpty || _selectedSender == null) return;

    final senderMessages = _messageService.getAllMessages().where(
      (message) => message.senderId == _selectedSender
    ).toList();
    
    if (senderMessages.isEmpty) return;
    
    final originalMessage = senderMessages.first;
    
    _messageService.sendMessage(
      receiverId: _selectedSender!,
      receiverName: originalMessage.senderName,
      content: _replyController.text.trim(),
      type: MessageType.direct,
      category: 'Direct',
    );

    _replyController.clear();
    setState(() {});
  }

  void _deleteMessage(String messageId) {
    final localizationService = Provider.of<LocalizationService>(context, listen: false);
    final languageCode = localizationService.locale.languageCode;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageCode == 'en' ? 'Delete Message' : 'حذف الرسالة'),
        content: Text(languageCode == 'en'
            ? 'Are you sure you want to delete this message?'
            : 'هل أنت متأكد من حذف هذه الرسالة؟'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageCode == 'en' ? 'Cancel' : 'إلغاء'),
          ),
          TextButton(
            onPressed: () {
              _messageService.deleteMessage(messageId);
              _filterMessages();
              widget.onMessageRead();
              Navigator.pop(context);
            },
            child: Text(
              languageCode == 'en' ? 'Delete' : 'حذف',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteConversation() {
    if (_selectedSender == null) return;

    final localizationService = Provider.of<LocalizationService>(context, listen: false);
    final languageCode = localizationService.locale.languageCode;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageCode == 'en' ? 'Delete Conversation' : 'حذف المحادثة'),
        content: Text(languageCode == 'en'
            ? 'Are you sure you want to delete this entire conversation?'
            : 'هل أنت متأكد من حذف المحادثة بالكامل؟'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageCode == 'en' ? 'Cancel' : 'إلغاء'),
          ),
          TextButton(
            onPressed: () {
              _messageService.deleteConversation(_selectedSender!);
              setState(() {
                _showChatView = false;
                _selectedSender = null;
              });
              _filterMessages();
              widget.onMessageRead();
              Navigator.pop(context);
            },
            child: Text(
              languageCode == 'en' ? 'Delete' : 'حذف',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _handleViewAllChats() {
    if (widget.onViewAllChats != null) {
      widget.onClose(); // إغلاق الـ popup أولاً
      widget.onViewAllChats!(); // ثم استدعاء دالة الانتقال
    }
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

  List<MessageModel> _getConversation(String senderId) {
    final allMessages = _messageService.getAllMessages();
    final conversation = allMessages.where((message) => 
      message.senderId == senderId || 
      message.receiverId == senderId ||
      (message.senderId == 'current_user' && message.receiverId == senderId)
    ).toList();
    
    conversation.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return conversation;
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final languageCode = localizationService.locale.languageCode;

    return Container(
      width: 350,
      height: 500,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
      child: _showChatView ? _buildChatView(context, languageCode == 'en') : _buildMessagesView(context, languageCode == 'en'),
    );
  }

  Widget _buildMessagesView(BuildContext context, bool isEnglish) {
    return Column(
      children: [
        // Header
        _buildHeader(context, isEnglish),

        // Category Tabs
        _buildCategoryTabs(context, isEnglish),

        // Messages List
        _buildMessagesList(context, isEnglish),

        // زر "View All Chats" في الأسفل
        if (_filteredMessages.isNotEmpty) _buildViewAllChatsButton(isEnglish),
      ],
    );
  }

  Widget _buildChatView(BuildContext context, bool isEnglish) {
    final conversation = _selectedSender != null 
        ? _getConversation(_selectedSender!)
        : [];

    return Column(
      children: [
        // Chat Header
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
                onPressed: () {
                  setState(() {
                    _showChatView = false;
                    _selectedSender = null;
                  });
                },
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  conversation.isNotEmpty ? conversation.first.senderName : 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white),
                onPressed: _deleteConversation,
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

        // Reply Input
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.borderColor)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _replyController,
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
                  onPressed: _sendReply,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllChatsButton(bool isEnglish) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _handleViewAllChats, // ✅ استخدام الدالة المعدلة
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          icon: const Icon(
            Icons.forum,
            size: 18,
          ),
          label: Text(
            isEnglish ? 'View All Chats' : 'عرض جميع المحادثات',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

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
                  _deleteMessage(message.id);
                }
              },
              child: const Icon(Icons.more_vert, size: 16, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isEnglish) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isEnglish ? 'Messages' : 'الرسائل',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context, bool isEnglish) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              selectedColor: AppColors.secondaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                fontFamily: 'Cairo',
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context, bool isEnglish) {
    return Expanded(
      child: _filteredMessages.isEmpty
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
              padding: const EdgeInsets.all(8),
              itemCount: _filteredMessages.length,
              itemBuilder: (context, index) {
                final message = _filteredMessages[index];
                return _buildMessageItem(message, context, isEnglish);
              },
            ),
    );
  }

  Widget _buildMessageItem(MessageModel message, BuildContext context, bool isEnglish) {
    final isUnread = message.isIncoming && message.status != MessageStatus.read;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      // ✅ التحديث: استخدام اللون الرمادي الفاتح للرسائل غير المقروءة
      color: isUnread ? Colors.grey[100] : Theme.of(context).cardColor,
      elevation: 1,
      child: ListTile(
        onTap: () => _onMessageTap(message),
        onLongPress: () => _openChat(message),
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(message.category),
          child: Icon(
            _getCategoryIcon(message.type),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                message.senderName,
                // ✅ التحديث: استخدام اللون الرمادي الداكن للنص في الرسائل غير المقروءة
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  color: isUnread ? Colors.grey[800] : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              // ✅ التحديث: استخدام اللون الرمادي للنص الفرعي في الرسائل غير المقروءة
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: isUnread ? Colors.grey[600] : AppColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.timestamp, isEnglish),
              // ✅ التحديث: استخدام اللون الرمادي للوقت في الرسائل غير المقروءة
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10,
                color: isUnread ? Colors.grey[500] : AppColors.textSecondary,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          itemBuilder: (context) => [
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
              _openChat(message);
            } else if (value == 'delete') {
              _deleteMessage(message.id);
            }
          },
        ),
      ),
    );
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
    } else {
      return isEnglish
          ? '${difference.inDays}d ago'
          : '${difference.inDays} يوم';
    }
  }
}