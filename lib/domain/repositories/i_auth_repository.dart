class AppUser {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String provider; // 'google' | 'apple' | 'guest'

  const AppUser({
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
    required this.provider,
  });

  bool get isGuest => provider == 'guest';

  static const AppUser guest = AppUser(id: '', provider: 'guest');
}

abstract class IAuthRepository {
  /// Current user — null if not initialized yet
  AppUser? get currentUser;

  /// Stream of auth state changes
  Stream<AppUser?> get authStateStream;

  /// Sign in with Google
  Future<AppUser> signInWithGoogle();

  /// Sign in with Apple
  Future<AppUser> signInWithApple();

  /// Sign out (returns to guest mode)
  Future<void> signOut();

  /// Whether user is signed in (not guest)
  bool get isAuthenticated;
}
