///
//  Generated code. Do not modify.
//  source: request/common_request.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use commonRequestDescriptor instead')
const CommonRequest$json = const {
  '1': 'CommonRequest',
  '2': const [
    const {'1': 'proto_type', '3': 1, '4': 1, '5': 14, '6': '.data.ProtocolType', '10': 'protoType'},
    const {'1': 'version', '3': 2, '4': 1, '5': 3, '10': 'version'},
    const {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'ticket', '3': 4, '4': 1, '5': 9, '10': 'ticket'},
    const {'1': 'data', '3': 5, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `CommonRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonRequestDescriptor = $convert.base64Decode('Cg1Db21tb25SZXF1ZXN0EjEKCnByb3RvX3R5cGUYASABKA4yEi5kYXRhLlByb3RvY29sVHlwZVIJcHJvdG9UeXBlEhgKB3ZlcnNpb24YAiABKANSB3ZlcnNpb24SFAoFdG9rZW4YAyABKAlSBXRva2VuEhYKBnRpY2tldBgEIAEoCVIGdGlja2V0EhIKBGRhdGEYBSABKAxSBGRhdGE=');
@$core.Deprecated('Use idRequestDescriptor instead')
const IdRequest$json = const {
  '1': 'IdRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'avatar_sign', '3': 2, '4': 1, '5': 9, '10': 'avatarSign'},
  ],
};

/// Descriptor for `IdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idRequestDescriptor = $convert.base64Decode('CglJZFJlcXVlc3QSDgoCaWQYASABKANSAmlkEh8KC2F2YXRhcl9zaWduGAIgASgJUgphdmF0YXJTaWdu');
@$core.Deprecated('Use commonPaginationDescriptor instead')
const CommonPagination$json = const {
  '1': 'CommonPagination',
  '2': const [
    const {'1': 'offset', '3': 1, '4': 1, '5': 3, '10': 'offset'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 3, '10': 'limit'},
  ],
};

/// Descriptor for `CommonPagination`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonPaginationDescriptor = $convert.base64Decode('ChBDb21tb25QYWdpbmF0aW9uEhYKBm9mZnNldBgBIAEoA1IGb2Zmc2V0EhQKBWxpbWl0GAIgASgDUgVsaW1pdA==');
