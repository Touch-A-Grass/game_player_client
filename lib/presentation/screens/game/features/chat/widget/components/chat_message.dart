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
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.7),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  isOwnMessage ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainer,
              border: isOwnMessage ? null : Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: Column(
              crossAxisAlignment: isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.user.username,
                  style: TextStyle(
                    fontSize: 12,
                    color: isOwnMessage
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.text,
                  textAlign: isOwnMessage ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: isOwnMessage
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
