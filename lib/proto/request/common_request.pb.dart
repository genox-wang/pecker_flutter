///
//  Generated code. Do not modify.
//  source: request/common_request.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../data/protocol_type.pbenum.dart' as $0;

class CommonRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CommonRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'request'), createEmptyInstance: create)
    ..e<$0.ProtocolType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protoType', $pb.PbFieldType.OE, defaultOrMaker: $0.ProtocolType.Undefined, valueOf: $0.ProtocolType.valueOf, enumValues: $0.ProtocolType.values)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticket')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  CommonRequest._() : super();
  factory CommonRequest({
    $0.ProtocolType? protoType,
    $fixnum.Int64? version,
    $core.String? token,
    $core.String? ticket,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (protoType != null) {
      _result.protoType = protoType;
    }
    if (version != null) {
      _result.version = version;
    }
    if (token != null) {
      _result.token = token;
    }
    if (ticket != null) {
      _result.ticket = ticket;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory CommonRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommonRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommonRequest clone() => CommonRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommonRequest copyWith(void Function(CommonRequest) updates) => super.copyWith((message) => updates(message as CommonRequest)) as CommonRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommonRequest create() => CommonRequest._();
  CommonRequest createEmptyInstance() => create();
  static $pb.PbList<CommonRequest> createRepeated() => $pb.PbList<CommonRequest>();
  @$core.pragma('dart2js:noInline')
  static CommonRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommonRequest>(create);
  static CommonRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $0.ProtocolType get protoType => $_getN(0);
  @$pb.TagNumber(1)
  set protoType($0.ProtocolType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProtoType() => $_has(0);
  @$pb.TagNumber(1)
  void clearProtoType() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get version => $_getI64(1);
  @$pb.TagNumber(2)
  set version($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);

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

class IdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'request'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avatarSign')
    ..hasRequiredFields = false
  ;

  IdRequest._() : super();
  factory IdRequest({
    $fixnum.Int64? id,
    $core.String? avatarSign,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (avatarSign != null) {
      _result.avatarSign = avatarSign;
    }
    return _result;
  }
  factory IdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IdRequest clone() => IdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IdRequest copyWith(void Function(IdRequest) updates) => super.copyWith((message) => updates(message as IdRequest)) as IdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IdRequest create() => IdRequest._();
  IdRequest createEmptyInstance() => create();
  static $pb.PbList<IdRequest> createRepeated() => $pb.PbList<IdRequest>();
  @$core.pragma('dart2js:noInline')
  static IdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdRequest>(create);
  static IdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get avatarSign => $_getSZ(1);
  @$pb.TagNumber(2)
  set avatarSign($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAvatarSign() => $_has(1);
  @$pb.TagNumber(2)
  void clearAvatarSign() => clearField(2);
}

class CommonPagination extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CommonPagination', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'request'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit')
    ..hasRequiredFields = false
  ;

  CommonPagination._() : super();
  factory CommonPagination({
    $fixnum.Int64? offset,
    $fixnum.Int64? limit,
  }) {
    final _result = create();
    if (offset != null) {
      _result.offset = offset;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory CommonPagination.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommonPagination.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommonPagination clone() => CommonPagination()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommonPagination copyWith(void Function(CommonPagination) updates) => super.copyWith((message) => updates(message as CommonPagination)) as CommonPagination; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommonPagination create() => CommonPagination._();
  CommonPagination createEmptyInstance() => create();
  static $pb.PbList<CommonPagination> createRepeated() => $pb.PbList<CommonPagination>();
  @$core.pragma('dart2js:noInline')
  static CommonPagination getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommonPagination>(create);
  static CommonPagination? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get offset => $_getI64(0);
  @$pb.TagNumber(1)
  set offset($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOffset() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffset() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get limit => $_getI64(1);
  @$pb.TagNumber(2)
  set limit($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

