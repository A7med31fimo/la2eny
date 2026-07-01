import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/entities/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final String locale;
  const ChatBubble({super.key, required this.message, required this.locale});

  @override
  Widget build(BuildContext context) {
    if (message.isLoading) return _loadingBubble();
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(width: 30, height: 30, decoration: BoxDecoration(
              color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.smart_toy_outlined, color: AppColors.primary, size: 16)),
            const SizedBox(width: 8),
          ],
          Flexible(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isUser ? AppColors.userBubble : AppColors.aiBubble,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isUser ? 16 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 16))),
            child: Text(message.content,
              style: isUser ? AppTextStyles.chatUser : AppTextStyles.chatAi,
              textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr))),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _loadingBubble() => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(width: 30, height: 30, decoration: BoxDecoration(
        color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.smart_toy_outlined, color: AppColors.primary, size: 16)),
      const SizedBox(width: 8),
      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: AppColors.aiBubble,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),
            topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4))),
        child: const _TypingIndicator()),
    ]));
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();
  @override State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  @override void initState() {
    super.initState();
    _controllers = List.generate(3, (i) => AnimationController(vsync: this, duration: const Duration(milliseconds: 400))
      ..repeat(reverse: true, period: Duration(milliseconds: 600 + i * 200)));
  }
  @override void dispose() { for (final c in _controllers) {
    c.dispose();
  } super.dispose(); }
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: List.generate(3, (i) =>
    AnimatedBuilder(animation: _controllers[i], builder: (_, __) => Container(
      width: 6, height: 6 + _controllers[i].value * 6,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(color: AppColors.textSecondary, borderRadius: BorderRadius.circular(3))))));
}
