class AppUser {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String provider;
  const AppUser({required this.id, this.name, this.email, this.photoUrl, required this.provider});
  bool get isGuest => provider == 'guest';
  static const AppUser guest = AppUser(id: '', provider: 'guest');
}
abstract class IAuthRepository {
  AppUser? get currentUser;
  Stream<AppUser?> get authStateStream;
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithApple();
  Future<void> signOut();
  bool get isAuthenticated;
}
