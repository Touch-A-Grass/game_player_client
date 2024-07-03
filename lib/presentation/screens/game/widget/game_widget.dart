import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/game/bloc/game_bloc.dart';
import 'package:game_player_client/presentation/screens/game/features/chat/widget/chat_widget.dart';
import 'package:game_player_client/presentation/screens/game/features/roll/widget/roll_widget.dart';
import 'package:game_player_client/presentation/screens/game/features/stats/widget/stats_widget.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> with TickerProviderStateMixin {
  late final AnimationController rollAnimation;

  @override
  void initState() {
    super.initState();

    rollAnimation = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listenWhen: (prev, curr) => prev.roll != curr.roll,
      listener: (context, state) {
        if (state.roll != null) {
          rollAnimation.forward();
        } else {
          rollAnimation.reverse();
        }
      },
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Game'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Leave'),
                    onTap: () {
                      context.read<GameBloc>().add(const GameEvent.leave());
                    },
                  ),
                ],
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              const SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(tabs: [Tab(text: 'Chat'), Tab(text: 'Stats')]),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ChatWidget(),
                            StatsWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.roll != null)
                AnimatedBuilder(
                  animation: rollAnimation,
                  builder: (context, child) => ScaleTransition(
                    alignment: Alignment.topCenter,
                    scale: rollAnimation,
                    child: RollWidget(
                      roll: state.roll!,
                      onRollChanged: (result) {
                        context.read<GameBloc>().add(GameEvent.rollCompleted(result));
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
