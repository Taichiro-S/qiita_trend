// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_url_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginUrlHash() => r'879af1e9325f7cd6fed0681447e7e070e21b3ec6';

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

/// See also [loginUrl].
@ProviderFor(loginUrl)
const loginUrlProvider = LoginUrlFamily();

/// See also [loginUrl].
class LoginUrlFamily extends Family<Uri> {
  /// See also [loginUrl].
  const LoginUrlFamily();

  /// See also [loginUrl].
  LoginUrlProvider call({
    required String uuid,
    required String clientId,
    required String scope,
  }) {
    return LoginUrlProvider(
      uuid: uuid,
      clientId: clientId,
      scope: scope,
    );
  }

  @override
  LoginUrlProvider getProviderOverride(
    covariant LoginUrlProvider provider,
  ) {
    return call(
      uuid: provider.uuid,
      clientId: provider.clientId,
      scope: provider.scope,
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
  String? get name => r'loginUrlProvider';
}

/// See also [loginUrl].
class LoginUrlProvider extends AutoDisposeProvider<Uri> {
  /// See also [loginUrl].
  LoginUrlProvider({
    required String uuid,
    required String clientId,
    required String scope,
  }) : this._internal(
          (ref) => loginUrl(
            ref as LoginUrlRef,
            uuid: uuid,
            clientId: clientId,
            scope: scope,
          ),
          from: loginUrlProvider,
          name: r'loginUrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginUrlHash,
          dependencies: LoginUrlFamily._dependencies,
          allTransitiveDependencies: LoginUrlFamily._allTransitiveDependencies,
          uuid: uuid,
          clientId: clientId,
          scope: scope,
        );

  LoginUrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uuid,
    required this.clientId,
    required this.scope,
  }) : super.internal();

  final String uuid;
  final String clientId;
  final String scope;

  @override
  Override overrideWith(
    Uri Function(LoginUrlRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginUrlProvider._internal(
        (ref) => create(ref as LoginUrlRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uuid: uuid,
        clientId: clientId,
        scope: scope,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Uri> createElement() {
    return _LoginUrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginUrlProvider &&
        other.uuid == uuid &&
        other.clientId == clientId &&
        other.scope == scope;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uuid.hashCode);
    hash = _SystemHash.combine(hash, clientId.hashCode);
    hash = _SystemHash.combine(hash, scope.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginUrlRef on AutoDisposeProviderRef<Uri> {
  /// The parameter `uuid` of this provider.
  String get uuid;

  /// The parameter `clientId` of this provider.
  String get clientId;

  /// The parameter `scope` of this provider.
  String get scope;
}

class _LoginUrlProviderElement extends AutoDisposeProviderElement<Uri>
    with LoginUrlRef {
  _LoginUrlProviderElement(super.provider);

  @override
  String get uuid => (origin as LoginUrlProvider).uuid;
  @override
  String get clientId => (origin as LoginUrlProvider).clientId;
  @override
  String get scope => (origin as LoginUrlProvider).scope;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
