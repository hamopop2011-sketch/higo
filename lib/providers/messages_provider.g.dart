// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messagesHash() => r'0537bc39e1567375dcc6f093429ac737822a7537';

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

/// StreamProvider family for messages in a specific chat room
///
/// This provider listens to real-time messages in a chat room
/// with pagination support (limited by messageCacheLimit)
///
/// Copied from [messages].
@ProviderFor(messages)
const messagesProvider = MessagesFamily();

/// StreamProvider family for messages in a specific chat room
///
/// This provider listens to real-time messages in a chat room
/// with pagination support (limited by messageCacheLimit)
///
/// Copied from [messages].
class MessagesFamily extends Family<AsyncValue<List<MessageModel>>> {
  /// StreamProvider family for messages in a specific chat room
  ///
  /// This provider listens to real-time messages in a chat room
  /// with pagination support (limited by messageCacheLimit)
  ///
  /// Copied from [messages].
  const MessagesFamily();

  /// StreamProvider family for messages in a specific chat room
  ///
  /// This provider listens to real-time messages in a chat room
  /// with pagination support (limited by messageCacheLimit)
  ///
  /// Copied from [messages].
  MessagesProvider call(String chatRoomId) {
    return MessagesProvider(chatRoomId);
  }

  @override
  MessagesProvider getProviderOverride(covariant MessagesProvider provider) {
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
  String? get name => r'messagesProvider';
}

/// StreamProvider family for messages in a specific chat room
///
/// This provider listens to real-time messages in a chat room
/// with pagination support (limited by messageCacheLimit)
///
/// Copied from [messages].
class MessagesProvider extends AutoDisposeStreamProvider<List<MessageModel>> {
  /// StreamProvider family for messages in a specific chat room
  ///
  /// This provider listens to real-time messages in a chat room
  /// with pagination support (limited by messageCacheLimit)
  ///
  /// Copied from [messages].
  MessagesProvider(String chatRoomId)
    : this._internal(
        (ref) => messages(ref as MessagesRef, chatRoomId),
        from: messagesProvider,
        name: r'messagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$messagesHash,
        dependencies: MessagesFamily._dependencies,
        allTransitiveDependencies: MessagesFamily._allTransitiveDependencies,
        chatRoomId: chatRoomId,
      );

