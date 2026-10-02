// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'4465b8c60f41f7b75e668ecebd3bad19ef0a4383';

/// StreamProvider for current user document from Firestore
///
/// This provider listens to real-time changes of the current user's document
/// Returns null if no user is authenticated
///
/// Copied from [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeStreamProvider<UserModel?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeStreamProviderRef<UserModel?>;
String _$currentUserIdHash() => r'2f2aa1bcd595b5ffda8384a3953df68071e1aee9';

/// Provider for current user ID
///
/// Returns the current authenticated user's ID or null
///
/// Copied from [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserIdRef = AutoDisposeProviderRef<String?>;
String _$userByIdHash() => r'6e3dd60d27373e39789f0b44b6f42d2984f703db';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// StreamProvider for a specific user by ID
///
/// This is a family provider that allows fetching any user by their ID
///
/// Copied from [userById].
@ProviderFor(userById)
const userByIdProvider = UserByIdFamily();

/// StreamProvider for a specific user by ID
///
/// This is a family provider that allows fetching any user by their ID
///
/// Copied from [userById].
class UserByIdFamily extends Family<AsyncValue<UserModel?>> {
  /// StreamProvider for a specific user by ID
  ///
  /// This is a family provider that allows fetching any user by their ID
  ///
  /// Copied from [userById].
  const UserByIdFamily();

  /// StreamProvider for a specific user by ID
  ///
  /// This is a family provider that allows fetching any user by their ID
  ///
  /// Copied from [userById].
  UserByIdProvider call(String userId) {
    return UserByIdProvider(userId);
  }

  @override
  UserByIdProvider getProviderOverride(covariant UserByIdProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userByIdProvider';
}

/// StreamProvider for a specific user by ID
///
/// This is a family provider that allows fetching any user by their ID
///
/// Copied from [userById].
class UserByIdProvider extends AutoDisposeStreamProvider<UserModel?> {
  /// StreamProvider for a specific user by ID
  ///
  /// This is a family provider that allows fetching any user by their ID
  ///
  /// Copied from [userById].
  UserByIdProvider(String userId)
    : this._internal(
        (ref) => userById(ref as UserByIdRef, userId),
        from: userByIdProvider,
        name: r'userByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userByIdHash,
        dependencies: UserByIdFamily._dependencies,
        allTransitiveDependencies: UserByIdFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<UserModel?> Function(UserByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserByIdProvider._internal(
        (ref) => create(ref as UserByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserModel?> createElement() {
    return _UserByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserByIdProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserByIdRef on AutoDisposeStreamProviderRef<UserModel?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserByIdProviderElement
    extends AutoDisposeStreamProviderElement<UserModel?>
    with UserByIdRef {
  _UserByIdProviderElement(super.provider);

  @override
  String get userId => (origin as UserByIdProvider).userId;
}

String _$allUsersHash() => r'7b2720629bea48dff989d6a94a3859f93a2ef8f9';

/// FutureProvider for all users (excluding current user)
///
/// Fetches all users from Firestore except the current authenticated user
/// Useful for displaying user list to start a chat
///
/// Copied from [allUsers].
@ProviderFor(allUsers)
final allUsersProvider = AutoDisposeFutureProvider<List<UserModel>>.internal(
  allUsers,
  name: r'allUsersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllUsersRef = AutoDisposeFutureProviderRef<List<UserModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
