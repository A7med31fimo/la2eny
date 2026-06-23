import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/i_auth_repository.dart';

part 'auth_provider.g.dart';

// Lightweight stub — full implementation in Week 7
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AppUser? build() => null; // null = not initialized, will be set after auth check

  void setUser(AppUser user) => state = user;
  void clearUser() => state = AppUser.guest;

  bool get isAuthenticated => state != null && !state!.isGuest;
}
