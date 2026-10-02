import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

/// Service for handling authentication operations
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current logged-in user
  User? get currentUser => _auth.currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up with email and password
  /// 
  /// Creates a new user account and returns UserModel
  /// Throws exception with Arabic error message if signup fails
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception(AppConstants.errorAuth);
      }

      // Update display name
      await user.updateDisplayName(displayName);
      await user.reload();

      return UserModel(
        id: user.uid,
        email: user.email ?? email,
        displayName: displayName,
        photoUrl: user.photoURL,
        createdAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw Exception('${AppConstants.errorAuth}: $e');
    }
  }

  /// Sign in with email and password
  /// 
  /// Authenticates user and returns UserModel
  /// Throws exception with Arabic error message if signin fails
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception(AppConstants.errorAuth);
      }

      return UserModel(
        id: user.uid,
        email: user.email ?? email,
        displayName: user.displayName ?? 'مستخدم',
        photoUrl: user.photoURL,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw Exception('${AppConstants.errorAuth}: $e');
    }
  }

  /// Sign out current user
  /// 
  /// Throws exception with Arabic error message if signout fails
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('${AppConstants.errorSignOut}: $e');
    }
  }

  /// Get current user as UserModel
  /// 
  /// Returns null if no user is logged in
  UserModel? getCurrentUser() {
    final user = currentUser;
    if (user == null) return null;

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'مستخدم',
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  /// Helper method to convert Firebase auth error codes to Arabic messages
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return AppConstants.errorEmailInUse;
      case 'invalid-email':
        return AppConstants.errorInvalidEmail;
      case 'weak-password':
        return AppConstants.errorWeakPassword;
      case 'wrong-password':
        return AppConstants.errorWrongPassword;
      case 'user-not-found':
        return AppConstants.errorUserNotFound;
      case 'user-disabled':
        return AppConstants.errorUserDisabled;
      case 'too-many-requests':
        return AppConstants.errorTooManyRequests;
      case 'operation-not-allowed':
        return AppConstants.errorOperationNotAllowed;
      default:
        return AppConstants.errorAuth;
    }
  }
}
