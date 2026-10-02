// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRoomsHash() => r'09951bb90d9e566e63289d0a7a8199e1de4488e8';

/// StreamProvider for all chat rooms of the current user
///
/// This provider listens to real-time changes of chat rooms where
/// the current user is a participant
/// Returns empty list if no user is authenticated
///
/// Copied from [chatRooms].
@ProviderFor(chatRooms)
final chatRoomsProvider =
    AutoDisposeStreamProvider<List<ChatRoomModel>>.internal(
      chatRooms,
      name: r'chatRoomsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatRoomsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRoomsRef = AutoDisposeStreamProviderRef<List<ChatRoomModel>>;
String _$chatRoomByIdHash() => r'2571237de22b8be8098d5563cdc1abc909948729';

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

/// Provider for a specific chat room by ID
///
/// This is a family provider for fetching a specific chat room
///
/// Copied from [chatRoomById].
@ProviderFor(chatRoomById)
const chatRoomByIdProvider = ChatRoomByIdFamily();

/// Provider for a specific chat room by ID
///
/// This is a family provider for fetching a specific chat room
///
/// Copied from [chatRoomById].
class ChatRoomByIdFamily extends Family<AsyncValue<ChatRoomModel?>> {
  /// Provider for a specific chat room by ID
  ///
  /// This is a family provider for fetching a specific chat room
  ///
  /// Copied from [chatRoomById].
  const ChatRoomByIdFamily();

  /// Provider for a specific chat room by ID
  ///
  /// This is a family provider for fetching a specific chat room
  ///
  /// Copied from [chatRoomById].
  ChatRoomByIdProvider call(String chatRoomId) {
    return ChatRoomByIdProvider(chatRoomId);
  }

  @override
  ChatRoomByIdProvider getProviderOverride(
    covariant ChatRoomByIdProvider provider,
  ) {
    return call(provider.chatRoomId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatRoomByIdProvider';
}

/// Provider for a specific chat room by ID
///
/// This is a family provider for fetching a specific chat room
///
/// Copied from [chatRoomById].
class ChatRoomByIdProvider extends AutoDisposeFutureProvider<ChatRoomModel?> {
  /// Provider for a specific chat room by ID
  ///
  /// This is a family provider for fetching a specific chat room
  ///
  /// Copied from [chatRoomById].
  ChatRoomByIdProvider(String chatRoomId)
    : this._internal(
        (ref) => chatRoomById(ref as ChatRoomByIdRef, chatRoomId),
        from: chatRoomByIdProvider,
        name: r'chatRoomByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatRoomByIdHash,
        dependencies: ChatRoomByIdFamily._dependencies,
        allTransitiveDependencies:
            ChatRoomByIdFamily._allTransitiveDependencies,
        chatRoomId: chatRoomId,
      );

  ChatRoomByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatRoomId,
  }) : super.internal();

  final String chatRoomId;

  @override
  Override overrideWith(
    FutureOr<ChatRoomModel?> Function(ChatRoomByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatRoomByIdProvider._internal(
        (ref) => create(ref as ChatRoomByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatRoomId: chatRoomId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ChatRoomModel?> createElement() {
    return _ChatRoomByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatRoomByIdProvider && other.chatRoomId == chatRoomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatRoomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatRoomByIdRef on AutoDisposeFutureProviderRef<ChatRoomModel?> {
  /// The parameter `chatRoomId` of this provider.
  String get chatRoomId;
}

class _ChatRoomByIdProviderElement
    extends AutoDisposeFutureProviderElement<ChatRoomModel?>
    with ChatRoomByIdRef {
  _ChatRoomByIdProviderElement(super.provider);

  @override
  String get chatRoomId => (origin as ChatRoomByIdProvider).chatRoomId;
}

String _$getOrCreateChatRoomHash() =>
    r'1c8ecd6fc8d30e17e79ddd3fc5e446c38e677917';

/// Provider for creating or getting a chat room between two users
///
/// This provider creates a new chat room if it doesn't exist,
/// or returns the existing one if it does
///
/// Copied from [getOrCreateChatRoom].
@ProviderFor(getOrCreateChatRoom)
const getOrCreateChatRoomProvider = GetOrCreateChatRoomFamily();

/// Provider for creating or getting a chat room between two users
///
/// This provider creates a new chat room if it doesn't exist,
/// or returns the existing one if it does
///
/// Copied from [getOrCreateChatRoom].
class GetOrCreateChatRoomFamily extends Family<AsyncValue<ChatRoomModel?>> {
  /// Provider for creating or getting a chat room between two users
  ///
  /// This provider creates a new chat room if it doesn't exist,
  /// or returns the existing one if it does
  ///
  /// Copied from [getOrCreateChatRoom].
  const GetOrCreateChatRoomFamily();

  /// Provider for creating or getting a chat room between two users
  ///
  /// This provider creates a new chat room if it doesn't exist,
  /// or returns the existing one if it does
  ///
  /// Copied from [getOrCreateChatRoom].
  GetOrCreateChatRoomProvider call(List<String> participants) {
    return GetOrCreateChatRoomProvider(participants);
  }

  @override
  GetOrCreateChatRoomProvider getProviderOverride(
    covariant GetOrCreateChatRoomProvider provider,
  ) {
    return call(provider.participants);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getOrCreateChatRoomProvider';
}

/// Provider for creating or getting a chat room between two users
///
/// This provider creates a new chat room if it doesn't exist,
/// or returns the existing one if it does
///
/// Copied from [getOrCreateChatRoom].
class GetOrCreateChatRoomProvider
    extends AutoDisposeFutureProvider<ChatRoomModel?> {
  /// Provider for creating or getting a chat room between two users
  ///
  /// This provider creates a new chat room if it doesn't exist,
  /// or returns the existing one if it does
  ///
  /// Copied from [getOrCreateChatRoom].
  GetOrCreateChatRoomProvider(List<String> participants)
    : this._internal(
        (ref) =>
            getOrCreateChatRoom(ref as GetOrCreateChatRoomRef, participants),
        from: getOrCreateChatRoomProvider,
        name: r'getOrCreateChatRoomProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getOrCreateChatRoomHash,
        dependencies: GetOrCreateChatRoomFamily._dependencies,
        allTransitiveDependencies:
            GetOrCreateChatRoomFamily._allTransitiveDependencies,
        participants: participants,
      );

  GetOrCreateChatRoomProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.participants,
  }) : super.internal();

  final List<String> participants;

  @override
  Override overrideWith(
    FutureOr<ChatRoomModel?> Function(GetOrCreateChatRoomRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOrCreateChatRoomProvider._internal(
        (ref) => create(ref as GetOrCreateChatRoomRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        participants: participants,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ChatRoomModel?> createElement() {
    return _GetOrCreateChatRoomProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOrCreateChatRoomProvider &&
        other.participants == participants;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, participants.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetOrCreateChatRoomRef on AutoDisposeFutureProviderRef<ChatRoomModel?> {
  /// The parameter `participants` of this provider.
  List<String> get participants;
}

class _GetOrCreateChatRoomProviderElement
    extends AutoDisposeFutureProviderElement<ChatRoomModel?>
    with GetOrCreateChatRoomRef {
  _GetOrCreateChatRoomProviderElement(super.provider);

  @override
  List<String> get participants =>
      (origin as GetOrCreateChatRoomProvider).participants;
}

String _$totalUnreadCountHash() => r'763a0cb2f12c1ce9e5b32ca3da2c1b0846e7fb2d';

/// StreamProvider for unread message count across all chat rooms
///
/// Calculates total unread messages for the current user
///
/// Copied from [totalUnreadCount].
@ProviderFor(totalUnreadCount)
final totalUnreadCountProvider = AutoDisposeStreamProvider<int>.internal(
  totalUnreadCount,
  name: r'totalUnreadCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalUnreadCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalUnreadCountRef = AutoDisposeStreamProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
