///
//  Generated code. Do not modify.
//  source: data/device_meta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use appTypeDescriptor instead')
const AppType$json = const {
  '1': 'AppType',
  '2': const [
    const {'1': 'AppTypeUndefined', '2': 0},
    const {'1': 'AppTypeDailySudoku', '2': 1},
    const {'1': 'AppTypeSudokuExpert', '2': 2},
  ],
};

/// Descriptor for `AppType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List appTypeDescriptor = $convert.base64Decode('CgdBcHBUeXBlEhQKEEFwcFR5cGVVbmRlZmluZWQQABIWChJBcHBUeXBlRGFpbHlTdWRva3UQARIXChNBcHBUeXBlU3Vkb2t1RXhwZXJ0EAI=');
@$core.Deprecated('Use deviceTypeDescriptor instead')
const DeviceType$json = const {
  '1': 'DeviceType',
  '2': const [
    const {'1': 'DeviceTypeUndefined', '2': 0},
    const {'1': 'DeviceTypeAndroid', '2': 1},
    const {'1': 'DeviceTypeIOS', '2': 2},
    const {'1': 'DeviceTypeWeb', '2': 3},
    const {'1': 'DeviceTypeDouYin', '2': 4},
    const {'1': 'DeviceTypeWeChat', '2': 5},
    const {'1': 'DeviceTypeQuickApp', '2': 6},
  ],
};

/// Descriptor for `DeviceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List deviceTypeDescriptor = $convert.base64Decode('CgpEZXZpY2VUeXBlEhcKE0RldmljZVR5cGVVbmRlZmluZWQQABIVChFEZXZpY2VUeXBlQW5kcm9pZBABEhEKDURldmljZVR5cGVJT1MQAhIRCg1EZXZpY2VUeXBlV2ViEAMSFAoQRGV2aWNlVHlwZURvdVlpbhAEEhQKEERldmljZVR5cGVXZUNoYXQQBRIWChJEZXZpY2VUeXBlUXVpY2tBcHAQBg==');
@$core.Deprecated('Use deviceKeyTypeDescriptor instead')
const DeviceKeyType$json = const {
  '1': 'DeviceKeyType',
  '2': const [
    const {'1': 'DKTypeUndefined', '2': 0},
    const {'1': 'DKTypeIDFA', '2': 1},
    const {'1': 'DKTypeIMEI', '2': 2},
    const {'1': 'DKTypeAndroidID', '2': 3},
    const {'1': 'DKTypeOAID', '2': 4},
    const {'1': 'DKTypeUUID', '2': 5},
  ],
};

/// Descriptor for `DeviceKeyType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List deviceKeyTypeDescriptor = $convert.base64Decode('Cg1EZXZpY2VLZXlUeXBlEhMKD0RLVHlwZVVuZGVmaW5lZBAAEg4KCkRLVHlwZUlERkEQARIOCgpES1R5cGVJTUVJEAISEwoPREtUeXBlQW5kcm9pZElEEAMSDgoKREtUeXBlT0FJRBAEEg4KCkRLVHlwZVVVSUQQBQ==');
