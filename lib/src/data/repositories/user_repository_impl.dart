import 'package:inventory_management/src/data/data_sources/remote/user_remote.dart';
import 'package:inventory_management/src/domain/repositories/user_repository.dart';
import '../../domain/models/models.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemote _remoteUserource;
  const UserRepositoryImpl(this._remoteUserource);
  @override
  Future<UserModel> getUserList(int offset, int limit) async {
    final result = await _remoteUserource.getUserList(offset, limit);
    return result;
  }
}
