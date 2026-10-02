import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/message_model.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

part 'messages_provider.g.dart';

/// StreamProvider family for messages in a specific chat room
/// 
/// This provider listens to real-time messages in a chat room
/// with pagination support (limited by messageCacheLimit)
@riverpod
Stream<List<MessageModel>> messages(
  MessagesRef ref,
  String chatRoomId,
) {
  if (chatRoomId.isEmpty) {
    return Stream.value([]);
  }

  final firestoreService = FirestoreService();
  
  try {
    return firestoreService.getMessagesStream(chatRoomId);
  } catch (e) {
    return Stream.value([]);
  }
}

/// StreamProvider family for paginated messages
/// 
/// This provider allows fetching messages with custom limit for pagination
@riverpod
Stream<List<MessageModel>> paginatedMessages(
  PaginatedMessagesRef ref,
  String chatRoomId, {
  int limit = 50,
  DocumentSnapshot? startAfter,
}) {
  if (chatRoomId.isEmpty) {
    return Stream.value([]);
  }

  try {
    Query query = FirebaseFirestore.instance
        .collection(AppConstants.chatRoomsCollection)
        .doc(chatRoomId)
        .collection(AppConstants.messagesCollection)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MessageModel.fromJson(data);
      }).toList();
    }).handleError((error) {
      return <MessageModel>[];
    });
  } catch (e) {
    return Stream.value([]);
  }
}

/// Provider for sending a message
/// 
/// This is a utility provider for sending messages to a chat room
@riverpod
class MessageSender extends _$MessageSender {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  /// Send a message to a chat room
  Future<MessageModel?> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String senderName,
    required String text,
  }) async {
    final firestoreService = FirestoreService();
    
    try {
      final message = await firestoreService.sendMessage(
        chatRoomId: chatRoomId,
        senderId: senderId,
        senderName: senderName,
        text: text,
      );
      
      // Invalidate messages provider to refresh
      ref.invalidate(messagesProvider(chatRoomId));
      
      return message;
    } catch (e) {
      return null;
    }
  }

  /// Mark a message as read
  Future<void> markAsRead({
    required String chatRoomId,
    required String messageId,
  }) async {
    final firestoreService = FirestoreService();
    
    try {
      await firestoreService.markMessageAsRead(chatRoomId, messageId);
    } catch (e) {
      // Silently fail
    }
  }

  /// Delete a message
  Future<void> deleteMessage({
    required String chatRoomId,
    required String messageId,
  }) async {
    final firestoreService = FirestoreService();
    
    try {
      await firestoreService.deleteMessage(chatRoomId, messageId);
      
      // Invalidate messages provider to refresh
      ref.invalidate(messagesProvider(chatRoomId));
    } catch (e) {
      // Silently fail
    }
  }
}

/// Provider for unread messages count in a specific chat room
@riverpod
Stream<int> unreadMessagesCount(
  UnreadMessagesCountRef ref,
  String chatRoomId,
  String currentUserId,
) {
  if (chatRoomId.isEmpty || currentUserId.isEmpty) {
    return Stream.value(0);
  }

  return FirebaseFirestore.instance
      .collection(AppConstants.chatRoomsCollection)
      .doc(chatRoomId)
      .collection(AppConstants.messagesCollection)
      .where('senderId', isNotEqualTo: currentUserId)
      .where('read', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.length)
      .handleError((error) {
    return 0;
  });
}
