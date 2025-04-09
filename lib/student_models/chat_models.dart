class ChatModel {
  final String chatName;
  final String chatType;
  final String teacherName;
  final String teacherAvatar;
  final String createdAt;
  final String content;
  final String chatId;
  final String messageType;
  final String senderId;

  ChatModel({
    required this.chatName,
    required this.chatType,
    required this.teacherName,
    required this.teacherAvatar,
    required this.createdAt,
    required this.content,
    required this.chatId,
    required this.messageType,
    required this.senderId,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatName: json['chat_name'] ?? '',
      chatType: json['chat_type'] ?? '',
      teacherName: json['teachers_chat_full_name'] ??
          json['customer_chat_full_name'] ??
          '',
      teacherAvatar:
          json['teachers_chat_avatar'] ?? json['customer_chat_avatar'] ?? '',
      createdAt: json['created_at'] ?? '',
      content: json['content'] ?? '',
      chatId: json['chat_id'] ?? '',
      messageType: json['message_type'] ?? '',
      senderId: json['sender_id'] ?? '',
    );
  }
}

class ConverastionModel {
  final String teacherFullName;
  final String teacherAvatar;
  final String teacherEmail;
  final String id;
  final String name;
  final List<ChatMessageModel> messages;

  ConverastionModel({
    required this.teacherFullName,
    required this.teacherAvatar,
    required this.teacherEmail,
    required this.id,
    required this.name,
    required this.messages,
  });
  factory ConverastionModel.fromJson(Map<String, dynamic> json) {
    return ConverastionModel(
      teacherFullName: json['value']['teachers_full_name'] ?? '',
      teacherAvatar: json['value']['teachers_avatar'] ?? '',
      teacherEmail: json['value']['teachers_email'] ?? '',
      id: json['value']['id'] ?? '',
      name: json['value']['name'] ?? '',
      messages: List<ChatMessageModel>.from(
        (json['chat_messages'] as List).map(
          (e) => ChatMessageModel.fromJson(e),
        ),
      ),
    );
  }
}

class ChatMessageModel {
  final String content;
  final String senderId;
  final String messageType;
  final String senderType;
  final DateTime createdAt;
  final String customerName;
  final String userName;
  final String teacherName;
  ChatMessageModel({
    required this.content,
    required this.senderId,
    required this.messageType,
    required this.senderType,
    required this.createdAt,
    required this.customerName,
    required this.userName,
    required this.teacherName,
  });
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      content: json['content'] ?? '',
      senderId: json['sender_id'] ?? '',
      messageType: json['message_type'] ?? '',
      senderType: json['sender_type'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      customerName: json['customer_full_name'] ?? '',
      userName: json['user_name'] ?? '',
      teacherName: json['teachers_full_name'] ?? '',
    );
  }
}
