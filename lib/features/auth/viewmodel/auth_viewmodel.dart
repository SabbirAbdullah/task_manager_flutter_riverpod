import 'package:flutter_riverpod/legacy.dart';
import '../data/auth_repository.dart';
import '../data/auth_remote_datasource.dart';
import '../../../../core/dio/dio_provider.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, bool>((ref) {
  final dio = ref.read(dioProvider);
  return AuthViewModel(AuthRepository(AuthRemoteDataSource(dio)));
});

class AuthViewModel extends StateNotifier<bool> {
  final AuthRepository repo;
  AuthViewModel(this.repo) : super(false);

  Future<void> login(String email, String password) async {
    state = true;
    await repo.login(email, password);
    state = false;
  }

  Future<void> register(Map<String, dynamic> data) async {
    state = true;
    await repo.register(data);
    state = false;
  }

  Future<void> forgetPassword(
    String email,
    String currentPassword,
    String newPassword,
  ) async {
    state = true;
    await repo.forgetPassword(email, currentPassword, newPassword);
    state = false;
  }

  void logout() {
    repo.logout();
  }
}