  MessagesProvider._internal(
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
    Stream<List<MessageModel>> Function(MessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MessagesProvider._internal(
        (ref) => create(ref as MessagesRef),
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
  AutoDisposeStreamProviderElement<List<MessageModel>> createElement() {
    return _MessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesProvider && other.chatRoomId == chatRoomId;
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
mixin MessagesRef on AutoDisposeStreamProviderRef<List<MessageModel>> {
  /// The parameter `chatRoomId` of this provider.
  String get chatRoomId;
}

class _MessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<MessageModel>>
    with MessagesRef {
  _MessagesProviderElement(super.provider);

  @override
  String get chatRoomId => (origin as MessagesProvider).chatRoomId;
}

String _$paginatedMessagesHash() => r'38a3457f8ed452ac06d4bd4b990b10c10625d2c3';

/// StreamProvider family for paginated messages
///
/// This provider allows fetching messages with custom limit for pagination
///
/// Copied from [paginatedMessages].
@ProviderFor(paginatedMessages)
const paginatedMessagesProvider = PaginatedMessagesFamily();

/// StreamProvider family for paginated messages
///
/// This provider allows fetching messages with custom limit for pagination
///
/// Copied from [paginatedMessages].
class PaginatedMessagesFamily extends Family<AsyncValue<List<MessageModel>>> {
  /// StreamProvider family for paginated messages
  ///
  /// This provider allows fetching messages with custom limit for pagination
  ///
  /// Copied from [paginatedMessages].
  const PaginatedMessagesFamily();

  /// StreamProvider family for paginated messages
  ///
  /// This provider allows fetching messages with custom limit for pagination
  ///
  /// Copied from [paginatedMessages].
  PaginatedMessagesProvider call(
    String chatRoomId, {
    int limit = 50,
    DocumentSnapshot<Object?>? startAfter,
  }) {
    return PaginatedMessagesProvider(
      chatRoomId,
      limit: limit,
      startAfter: startAfter,
    );
  }

  @override
  PaginatedMessagesProvider getProviderOverride(
    covariant PaginatedMessagesProvider provider,
  ) {
    return call(
      provider.chatRoomId,
      limit: provider.limit,
      startAfter: provider.startAfter,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paginatedMessagesProvider';
}

/// StreamProvider family for paginated messages
///
/// This provider allows fetching messages with custom limit for pagination
///
/// Copied from [paginatedMessages].
class PaginatedMessagesProvider
    extends AutoDisposeStreamProvider<List<MessageModel>> {
  /// StreamProvider family for paginated messages
  ///
  /// This provider allows fetching messages with custom limit for pagination
  ///
  /// Copied from [paginatedMessages].
  PaginatedMessagesProvider(
    String chatRoomId, {
    int limit = 50,
    DocumentSnapshot<Object?>? startAfter,
  }) : this._internal(
         (ref) => paginatedMessages(
           ref as PaginatedMessagesRef,
           chatRoomId,
           limit: limit,
           startAfter: startAfter,
         ),
         from: paginatedMessagesProvider,
         name: r'paginatedMessagesProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$paginatedMessagesHash,
         dependencies: PaginatedMessagesFamily._dependencies,
         allTransitiveDependencies:
             PaginatedMessagesFamily._allTransitiveDependencies,
         chatRoomId: chatRoomId,
         limit: limit,
         startAfter: startAfter,
       );

  PaginatedMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatRoomId,
    required this.limit,
    required this.startAfter,
  }) : super.internal();

  final String chatRoomId;
  final int limit;
  final DocumentSnapshot<Object?>? startAfter;

  @override
  Override overrideWith(
    Stream<List<MessageModel>> Function(PaginatedMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PaginatedMessagesProvider._internal(
        (ref) => create(ref as PaginatedMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatRoomId: chatRoomId,
        limit: limit,
        startAfter: startAfter,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MessageModel>> createElement() {
    return _PaginatedMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaginatedMessagesProvider &&
        other.chatRoomId == chatRoomId &&
        other.limit == limit &&
        other.startAfter == startAfter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatRoomId.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, startAfter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PaginatedMessagesRef on AutoDisposeStreamProviderRef<List<MessageModel>> {
  /// The parameter `chatRoomId` of this provider.
  String get chatRoomId;

  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `startAfter` of this provider.
  DocumentSnapshot<Object?>? get startAfter;
}

class _PaginatedMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<MessageModel>>
    with PaginatedMessagesRef {
  _PaginatedMessagesProviderElement(super.provider);

  @override
  String get chatRoomId => (origin as PaginatedMessagesProvider).chatRoomId;
  @override
  int get limit => (origin as PaginatedMessagesProvider).limit;
  @override
  DocumentSnapshot<Object?>? get startAfter =>
      (origin as PaginatedMessagesProvider).startAfter;
}

String _$unreadMessagesCountHash() =>
    r'd5d37cd7046ef800598144309a0c98dd1d0c9ffe';

/// Provider for unread messages count in a specific chat room
///
/// Copied from [unreadMessagesCount].
@ProviderFor(unreadMessagesCount)
const unreadMessagesCountProvider = UnreadMessagesCountFamily();

/// Provider for unread messages count in a specific chat room
///
/// Copied from [unreadMessagesCount].
class UnreadMessagesCountFamily extends Family<AsyncValue<int>> {
  /// Provider for unread messages count in a specific chat room
  ///
  /// Copied from [unreadMessagesCount].
  const UnreadMessagesCountFamily();

  /// Provider for unread messages count in a specific chat room
  ///
  /// Copied from [unreadMessagesCount].
  UnreadMessagesCountProvider call(String chatRoomId, String currentUserId) {
    return UnreadMessagesCountProvider(chatRoomId, currentUserId);
  }

  @override
  UnreadMessagesCountProvider getProviderOverride(
    covariant UnreadMessagesCountProvider provider,
  ) {
    return call(provider.chatRoomId, provider.currentUserId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'unreadMessagesCountProvider';
}

/// Provider for unread messages count in a specific chat room
///
/// Copied from [unreadMessagesCount].
class UnreadMessagesCountProvider extends AutoDisposeStreamProvider<int> {
  /// Provider for unread messages count in a specific chat room
  ///
  /// Copied from [unreadMessagesCount].
  UnreadMessagesCountProvider(String chatRoomId, String currentUserId)
    : this._internal(
        (ref) => unreadMessagesCount(
          ref as UnreadMessagesCountRef,
          chatRoomId,
          currentUserId,
        ),
        from: unreadMessagesCountProvider,
        name: r'unreadMessagesCountProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$unreadMessagesCountHash,
        dependencies: UnreadMessagesCountFamily._dependencies,
        allTransitiveDependencies:
            UnreadMessagesCountFamily._allTransitiveDependencies,
        chatRoomId: chatRoomId,
        currentUserId: currentUserId,
      );

  UnreadMessagesCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatRoomId,
    required this.currentUserId,
  }) : super.internal();

  final String chatRoomId;
  final String currentUserId;

  @override
  Override overrideWith(
    Stream<int> Function(UnreadMessagesCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnreadMessagesCountProvider._internal(
        (ref) => create(ref as UnreadMessagesCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatRoomId: chatRoomId,
        currentUserId: currentUserId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<int> createElement() {
    return _UnreadMessagesCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnreadMessagesCountProvider &&
        other.chatRoomId == chatRoomId &&
        other.currentUserId == currentUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatRoomId.hashCode);
    hash = _SystemHash.combine(hash, currentUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UnreadMessagesCountRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `chatRoomId` of this provider.
  String get chatRoomId;

  /// The parameter `currentUserId` of this provider.
  String get currentUserId;
}

class _UnreadMessagesCountProviderElement
    extends AutoDisposeStreamProviderElement<int>
    with UnreadMessagesCountRef {
  _UnreadMessagesCountProviderElement(super.provider);

  @override
  String get chatRoomId => (origin as UnreadMessagesCountProvider).chatRoomId;
  @override
  String get currentUserId =>
      (origin as UnreadMessagesCountProvider).currentUserId;
}

String _$messageSenderHash() => r'fa2c26a26b5b62e23f427ae47f24dac1e9d98bfa';

/// Provider for sending a message
///
/// This is a utility provider for sending messages to a chat room
///
/// Copied from [MessageSender].
@ProviderFor(MessageSender)
final messageSenderProvider =
    AutoDisposeAsyncNotifierProvider<MessageSender, void>.internal(
      MessageSender.new,
      name: r'messageSenderProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$messageSenderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MessageSender = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
