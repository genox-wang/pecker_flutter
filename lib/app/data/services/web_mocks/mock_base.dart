import 'package:protobuf/protobuf.dart';

import '../../../../proto/data/protocol_type.pb.dart';
import '../../../../proto/response/common_response.pb.dart';

abstract class MockBase {
  Future<CommonResponse?> mock(
    ProtocolType type, {
    String? ticket,
    GeneratedMessage? data,
  });
}
