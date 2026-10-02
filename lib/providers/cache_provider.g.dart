// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cacheHash() => r'76df4d26b210cd8b4910763baceb0deeca1f562e';

/// Provider for CacheService singleton
///
/// This provider creates and initializes a CacheService instance
/// The service is initialized once and reused across the app
///
/// Copied from [cache].
@ProviderFor(cache)
final cacheProvider = AutoDisposeProvider<CacheService>.internal(
  cache,
  name: r'cacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheRef = AutoDisposeProviderRef<CacheService>;
String _$cachedUserHash() => r'52113f89a6cd902736c3d6d90daa328d70b03e37';

/// Provider for cached current user
///
/// This is a FutureProvider that fetches the cached user from local storage
///
/// Copied from [cachedUser].
@ProviderFor(cachedUser)
final cachedUserProvider = AutoDisposeFutureProvider<UserModel?>.internal(
  cachedUser,
  name: r'cachedUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cachedUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CachedUserRef = AutoDisposeFutureProviderRef<UserModel?>;
String _$cachedUserIdHash() => r'54e8abb42f14390047305e0accb771cd0e19a486';

/// Provider for cached user ID
///
/// Returns the cached user ID or null if not found
///
/// Copied from [cachedUserId].
@ProviderFor(cachedUserId)
final cachedUserIdProvider = AutoDisposeFutureProvider<String?>.internal(
  cachedUserId,
  name: r'cachedUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cachedUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CachedUserIdRef = AutoDisposeFutureProviderRef<String?>;
String _$cacheManagerHash() => r'a7e2ede38e62823b1dc6395b26b421fa6f58cf81';

/// Notifier for managing cache operations
///
/// This notifier provides methods for cache CRUD operations
///
/// Copied from [CacheManager].
@ProviderFor(CacheManager)
final cacheManagerProvider =
    AutoDisposeAsyncNotifierProvider<CacheManager, void>.internal(
      CacheManager.new,
      name: r'cacheManagerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cacheManagerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CacheManager = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
