import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/models/models.dart';
import '../api_host.dart';

abstract class UserRemote {
  Future<UserModel> getUserList(int offset, int limit);
}

class UserRemoteImpl implements UserRemote {
  final http.Client client;
  UserRemoteImpl({required this.client});

  @override
  Future<UserModel> getUserList(int offset, int limit) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiURL.getUserPoint}?offset=$offset&limit=$limit'),
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data != null) {
        final res = UserModel.fromJson(data);
        if (res.success == true) {
          return res;
        } else {
          throw Exception(
              'Request was not successful.'); // Throw an exception for unsuccessful response
        }
      } else {
        throw Exception(
            'Failed to fetch data'); // Throw an exception for non-200 status codes
      }
    } catch (exception) {
      throw Exception(
          'Failed to fetch data'); // Throw an exception for any exceptions
    }
  }
}
