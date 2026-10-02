import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

/// Service for caching data locally using SharedPreferences
class CacheService {
  SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception('${AppConstants.errorCacheLoad}: $e');
    }
  }

  /// Ensure SharedPreferences is initialized
  Future<SharedPreferences> _getPrefs() async {
    if (_prefs == null) {
      await initialize();
    }
    return _prefs!;
  }

  // ========== User Cache Operations ==========

  /// Save current user to cache
  Future<bool> saveCurrentUser(UserModel user) async {
    try {
      final prefs = await _getPrefs();
      final userJson = jsonEncode(user.toJson());
      final result = await prefs.setString(
        AppConstants.currentUserCacheKey,
        userJson,
      );
      await prefs.setString(AppConstants.userIdCacheKey, user.id);
      return result;
    } catch (e) {
      throw Exception('${AppConstants.errorCacheSave}: $e');
    }
  }

  /// Get current user from cache
  Future<UserModel?> getCurrentUser() async {
    try {
      final prefs = await _getPrefs();
      final userJson = prefs.getString(AppConstants.currentUserCacheKey);
      
      if (userJson == null) {
        return null;
      }

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      // Return null if cache is corrupted or empty
      return null;
    }
  }

  /// Get cached user ID
  Future<String?> getUserId() async {
    try {
      final prefs = await _getPrefs();
      return prefs.getString(AppConstants.userIdCacheKey);
    } catch (e) {
      return null;
    }
  }

  /// Clear current user from cache
  Future<bool> clearCurrentUser() async {
    try {
      final prefs = await _getPrefs();
      final result1 = await prefs.remove(AppConstants.currentUserCacheKey);
      final result2 = await prefs.remove(AppConstants.userIdCacheKey);
      return result1 && result2;
    } catch (e) {
      throw Exception('${AppConstants.errorCacheSave}: $e');
    }
  }

  // ========== Generic Cache Operations ==========

  /// Save a string value to cache
  Future<bool> saveString(String key, String value) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setString(key, value);
    } catch (e) {
      throw Exception('${AppConstants.errorCacheSave}: $e');
    }
  }

  /// Get a string value from cache
  Future<String?> getString(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  /// Save an integer value to cache
  Future<bool> saveInt(String key, int value) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setInt(key, value);
    } catch (e) {
      throw Exception('${AppConstants.errorCacheSave}: $e');
    }
  }

  /// Get an integer value from cache
  Future<int?> getInt(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getInt(key);
    } catch (e) {
      return null;
    }
  }

  /// Save a boolean value to cache
  Future<bool> saveBool(String key, bool value) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setBool(key, value);
    } catch (e) {
      throw Exception('${AppConstants.errorCacheSave}: $e');
    }
  }

  /// Get a boolean value from cache
  Future<bool?> getBool(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getBool(key);
    } catch (e) {
      return null;
    }
  }

  /// Remove a value from cache
  Future<bool> remove(String key) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.remove(key);
    } catch (e) {
      throw Exception('${AppConstants.errorCacheSave}: $e');
    }
  }

  /// Clear all cache data
  Future<bool> clearAll() async {
    try {
      final prefs = await _getPrefs();
      return await prefs.clear();
    } catch (e) {
      throw Exception('${AppConstants.errorCacheSave}: $e');
    }
  }

  /// Check if a key exists in cache
  Future<bool> containsKey(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.containsKey(key);
    } catch (e) {
      return false;
    }
  }
}
