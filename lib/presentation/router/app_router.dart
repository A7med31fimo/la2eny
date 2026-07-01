import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/home_screen.dart';
import '../screens/discovery/discovery_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/place_detail/place_detail_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/auth/login_screen.dart';
import 'main_shell.dart';

class AppRoutes {
  static const String home = '/';
  static const String discover = '/discover';
  static const String chat = '/chat';
  static const String placeDetail = '/place/:id';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String login = '/profile/login';
  static String placeDetailPath(int id) => '/place/$id';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.home, builder: (_, __) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.discover, builder: (_, __) => const DiscoveryScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.chat, builder: (_, __) => const ChatScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.favorites, builder: (_, __) => const FavoritesScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (_, __) => const ProfileScreen(),
              routes: [
                GoRoute(path: 'login', builder: (_, __) => const LoginScreen()),
              ],
            ),
          ]),
        ],
      ),
      GoRoute(
        path: AppRoutes.placeDetail,
        builder: (_, s) =>
            PlaceDetailScreen(placeId: int.parse(s.pathParameters['id']!)),
      ),
      GoRoute(path: AppRoutes.search, builder: (_, __) => const SearchScreen()),
    ],
  );
});
