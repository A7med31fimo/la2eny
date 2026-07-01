import 'package:equatable/equatable.dart';
import 'place.dart';
enum MessageRole { user, assistant }
class ChatMessage extends Equatable {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;
  final List<Place> recommendations;
  final bool isLoading;
  const ChatMessage({required this.id, required this.role, required this.content,
    required this.timestamp, this.recommendations = const [], this.isLoading = false});
  factory ChatMessage.user({required String content}) => ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(), role: MessageRole.user,
    content: content, timestamp: DateTime.now());
  factory ChatMessage.assistant({required String content, List<Place> recommendations = const []}) =>
    ChatMessage(id: DateTime.now().millisecondsSinceEpoch.toString(), role: MessageRole.assistant,
      content: content, timestamp: DateTime.now(), recommendations: recommendations);
  factory ChatMessage.loading() => ChatMessage(
    id: 'loading', role: MessageRole.assistant, content: '', timestamp: DateTime.now(), isLoading: true);
  bool get isUser => role == MessageRole.user;
  bool get isAssistant => role == MessageRole.assistant;
  bool get hasRecommendations => recommendations.isNotEmpty;
  @override List<Object?> get props => [id, role, content, timestamp];
}
