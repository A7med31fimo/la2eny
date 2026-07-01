import 'package:equatable/equatable.dart';
enum SocialPlatform { instagram, twitter, facebook, snapchat, tiktok, youtube, other }
class SocialLink extends Equatable {
  final int id;
  final int placeId;
  final SocialPlatform platform;
  final String url;
  const SocialLink({required this.id, required this.placeId, required this.platform, required this.url});
  static SocialPlatform platformFromString(String value) =>
    SocialPlatform.values.firstWhere((e) => e.name == value.toLowerCase(), orElse: () => SocialPlatform.other);
  @override List<Object?> get props => [id, platform, url];
}
