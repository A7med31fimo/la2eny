import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/i_auth_repository.dart';

class AuthNotifier extends Notifier<AppUser?> {
  @override
  AppUser? build() => null;

  void setUser(AppUser user) => state = user;
  void clearUser() => state = AppUser.guest;
  bool get isAuthenticated => state != null && !state!.isGuest;
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);
