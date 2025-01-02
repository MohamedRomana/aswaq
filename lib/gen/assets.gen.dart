/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/Lang/ar.json
  String get ar => 'assets/Lang/ar.json';

  /// File path: assets/Lang/en.json
  String get en => 'assets/Lang/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/alert.json
  String get alert => 'assets/img/alert.json';

  /// File path: assets/img/emptyorder.json
  String get emptyorder => 'assets/img/emptyorder.json';

  /// File path: assets/img/emptysearch.json
  String get emptysearch => 'assets/img/emptysearch.json';

  /// File path: assets/img/loading.json
  String get loading => 'assets/img/loading.json';

  /// File path: assets/img/login.json
  String get login => 'assets/img/login.json';

  /// File path: assets/img/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/img/logo.png');

  /// File path: assets/img/onboarding1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/img/onboarding1.png');

  /// File path: assets/img/onboarding2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/img/onboarding2.png');

  /// File path: assets/img/onboarding3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/img/onboarding3.png');

  /// List of all assets
  List<dynamic> get values => [
        alert,
        emptyorder,
        emptysearch,
        loading,
        login,
        logo,
        onboarding1,
        onboarding2,
        onboarding3
      ];
}

class Assets {
  Assets._();

  static const $AssetsLangGen lang = $AssetsLangGen();
  static const $AssetsImgGen img = $AssetsImgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
