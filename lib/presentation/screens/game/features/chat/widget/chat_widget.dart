import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/data/storage/user_storage.dart';
import 'package:game_player_client/presentation/screens/game/features/chat/bloc/chat_bloc.dart';
import 'package:game_player_client/presentation/screens/game/features/chat/widget/components/chat_message.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) => Column(
        children: [
          Expanded(
            child: ListView.separated(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final isOwnMessage = state.messages[index].user.username == context.read<UserStorage>().get()?.username;
                return ChatMessage(
                  message: state.messages[index],
                  isOwnMessage: isOwnMessage,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: state.messages.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(border: Border(top: BorderSide())),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context.read<ChatBloc>().add(ChatEvent.messageSent(_controller.text));
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
