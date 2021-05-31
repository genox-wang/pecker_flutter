import 'package:protobuf/protobuf.dart';

class APIResponse<T extends GeneratedMessage> {
  int? statusCode;
  T? data;
}
