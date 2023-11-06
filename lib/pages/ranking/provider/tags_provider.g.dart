// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tagsHash() => r'fd98f13de077a4231b8a8de6eb9dc4a4bf25a518';

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

/// See also [tags].
@ProviderFor(tags)
const tagsProvider = TagsFamily();

/// See also [tags].
class TagsFamily extends Family<AsyncValue<List<TagInfo>>> {
  /// See also [tags].
  const TagsFamily();

  /// See also [tags].
  TagsProvider call({
    TagsField field = TagsField.items_count,
    int limit = DEFAULT_TAG_HISTORY_DAYS * 4,
  }) {
    return TagsProvider(
      field: field,
      limit: limit,
    );
  }

  @override
  TagsProvider getProviderOverride(
    covariant TagsProvider provider,
  ) {
    return call(
      field: provider.field,
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
  String? get name => r'tagsProvider';
}

/// See also [tags].
class TagsProvider extends AutoDisposeFutureProvider<List<TagInfo>> {
  /// See also [tags].
  TagsProvider({
    TagsField field = TagsField.items_count,
    int limit = DEFAULT_TAG_HISTORY_DAYS * 4,
  }) : this._internal(
          (ref) => tags(
            ref as TagsRef,
            field: field,
            limit: limit,
          ),
          from: tagsProvider,
          name: r'tagsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$tagsHash,
          dependencies: TagsFamily._dependencies,
          allTransitiveDependencies: TagsFamily._allTransitiveDependencies,
          field: field,
          limit: limit,
        );

  TagsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.field,
    required this.limit,
  }) : super.internal();

  final TagsField field;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<TagInfo>> Function(TagsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TagsProvider._internal(
        (ref) => create(ref as TagsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        field: field,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TagInfo>> createElement() {
    return _TagsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TagsProvider &&
        other.field == field &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, field.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TagsRef on AutoDisposeFutureProviderRef<List<TagInfo>> {
  /// The parameter `field` of this provider.
  TagsField get field;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _TagsProviderElement
    extends AutoDisposeFutureProviderElement<List<TagInfo>> with TagsRef {
  _TagsProviderElement(super.provider);

  @override
  TagsField get field => (origin as TagsProvider).field;
  @override
  int get limit => (origin as TagsProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
