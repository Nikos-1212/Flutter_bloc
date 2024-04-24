import 'package:inventory_management/src/domain/models/user_model.dart';
import '../../data/data_sources/remote/user_remote.dart';

class GetUsers {
  final UserRemote _repository;
  GetUsers(this._repository);

  Future<UserModel> call(int offset, int limit) async {
    return await _repository.getUserList(offset, limit);
  }
}
