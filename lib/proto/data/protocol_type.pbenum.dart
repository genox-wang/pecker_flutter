///
//  Generated code. Do not modify.
//  source: data/protocol_type.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ProtocolType extends $pb.ProtobufEnum {
  static const ProtocolType Undefined = ProtocolType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Undefined');
  static const ProtocolType Ping = ProtocolType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ping');
  static const ProtocolType Pong = ProtocolType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Pong');
  static const ProtocolType RegDevice = ProtocolType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RegDevice');

  static const $core.List<ProtocolType> values = <ProtocolType> [
    Undefined,
    Ping,
    Pong,
    RegDevice,
  ];

  static final $core.Map<$core.int, ProtocolType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolType? valueOf($core.int value) => _byValue[value];

  const ProtocolType._($core.int v, $core.String n) : super(v, n);
}

