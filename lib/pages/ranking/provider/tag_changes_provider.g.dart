// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_changes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tagChangesHash() => r'700c9ae9e87e46d37010a54179ca8c090e767065';

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

/// See also [tagChanges].
@ProviderFor(tagChanges)
const tagChangesProvider = TagChangesFamily();

/// See also [tagChanges].
class TagChangesFamily extends Family<AsyncValue<List<TagChange>>> {
  /// See also [tagChanges].
  const TagChangesFamily();

  /// See also [tagChanges].
  TagChangesProvider call({
    required String id,
    int limit = DEFAULT_TAG_HISTORY_DAYS * 4,
  }) {
    return TagChangesProvider(
      id: id,
      limit: limit,
    );
  }

  @override
  TagChangesProvider getProviderOverride(
    covariant TagChangesProvider provider,
  ) {
    return call(
      id: provider.id,
      limit: provider.limit,
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
  String? get name => r'tagChangesProvider';
}

/// See also [tagChanges].
class TagChangesProvider extends AutoDisposeFutureProvider<List<TagChange>> {
  /// See also [tagChanges].
  TagChangesProvider({
    required String id,
    int limit = DEFAULT_TAG_HISTORY_DAYS * 4,
  }) : this._internal(
          (ref) => tagChanges(
            ref as TagChangesRef,
            id: id,
            limit: limit,
          ),
          from: tagChangesProvider,
          name: r'tagChangesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tagChangesHash,
          dependencies: TagChangesFamily._dependencies,
          allTransitiveDependencies:
              TagChangesFamily._allTransitiveDependencies,
          id: id,
          limit: limit,
        );

  TagChangesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.limit,
  }) : super.internal();

  final String id;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<TagChange>> Function(TagChangesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TagChangesProvider._internal(
        (ref) => create(ref as TagChangesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TagChange>> createElement() {
    return _TagChangesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TagChangesProvider &&
        other.id == id &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TagChangesRef on AutoDisposeFutureProviderRef<List<TagChange>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _TagChangesProviderElement
    extends AutoDisposeFutureProviderElement<List<TagChange>>
    with TagChangesRef {
  _TagChangesProviderElement(super.provider);

  @override
  String get id => (origin as TagChangesProvider).id;
  @override
  int get limit => (origin as TagChangesProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
