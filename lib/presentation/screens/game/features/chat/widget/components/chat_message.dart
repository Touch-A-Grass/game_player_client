import 'package:flutter/material.dart';
import 'package:game_player_client/presentation/screens/game/features/chat/model/message_ui_model.dart';

class ChatMessage extends StatelessWidget {
  final MessageUiModel message;
  final bool isOwnMessage;

  const ChatMessage({
    super.key,
    required this.message,
    required this.isOwnMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isOwnMessage ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.user.username,
            style: TextStyle(
              fontSize: 12,
              color: isOwnMessage ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message.text,
            textAlign: isOwnMessage ? TextAlign.end : TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              color: isOwnMessage ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
