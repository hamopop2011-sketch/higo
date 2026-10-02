import 'package:firebase_core/firebase_core.dart';
import '../utils/constants.dart';

/// Service for initializing Firebase
class FirebaseService {
  static bool _initialized = false;

  /// Initialize Firebase app
  /// 
  /// Returns true if initialization is successful
  /// Throws exception with Arabic error message if initialization fails
  static Future<bool> initialize() async {
    if (_initialized) {
      return true;
    }

    try {
      await Firebase.initializeApp();
      _initialized = true;
      return true;
    } catch (e) {
      throw Exception('${AppConstants.errorFirebaseInit}: $e');
    }
  }

  /// Check if Firebase is initialized
  static bool get isInitialized => _initialized;

  /// Get current Firebase app instance
  static FirebaseApp? get currentApp {
    try {
      return Firebase.app();
    } catch (e) {
      return null;
    }
  }
}
