import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_room_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

part 'chat_rooms_provider.g.dart';

/// StreamProvider for all chat rooms of the current user
/// 
/// This provider listens to real-time changes of chat rooms where
/// the current user is a participant
/// Returns empty list if no user is authenticated
@riverpod
Stream<List<ChatRoomModel>> chatRooms(ChatRoomsRef ref) {
  final authService = AuthService();
  final currentUserId = authService.currentUser?.uid;

  if (currentUserId == null) {
    return Stream.value([]);
  }

  final firestoreService = FirestoreService();
  
  try {
    return firestoreService.getChatRoomsStream(currentUserId);
  } catch (e) {
    // Return empty stream on error
    return Stream.value([]);
  }
}

/// Provider for a specific chat room by ID
/// 
/// This is a family provider for fetching a specific chat room
@riverpod
Future<ChatRoomModel?> chatRoomById(
  ChatRoomByIdRef ref,
  String chatRoomId,
) async {
  final firestoreService = FirestoreService();
  
  try {
    return await firestoreService.getChatRoom(chatRoomId);
  } catch (e) {
    return null;
  }
}

/// Provider for creating or getting a chat room between two users
/// 
/// This provider creates a new chat room if it doesn't exist,
/// or returns the existing one if it does
@riverpod
Future<ChatRoomModel?> getOrCreateChatRoom(
  GetOrCreateChatRoomRef ref,
  List<String> participants,
) async {
  final firestoreService = FirestoreService();
  
  try {
    return await firestoreService.createChatRoom(participants);
  } catch (e) {
    return null;
  }
}

/// StreamProvider for unread message count across all chat rooms
/// 
/// Calculates total unread messages for the current user
@riverpod
Stream<int> totalUnreadCount(TotalUnreadCountRef ref) {
  final authService = AuthService();
  final currentUserId = authService.currentUser?.uid;

  if (currentUserId == null) {
    return Stream.value(0);
  }

  final firestoreService = FirestoreService();
  
  return firestoreService.getChatRoomsStream(currentUserId).map((chatRooms) {
    int total = 0;
    for (final room in chatRooms) {
      final unread = room.unreadCount[currentUserId] ?? 0;
      total += unread;
    }
    return total;
  }).handleError((error) {
    return 0;
  });
}
