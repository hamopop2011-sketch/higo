import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

part 'user_provider.g.dart';

/// StreamProvider for current user document from Firestore
/// 
/// This provider listens to real-time changes of the current user's document
/// Returns null if no user is authenticated
@riverpod
Stream<UserModel?> currentUser(CurrentUserRef ref) {
  final authService = AuthService();
  final currentUserId = authService.currentUser?.uid;

  if (currentUserId == null) {
    return Stream.value(null);
  }

  // Listen to real-time updates from Firestore
  return FirebaseFirestore.instance
      .collection(AppConstants.usersCollection)
      .doc(currentUserId)
      .snapshots()
      .map((snapshot) {
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }
    
    try {
      return UserModel.fromJson(snapshot.data()!);
    } catch (e) {
      // Return null if parsing fails
      return null;
    }
  }).handleError((error) {
    // Log error but don't throw - return null instead
    return null;
  });
}

/// Provider for current user ID
/// 
/// Returns the current authenticated user's ID or null
@riverpod
String? currentUserId(CurrentUserIdRef ref) {
  final authService = AuthService();
  return authService.currentUser?.uid;
}

/// StreamProvider for a specific user by ID
/// 
/// This is a family provider that allows fetching any user by their ID
@riverpod
Stream<UserModel?> userById(UserByIdRef ref, String userId) {
  return FirebaseFirestore.instance
      .collection(AppConstants.usersCollection)
      .doc(userId)
      .snapshots()
      .map((snapshot) {
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }
    
    try {
      return UserModel.fromJson(snapshot.data()!);
    } catch (e) {
      return null;
    }
  }).handleError((error) {
    return null;
  });
}

/// FutureProvider for all users (excluding current user)
/// 
/// Fetches all users from Firestore except the current authenticated user
/// Useful for displaying user list to start a chat
@riverpod
Future<List<UserModel>> allUsers(AllUsersRef ref) async {
  final firestoreService = FirestoreService();
  final authService = AuthService();
  final currentUserId = authService.currentUser?.uid;

  if (currentUserId == null) {
    return [];
  }

  try {
    return await firestoreService.getAllUsers(currentUserId);
  } catch (e) {
    // Return empty list on error
    return [];
  }
}
