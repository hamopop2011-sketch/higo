class MessageModel {
  final String id;
  final String chatRoomId;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime timestamp;
  final bool read;

  const MessageModel({
    required this.id,
    required this.chatRoomId,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.timestamp,
    this.read = false,
  });

  // Create MessageModel from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatRoomId: json['chatRoomId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      read: json['read'] as bool? ?? false,
    );
  }

  // Convert MessageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'read': read,
    };
  }

  // Create a copy with modified fields
  MessageModel copyWith({
    String? id,
    String? chatRoomId,
    String? senderId,
    String? senderName,
    String? text,
    DateTime? timestamp,
    bool? read,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      read: read ?? this.read,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageModel &&
        other.id == id &&
        other.chatRoomId == chatRoomId &&
        other.senderId == senderId &&
        other.senderName == senderName &&
        other.text == text &&
        other.timestamp == timestamp &&
        other.read == read;
  }

  @override
  int get hashCode {
    return Object.hash(id, chatRoomId, senderId, senderName, text, timestamp, read);
  }

  @override
  String toString() {
    return 'MessageModel(id: $id, chatRoomId: $chatRoomId, senderId: $senderId, senderName: $senderName, text: $text, timestamp: $timestamp, read: $read)';
  }
}
