import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/cache_service.dart';

part 'auth_provider.g.dart';

/// Authentication state enum
enum AuthState { idle, loading, authenticated, error }

/// Authentication state data class
class AuthStateData {
  final AuthState state;
  final UserModel? user;
  final String? errorMessage;

  const AuthStateData({required this.state, this.user, this.errorMessage});

  AuthStateData copyWith({
    AuthState? state,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthStateData(
      state: state ?? this.state,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Provider for AuthService
@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}

/// Provider for FirestoreService
@riverpod
FirestoreService firestoreService(FirestoreServiceRef ref) {
  return FirestoreService();
}

/// Provider for CacheService
@riverpod
CacheService cacheService(CacheServiceRef ref) {
  final service = CacheService();
  // Initialize cache service
  service.initialize();
  return service;
}

/// StateNotifierProvider for managing authentication state
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthService _authService;
  late final FirestoreService _firestoreService;
  late final CacheService _cacheService;

  @override
  AuthStateData build() {
    _authService = ref.watch(authServiceProvider);
    _firestoreService = ref.watch(firestoreServiceProvider);
    _cacheService = ref.watch(cacheServiceProvider);

    // Check for cached user on initialization
    _checkCachedUser();

    return const AuthStateData(state: AuthState.idle);
  }

  /// Check if user is cached and restore session
  Future<void> _checkCachedUser() async {
    final cachedUser = await _cacheService.getCurrentUser();
    final firebaseUser = _authService.currentUser;

    if (cachedUser != null && firebaseUser != null) {
      state = AuthStateData(state: AuthState.authenticated, user: cachedUser);
    }
  }

  /// Sign up with email and password
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      state = state.copyWith(state: AuthState.loading);

      // Create user in Firebase Auth
      final user = await _authService.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );

      // Save user to Firestore
      await _firestoreService.saveUser(user);

      // Cache user locally
      await _cacheService.saveCurrentUser(user);

      state = AuthStateData(state: AuthState.authenticated, user: user);
    } catch (e) {
      state = AuthStateData(state: AuthState.error, errorMessage: e.toString());
    }
  }

  /// Sign in with email and password
  Future<void> signIn({required String email, required String password}) async {
    try {
      state = state.copyWith(state: AuthState.loading);

      // Sign in with Firebase Auth
      final user = await _authService.signIn(email: email, password: password);

      // Fetch full user data from Firestore
      final firestoreUser = await _firestoreService.getUser(user.id);
      final userData = firestoreUser ?? user;

      // Cache user locally
      await _cacheService.saveCurrentUser(userData);

      state = AuthStateData(state: AuthState.authenticated, user: userData);
    } catch (e) {
      state = AuthStateData(state: AuthState.error, errorMessage: e.toString());
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      state = state.copyWith(state: AuthState.loading);

      // Sign out from Firebase
      await _authService.signOut();

      // Clear cached user
      await _cacheService.clearCurrentUser();

      state = const AuthStateData(state: AuthState.idle);
    } catch (e) {
      state = AuthStateData(state: AuthState.error, errorMessage: e.toString());
    }
  }

  /// Clear error state
  void clearError() {
    if (state.state == AuthState.error) {
      state = state.copyWith(state: AuthState.idle, errorMessage: null);
    }
  }
}
