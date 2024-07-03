import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/game/bloc/game_bloc.dart';
import 'package:game_player_client/presentation/screens/game/features/chat/bloc/chat_bloc.dart';
import 'package:game_player_client/presentation/screens/game/features/stats/bloc/stats_bloc.dart';
import 'package:game_player_client/presentation/screens/game/widget/game_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GameBloc(context.read())),
        BlocProvider(create: (_) => ChatBloc(context.read())),
        BlocProvider(create: (_) => StatsBloc(context.read())),
      ],
      child: const PopScope(canPop: false, child: GameWidget()),
    );
  }
}
