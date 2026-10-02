import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/cache_service.dart';
import '../models/user_model.dart';

part 'cache_provider.g.dart';

/// Provider for CacheService singleton
/// 
/// This provider creates and initializes a CacheService instance
/// The service is initialized once and reused across the app
@riverpod
CacheService cache(CacheRef ref) {
  final service = CacheService();
  // Initialize the cache service
  service.initialize();
  return service;
}

/// Provider for cached current user
/// 
/// This is a FutureProvider that fetches the cached user from local storage
@riverpod
Future<UserModel?> cachedUser(CachedUserRef ref) async {
  final cacheService = ref.watch(cacheProvider);
  
  try {
    return await cacheService.getCurrentUser();
  } catch (e) {
    return null;
  }
}

/// Provider for cached user ID
/// 
/// Returns the cached user ID or null if not found
@riverpod
Future<String?> cachedUserId(CachedUserIdRef ref) async {
  final cacheService = ref.watch(cacheProvider);
  
  try {
    return await cacheService.getUserId();
  } catch (e) {
    return null;
  }
}

/// Notifier for managing cache operations
/// 
/// This notifier provides methods for cache CRUD operations
@riverpod
class CacheManager extends _$CacheManager {
  late final CacheService _cacheService;

  @override
  FutureOr<void> build() {
    _cacheService = ref.watch(cacheProvider);
  }

  /// Save current user to cache
  Future<bool> saveUser(UserModel user) async {
    try {
      final result = await _cacheService.saveCurrentUser(user);
      // Invalidate cached user provider to refresh
      ref.invalidate(cachedUserProvider);
      ref.invalidate(cachedUserIdProvider);
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Clear current user from cache
  Future<bool> clearUser() async {
    try {
      final result = await _cacheService.clearCurrentUser();
      // Invalidate cached user provider to refresh
      ref.invalidate(cachedUserProvider);
      ref.invalidate(cachedUserIdProvider);
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Save a string value to cache
  Future<bool> saveString(String key, String value) async {
    try {
      return await _cacheService.saveString(key, value);
    } catch (e) {
      return false;
    }
  }

  /// Get a string value from cache
  Future<String?> getString(String key) async {
    try {
      return await _cacheService.getString(key);
    } catch (e) {
      return null;
    }
  }

  /// Save an integer value to cache
  Future<bool> saveInt(String key, int value) async {
    try {
      return await _cacheService.saveInt(key, value);
    } catch (e) {
      return false;
    }
  }

  /// Get an integer value from cache
  Future<int?> getInt(String key) async {
    try {
      return await _cacheService.getInt(key);
    } catch (e) {
      return null;
    }
  }

  /// Save a boolean value to cache
  Future<bool> saveBool(String key, bool value) async {
    try {
      return await _cacheService.saveBool(key, value);
    } catch (e) {
      return false;
    }
  }

  /// Get a boolean value from cache
  Future<bool?> getBool(String key) async {
    try {
      return await _cacheService.getBool(key);
    } catch (e) {
      return null;
    }
  }

  /// Remove a value from cache
  Future<bool> remove(String key) async {
    try {
      return await _cacheService.remove(key);
    } catch (e) {
      return false;
    }
  }

  /// Clear all cache data
  Future<bool> clearAll() async {
    try {
      final result = await _cacheService.clearAll();
      // Invalidate all cache-related providers
      ref.invalidate(cachedUserProvider);
      ref.invalidate(cachedUserIdProvider);
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Check if a key exists in cache
  Future<bool> containsKey(String key) async {
    try {
      return await _cacheService.containsKey(key);
    } catch (e) {
      return false;
    }
  }
}
