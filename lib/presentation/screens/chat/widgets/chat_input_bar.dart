import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatInputBar extends StatefulWidget {
  final String locale;
  final Future<void> Function(String) onSend;
  final Future<void> Function()? onVoice;
  final bool isThinking;

  const ChatInputBar({
    super.key,
    required this.locale,
    required this.onSend,
    this.onVoice,
    required this.isThinking,
  });

  @override
  State<ChatInputBar> createState() => _State();
}

class _State extends State<ChatInputBar> {
  final _ctrl = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() => _hasText = _ctrl.text.isNotEmpty));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _send() {
    if (_ctrl.text.trim().isEmpty || widget.isThinking) return;
    final text = _ctrl.text.trim();
    _ctrl.clear();
    widget.onSend(text);
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom + 8),
    decoration: const BoxDecoration(
      color: AppColors.surface,
      border: Border(top: BorderSide(color: AppColors.outline)),
    ),
    child: Row(children: [
      // Microphone button (shown when no text entered)
      if (widget.onVoice != null && !_hasText) ...[
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: widget.isThinking ? AppColors.surfaceVariant : AppColors.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.mic_rounded,
              size: 20,
              color: widget.isThinking ? AppColors.textTertiary : AppColors.primary,
            ),
            onPressed: widget.isThinking ? null : widget.onVoice,
          ),
        ),
        const SizedBox(width: 8),
      ],
      // Text input
      Expanded(
        child: TextField(
          controller: _ctrl,
          textDirection: widget.locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          onSubmitted: (_) => _send(),
          enabled: !widget.isThinking,
          maxLines: 4,
          minLines: 1,
          decoration: InputDecoration(
            hintText: widget.locale == 'ar'
                ? 'اكتب رسالتك...'
                : 'Ask me to find a place...',
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          style: AppTextStyles.bodyMedium,
        ),
      ),
      const SizedBox(width: 8),
      // Send button
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: (_hasText && !widget.isThinking) ? AppColors.primary : AppColors.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            Icons.send_rounded,
            size: 18,
            color: (_hasText && !widget.isThinking) ? Colors.white : AppColors.textTertiary,
          ),
          onPressed: _send,
        ),
      ),
    ]),
  );
}
