import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/navigation/common/app_navigator.dart';
import 'package:game_player_client/presentation/navigation/home/home_navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/home/home_navigation_state.dart';
import 'package:game_player_client/presentation/navigation/home/home_page_mapper.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
      builder: (context, navigationState) => Scaffold(
        body: const AppNavigator<HomeNavigationCubit, HomeNavigationState>(pageMapper: HomePageMapper()),
        bottomNavigationBar: NavigationBar(
          selectedIndex: switch (navigationState) {
            LobbiesState _ => 0,
            ProfileState _ => 1,
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Lobbies'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onDestinationSelected: (int index) {
            switch (index) {
              case 0:
                context.read<HomeNavigationCubit>().navigateToLobbies();
              case 1:
                context.read<HomeNavigationCubit>().navigateToProfile();
            }
          },
        ),
      ),
    );
  }
}
