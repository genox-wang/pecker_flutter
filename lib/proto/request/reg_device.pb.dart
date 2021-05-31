///
//  Generated code. Do not modify.
//  source: request/reg_device.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../data/device_meta.pbenum.dart' as $1;

class ReqDeviceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReqDeviceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'request'), createEmptyInstance: create)
    ..e<$1.DeviceType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceType', $pb.PbFieldType.OE, defaultOrMaker: $1.DeviceType.DeviceTypeUndefined, valueOf: $1.DeviceType.valueOf, enumValues: $1.DeviceType.values)
    ..e<$1.DeviceKeyType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dkType', $pb.PbFieldType.OE, defaultOrMaker: $1.DeviceKeyType.DKTypeUndefined, valueOf: $1.DeviceKeyType.valueOf, enumValues: $1.DeviceKeyType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dkValue')
    ..e<$1.AppType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appType', $pb.PbFieldType.OE, defaultOrMaker: $1.AppType.AppTypeUndefined, valueOf: $1.AppType.valueOf, enumValues: $1.AppType.values)
    ..hasRequiredFields = false
  ;

  ReqDeviceRequest._() : super();
  factory ReqDeviceRequest({
    $1.DeviceType? deviceType,
    $1.DeviceKeyType? dkType,
    $core.String? dkValue,
    $1.AppType? appType,
  }) {
    final _result = create();
    if (deviceType != null) {
      _result.deviceType = deviceType;
    }
    if (dkType != null) {
      _result.dkType = dkType;
    }
    if (dkValue != null) {
      _result.dkValue = dkValue;
    }
    if (appType != null) {
      _result.appType = appType;
    }
    return _result;
  }
  factory ReqDeviceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReqDeviceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReqDeviceRequest clone() => ReqDeviceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReqDeviceRequest copyWith(void Function(ReqDeviceRequest) updates) => super.copyWith((message) => updates(message as ReqDeviceRequest)) as ReqDeviceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReqDeviceRequest create() => ReqDeviceRequest._();
  ReqDeviceRequest createEmptyInstance() => create();
  static $pb.PbList<ReqDeviceRequest> createRepeated() => $pb.PbList<ReqDeviceRequest>();
  @$core.pragma('dart2js:noInline')
  static ReqDeviceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReqDeviceRequest>(create);
  static ReqDeviceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.DeviceType get deviceType => $_getN(0);
  @$pb.TagNumber(1)
  set deviceType($1.DeviceType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceType() => clearField(1);

  @$pb.TagNumber(2)
  $1.DeviceKeyType get dkType => $_getN(1);
  @$pb.TagNumber(2)
  set dkType($1.DeviceKeyType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDkType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDkType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get dkValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set dkValue($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDkValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDkValue() => clearField(3);

  @$pb.TagNumber(4)
  $1.AppType get appType => $_getN(3);
  @$pb.TagNumber(4)
  set appType($1.AppType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAppType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAppType() => clearField(4);
}

