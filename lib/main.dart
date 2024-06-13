import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/data/repository/auth_repository.dart';
import 'package:game_player_client/presentation/navigation/common/app_route_delegate.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_state.dart';
import 'package:game_player_client/presentation/navigation/root/root_page_mapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: BlocProvider(
        create: (context) => RootNavigationCubit(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: AppRouteDelegate<RootNavigationCubit, RootNavigationState>(pageMapper: RootPageMapper()),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
