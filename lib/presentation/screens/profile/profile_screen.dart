import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/profile/bloc/profile_bloc.dart';
import 'package:game_player_client/presentation/screens/profile/widget/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(context.read())..add(const ProfileEvent.started()),
      child: const ProfileWidget(),
    );
  }
}
