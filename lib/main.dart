import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/data/repository/auth_repository.dart';
import 'package:game_player_client/data/repository/lobby_repository.dart';
import 'package:game_player_client/data/storage/token_storage.dart';
import 'package:game_player_client/data/storage/user_storage.dart';
import 'package:game_player_client/presentation/navigation/common/app_route_delegate.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/root/root_navigation_state.dart';
import 'package:game_player_client/presentation/navigation/root/root_page_mapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final tokenStorage = TokenStorage();
  await tokenStorage.ensureInitialized();
  final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  runApp(MyApp(tokenStorage: tokenStorage, initialBrightness: brightness));
}

class MyApp extends StatefulWidget {
  final TokenStorage tokenStorage;
  final Brightness initialBrightness;

  const MyApp({
    super.key,
    required this.tokenStorage,
    required this.initialBrightness,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Brightness brightness;

  @override
  void initState() {
    super.initState();
    brightness = widget.initialBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Storages
        RepositoryProvider.value(value: widget.tokenStorage),
        RepositoryProvider(create: (context) => UserStorage()),

        // Repositories
        RepositoryProvider(create: (context) => AuthRepository(context.read(), context.read())),
        RepositoryProvider(create: (context) => LobbyRepository()),
      ],
      child: BlocProvider(
        create: (context) => RootNavigationCubit(context.read()),
        child: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: AppRouteDelegate<RootNavigationCubit, RootNavigationState>(
              pageMapper: const RootPageMapper(),
            ),
            theme: ThemeData(
              colorScheme: switch (brightness) {
                Brightness.light => lightDynamic ??
                    ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple,
                      brightness: Brightness.light,
                    ),
                Brightness.dark => darkDynamic ??
                    ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple,
                      brightness: Brightness.dark,
                    ),
              },
              brightness: brightness,
              useMaterial3: true,
            ),
          ),
        ),
      ),
    );
  }
}
