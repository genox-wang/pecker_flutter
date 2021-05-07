import 'package:dio/dio.dart';
import 'package:moor/moor.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class UserAvatarApiClient {
  final _avatarLinks = [
    'https://img2.woyaogexing.com/2017/11/23/d3916bfdc7810ece!400x400_big.jpg',
    'https://img2.woyaogexing.com/2018/01/17/566d5bd4a8bf38ff!400x400_big.jpg',
    'http://img.woyaogexing.com/2017/01/03/e5f3f02c9ceca2a1!400x400_big.jpg',
    'http://img2.woyaogexing.com/2017/10/12/eb9903ea2dfb7e22!400x400_big.jpg',
  ];

  Future<Uint8List?> getAvatar(int id, {String? md5}) => Dio()
      .get<Uint8List>(_avatarLinks[id % 4],
          options: Options(
            responseType: ResponseType.bytes,
          ))
      .then((resp) => resp.data);
}
