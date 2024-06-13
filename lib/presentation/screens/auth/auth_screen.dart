import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:game_player_client/presentation/screens/auth/widget/auth_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(context.read()),
      child: const AuthWidget(),
    );
  }
}
