

enum MessageType {
  team,
  department, 
  project,
  announcement,
  direct
}

enum MessageStatus {
  sent,
  delivered,
  read
}

class MessageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String senderRole;
  final String receiverId;
  final String receiverName;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final MessageStatus status;
  final String category; // Team, Department, Project, etc.
  final String? projectId;
  final String? departmentId;
  final String? teamId;
  final bool isIncoming;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.receiverId,
    required this.receiverName,
    required this.content,
    required this.timestamp,
    required this.type,
    required this.status,
    required this.category,
    this.projectId,
    this.departmentId,
    this.teamId,
    required this.isIncoming,
  });

  MessageModel copyWith({
    MessageStatus? status,
  }) {
    return MessageModel(
      id: id,
      senderId: senderId,
      senderName: senderName,
      senderRole: senderRole,
      receiverId: receiverId,
      receiverName: receiverName,
      content: content,
      timestamp: timestamp,
      type: type,
      status: status ?? this.status,
      category: category,
      projectId: projectId,
      departmentId: departmentId,
      teamId: teamId,
      isIncoming: isIncoming,
    );
  }
}