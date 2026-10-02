import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';
import '../models/chat_room_model.dart';
import '../utils/constants.dart';

/// Service for handling Firestore database operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========== User Operations ==========

  /// Create or update user document in Firestore
  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      throw Exception('${AppConstants.errorSaveData}: $e');
    }
  }

  /// Get user by ID
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      if (!doc.exists) {
        return null;
      }

      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('${AppConstants.errorFetchData}: $e');
    }
  }

  /// Get all users except current user
  Future<List<UserModel>> getAllUsers(String currentUserId) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.usersCollection)
          .where(FieldPath.documentId, isNotEqualTo: currentUserId)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('${AppConstants.errorFetchData}: $e');
    }
  }

  /// Update user profile
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .update(data);
    } catch (e) {
      throw Exception('${AppConstants.errorUpdateData}: $e');
    }
  }

  // ========== Chat Room Operations ==========

  /// Create a new chat room between two users
  Future<ChatRoomModel> createChatRoom(List<String> participants) async {
    try {
      // Sort participants to ensure consistent chat room ID
      final sortedParticipants = List<String>.from(participants)..sort();
      final chatRoomId = sortedParticipants.join('_');

      // Check if chat room already exists
      final existingRoom = await getChatRoom(chatRoomId);
      if (existingRoom != null) {
        return existingRoom;
      }

      // Create new chat room
      final chatRoom = ChatRoomModel(
        id: chatRoomId,
        participants: sortedParticipants,
        lastMessage: '',
        lastMessageTime: DateTime.now(),
        unreadCount: {for (var p in sortedParticipants) p: 0},
      );

      await _firestore
          .collection(AppConstants.chatRoomsCollection)
          .doc(chatRoomId)
          .set(chatRoom.toJson());

      return chatRoom;
    } catch (e) {
      throw Exception('${AppConstants.errorSaveData}: $e');
    }
  }

  /// Get chat room by ID
  Future<ChatRoomModel?> getChatRoom(String chatRoomId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.chatRoomsCollection)
          .doc(chatRoomId)
          .get();

      if (!doc.exists) {
        return null;
      }

      return ChatRoomModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('${AppConstants.errorFetchData}: $e');
    }
  }

  /// Get all chat rooms for a user
  Stream<List<ChatRoomModel>> getChatRoomsStream(String userId) {
    try {
      return _firestore
          .collection(AppConstants.chatRoomsCollection)
          .where('participants', arrayContains: userId)
          .orderBy('lastMessageTime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatRoomModel.fromJson(doc.data()))
              .toList());
    } catch (e) {
      throw Exception('${AppConstants.errorFetchData}: $e');
    }
  }

  /// Update chat room (last message, unread count, etc.)
  Future<void> updateChatRoom(
    String chatRoomId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection(AppConstants.chatRoomsCollection)
          .doc(chatRoomId)
          .update(data);
    } catch (e) {
      throw Exception('${AppConstants.errorUpdateData}: $e');
    }
  }

  // ========== Message Operations ==========

  /// Send a message to a chat room
  Future<MessageModel> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String senderName,
    required String text,
  }) async {
    try {
      final messageRef = _firestore
          .collection(AppConstants.chatRoomsCollection)
          .doc(chatRoomId)
          .collection(AppConstants.messagesCollection)
          .doc();

      final message = MessageModel(
        id: messageRef.id,
        chatRoomId: chatRoomId,
        senderId: senderId,
        senderName: senderName,
        text: text,
        timestamp: DateTime.now(),
        read: false,
      );

      await messageRef.set(message.toJson());

      // Update chat room with last message
      await updateChatRoom(chatRoomId, {
        'lastMessage': text,
        'lastMessageTime': message.timestamp.toIso8601String(),
      });

      return message;
    } catch (e) {
      throw Exception('${AppConstants.errorSaveData}: $e');
    }
  }

  /// Get messages stream for a chat room
  Stream<List<MessageModel>> getMessagesStream(String chatRoomId) {
    try {
      return _firestore
          .collection(AppConstants.chatRoomsCollection)
          .doc(chatRoomId)
          .collection(AppConstants.messagesCollection)
          .orderBy('timestamp', descending: true)
          .limit(AppConstants.messageCacheLimit)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList());
    } catch (e) {
      throw Exception('${AppConstants.errorFetchData}: $e');
    }
  }

  /// Mark message as read
  Future<void> markMessageAsRead(String chatRoomId, String messageId) async {
    try {
      await _firestore
          .collection(AppConstants.chatRoomsCollection)
          .doc(chatRoomId)
          .collection(AppConstants.messagesCollection)
          .doc(messageId)
          .update({'read': true});
    } catch (e) {
      throw Exception('${AppConstants.errorUpdateData}: $e');
    }
  }

  /// Delete a message
  Future<void> deleteMessage(String chatRoomId, String messageId) async {
    try {
      await _firestore
          .collection(AppConstants.chatRoomsCollection)
          .doc(chatRoomId)
          .collection(AppConstants.messagesCollection)
          .doc(messageId)
          .delete();
    } catch (e) {
      throw Exception('${AppConstants.errorDeleteData}: $e');
    }
  }
}
