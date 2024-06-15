import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/data/repository/auth_repository.dart';
import 'package:game_player_client/data/storage/token_storage.dart';
import 'package:game_player_client/data/storage/user_storage.dart';
import 'package:game_player_client/presentation/navigation/common/app_route_delegate.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_state.dart';
import 'package:game_player_client/presentation/navigation/root/root_page_mapper.dart';

void main() async {
  final tokenStorage = TokenStorage();
  await tokenStorage.ensureInitialized();

  runApp(MyApp(tokenStorage: tokenStorage));
}

class MyApp extends StatelessWidget {
  final TokenStorage tokenStorage;

  const MyApp({super.key, required this.tokenStorage});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Storages
        RepositoryProvider.value(value: tokenStorage),
        RepositoryProvider(create: (context) => UserStorage()),

        // Repositories
        RepositoryProvider(create: (context) => AuthRepository(context.read(), context.read())),
      ],
      child: BlocProvider(
        create: (context) => RootNavigationCubit(context.read()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate:
              AppRouteDelegate<RootNavigationCubit, RootNavigationState>(pageMapper: const RootPageMapper()),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
