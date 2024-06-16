import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/lobbies/bloc/lobbies_bloc.dart';
import 'package:game_player_client/presentation/screens/lobbies/screen/lobbies_widget.dart';

class LobbiesScreen extends StatelessWidget {
  const LobbiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LobbiesBloc(context.read()),
      child: const LobbiesWidget(),
    );
  }
}
