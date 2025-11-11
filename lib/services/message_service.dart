import 'package:vision_erp_app/screens/models/message_model.dart';

class MessageService {
  static final MessageService _instance = MessageService._internal();
  factory MessageService() => _instance;
  MessageService._internal();

  final List<MessageModel> _messages = [
    // Team Messages
    MessageModel(
      id: '1',
      senderId: 'eng1',
      senderName: 'Ahmed Engineer',
      senderRole: 'Engineer',
      receiverId: 'current_user',
      receiverName: 'You',
      content: 'Can you review the new design?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      type: MessageType.team,
      status: MessageStatus.delivered,
      category: 'Team',
      teamId: 'team_tech',
      isIncoming: true,
    ),
    
    // Department Messages
    MessageModel(
      id: '2',
      senderId: 'hr1',
      senderName: 'Mohammed HR Manager',
      senderRole: 'HR Manager',
      receiverId: 'current_user',
      receiverName: 'You',
      content: 'Performance evaluation meeting tomorrow at 10 AM',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: MessageType.department,
      status: MessageStatus.delivered,
      category: 'HR Department',
      departmentId: 'dept_hr',
      isIncoming: true,
    ),

    // Project Messages
    MessageModel(
      id: '3',
      senderId: 'sales1',
      senderName: 'Khalid Sales Manager',
      senderRole: 'Sales Manager',
      receiverId: 'current_user',
      receiverName: 'You',
      content: 'Final sales report is ready for review',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      type: MessageType.project,
      status: MessageStatus.delivered,
      category: 'Expansion Project',
      projectId: 'project_expansion',
      isIncoming: true,
    ),

    // Announcements
    MessageModel(
      id: '4',
      senderId: 'system',
      senderName: 'System',
      senderRole: 'System',
      receiverId: 'all',
      receiverName: 'All Employees',
      content: 'System maintenance scheduled for Friday',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: MessageType.announcement,
      status: MessageStatus.delivered,
      category: 'Announcements',
      isIncoming: true,
    ),

    // Direct Messages
    MessageModel(
      id: '5',
      senderId: 'current_user',
      senderName: 'You',
      senderRole: 'Manager',
      receiverId: 'eng1',
      receiverName: 'Ahmed Engineer',
      content: 'The design is excellent, you can proceed',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      type: MessageType.direct,
      status: MessageStatus.read,
      category: 'Direct',
      isIncoming: false,
    ),
  ];

  List<MessageModel> getAllMessages() {
    return List.from(_messages);
  }

  List<MessageModel> getMessagesByType(MessageType type) {
    return _messages.where((message) => message.type == type).toList();
  }

  List<MessageModel> getMessagesByCategory(String category) {
    return _messages.where((message) => message.category == category).toList();
  }

  int getUnreadCount() {
    return _messages.where((message) => 
      message.isIncoming && message.status != MessageStatus.read
    ).length;
  }

  Map<String, int> getUnreadCountByCategory() {
    final Map<String, int> counts = {};
    
    for (final message in _messages) {
      if (message.isIncoming && message.status != MessageStatus.read) {
        counts[message.category] = (counts[message.category] ?? 0) + 1;
      }
    }
    
    return counts;
  }

  void markAsRead(String messageId) {
    final index = _messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      _messages[index] = _messages[index].copyWith(status: MessageStatus.read);
    }
  }

  void sendMessage({
    required String receiverId,
    required String receiverName,
    required String content,
    required MessageType type,
    required String category,
    String? projectId,
    String? departmentId,
    String? teamId,
  }) {
    final newMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'current_user',
      senderName: 'You',
      senderRole: 'Manager',
      receiverId: receiverId,
      receiverName: receiverName,
      content: content,
      timestamp: DateTime.now(),
      type: type,
      status: MessageStatus.sent,
      category: category,
      projectId: projectId,
      departmentId: departmentId,
      teamId: teamId,
      isIncoming: false,
    );
    
    _messages.insert(0, newMessage);
  }
  // حذف رسالة
  void deleteMessage(String messageId) {
    _messages.removeWhere((message) => message.id == messageId);
  }
  // الحصول على محادثة مع مرسل معين
List<MessageModel> getConversation(String senderId) {
  return _messages.where((message) => 
    message.senderId == senderId || 
    (message.receiverId == senderId && message.senderId == 'current_user') ||
    (message.senderId == 'current_user' && message.receiverId == senderId)
  ).toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));
}
  // حذف جميع الرسائل مع مرسل معين
  void deleteConversation(String senderId) {
    _messages.removeWhere((message) => 
      message.senderId == senderId || message.receiverId == senderId
    );
  }
    // حذف جميع الرسائل في تصنيف معين
  void deleteCategoryMessages(String category) {
    _messages.removeWhere((message) => message.category == category);
  }
  List<String> getAvailableCategories() {
    final categories = _messages.map((msg) => msg.category).toSet().toList();
    return categories;
  }

  // الحصول على المرسلين المختلفين
List<String> getUniqueSenders() {
  final senders = _messages.map((msg) => msg.senderId).toSet().toList();
  return senders.where((sender) => sender != 'current_user').toList();
}

 // الحصول على الرسائل حسب المرسل
List<MessageModel> getMessagesBySender(String senderId) {
  return _messages.where((message) => message.senderId == senderId).toList();
}
}