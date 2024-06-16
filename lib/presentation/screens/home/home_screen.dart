import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/navigation/home/home_navigation_cubit.dart';
import 'package:game_player_client/presentation/screens/home/bloc/home_bloc.dart';
import 'package:game_player_client/presentation/screens/home/widget/home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeNavigationCubit>(create: (context) => HomeNavigationCubit()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(context.read())..add(const HomeEvent.started())),
      ],
      child: const HomeWidget(),
    );
  }
}
