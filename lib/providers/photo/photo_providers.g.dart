// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPhotosHash() => r'782b5b4d6cf039719b5ba641c558e9308a0b67aa';

/// See also [fetchPhotos].
@ProviderFor(fetchPhotos)
final fetchPhotosProvider = AutoDisposeFutureProvider<List<Photo>>.internal(
  fetchPhotos,
  name: r'fetchPhotosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchPhotosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchPhotosRef = AutoDisposeFutureProviderRef<List<Photo>>;
String _$filteredPhotosHash() => r'20c0650d85922a05350e15560ce31250d7c5c0d3';

/// See also [filteredPhotos].
@ProviderFor(filteredPhotos)
final filteredPhotosProvider = AutoDisposeFutureProvider<List<Photo>>.internal(
  filteredPhotos,
  name: r'filteredPhotosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredPhotosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredPhotosRef = AutoDisposeFutureProviderRef<List<Photo>>;
String _$refreshPhotosHash() => r'91d55d92601bae45663be3cb67c1e6afd23a46cc';

/// See also [refreshPhotos].
@ProviderFor(refreshPhotos)
final refreshPhotosProvider = AutoDisposeFutureProvider<void>.internal(
  refreshPhotos,
  name: r'refreshPhotosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$refreshPhotosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshPhotosRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
