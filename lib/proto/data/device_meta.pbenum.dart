///
//  Generated code. Do not modify.
//  source: data/device_meta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class AppType extends $pb.ProtobufEnum {
  static const AppType AppTypeUndefined = AppType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AppTypeUndefined');
  static const AppType AppTypeDailySudoku = AppType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AppTypeDailySudoku');
  static const AppType AppTypeSudokuExpert = AppType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AppTypeSudokuExpert');

  static const $core.List<AppType> values = <AppType> [
    AppTypeUndefined,
    AppTypeDailySudoku,
    AppTypeSudokuExpert,
  ];

  static final $core.Map<$core.int, AppType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AppType? valueOf($core.int value) => _byValue[value];

  const AppType._($core.int v, $core.String n) : super(v, n);
}

class DeviceType extends $pb.ProtobufEnum {
  static const DeviceType DeviceTypeUndefined = DeviceType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeviceTypeUndefined');
  static const DeviceType DeviceTypeAndroid = DeviceType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeviceTypeAndroid');
  static const DeviceType DeviceTypeIOS = DeviceType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeviceTypeIOS');
  static const DeviceType DeviceTypeWeb = DeviceType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeviceTypeWeb');
  static const DeviceType DeviceTypeDouYin = DeviceType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeviceTypeDouYin');
  static const DeviceType DeviceTypeWeChat = DeviceType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeviceTypeWeChat');
  static const DeviceType DeviceTypeQuickApp = DeviceType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeviceTypeQuickApp');

  static const $core.List<DeviceType> values = <DeviceType> [
    DeviceTypeUndefined,
    DeviceTypeAndroid,
    DeviceTypeIOS,
    DeviceTypeWeb,
    DeviceTypeDouYin,
    DeviceTypeWeChat,
    DeviceTypeQuickApp,
  ];

  static final $core.Map<$core.int, DeviceType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DeviceType? valueOf($core.int value) => _byValue[value];

  const DeviceType._($core.int v, $core.String n) : super(v, n);
}

class DeviceKeyType extends $pb.ProtobufEnum {
  static const DeviceKeyType DKTypeUndefined = DeviceKeyType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DKTypeUndefined');
  static const DeviceKeyType DKTypeIDFA = DeviceKeyType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DKTypeIDFA');
  static const DeviceKeyType DKTypeIMEI = DeviceKeyType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DKTypeIMEI');
  static const DeviceKeyType DKTypeAndroidID = DeviceKeyType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DKTypeAndroidID');
  static const DeviceKeyType DKTypeOAID = DeviceKeyType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DKTypeOAID');
  static const DeviceKeyType DKTypeUUID = DeviceKeyType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DKTypeUUID');

  static const $core.List<DeviceKeyType> values = <DeviceKeyType> [
    DKTypeUndefined,
    DKTypeIDFA,
    DKTypeIMEI,
    DKTypeAndroidID,
    DKTypeOAID,
    DKTypeUUID,
  ];

  static final $core.Map<$core.int, DeviceKeyType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DeviceKeyType? valueOf($core.int value) => _byValue[value];

  const DeviceKeyType._($core.int v, $core.String n) : super(v, n);
}

