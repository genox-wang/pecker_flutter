///
//  Generated code. Do not modify.
//  source: response/common_response.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../data/protocol_type.pbenum.dart' as $0;

class CommonResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CommonResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'response'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..e<$0.ProtocolType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protoType', $pb.PbFieldType.OE, defaultOrMaker: $0.ProtocolType.Undefined, valueOf: $0.ProtocolType.valueOf, enumValues: $0.ProtocolType.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticket')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  CommonResponse._() : super();
  factory CommonResponse({
    $core.int? status,
    $core.String? token,
    $0.ProtocolType? protoType,
    $core.String? ticket,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (token != null) {
      _result.token = token;
    }
    if (protoType != null) {
      _result.protoType = protoType;
    }
    if (ticket != null) {
      _result.ticket = ticket;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory CommonResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommonResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommonResponse clone() => CommonResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommonResponse copyWith(void Function(CommonResponse) updates) => super.copyWith((message) => updates(message as CommonResponse)) as CommonResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommonResponse create() => CommonResponse._();
  CommonResponse createEmptyInstance() => create();
  static $pb.PbList<CommonResponse> createRepeated() => $pb.PbList<CommonResponse>();
  @$core.pragma('dart2js:noInline')
  static CommonResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommonResponse>(create);
  static CommonResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get status => $_getIZ(0);
  @$pb.TagNumber(1)
  set status($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => clearField(2);

  @$pb.TagNumber(3)
  $0.ProtocolType get protoType => $_getN(2);
  @$pb.TagNumber(3)
  set protoType($0.ProtocolType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasProtoType() => $_has(2);
  @$pb.TagNumber(3)
  void clearProtoType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get ticket => $_getSZ(3);
  @$pb.TagNumber(4)
  set ticket($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTicket() => $_has(3);
  @$pb.TagNumber(4)
  void clearTicket() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get data => $_getN(4);
  @$pb.TagNumber(5)
  set data($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasData() => $_has(4);
  @$pb.TagNumber(5)
  void clearData() => clearField(5);
}

