import 'package:flutter/material.dart';
import 'package:game_player_client/presentation/navigation/common/app_navigator.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_state.dart';
import 'package:game_player_client/presentation/navigation/common/page_mapper.dart';

class AppRouteConfig {}

class AppRouteDelegate<B extends NavigationCubit<S>, S extends NavigationState> extends RouterDelegate<AppRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final PageMapper<S> pageMapper;

  final GlobalKey<NavigatorState> _navigatorKey;

  AppRouteDelegate({required this.pageMapper}) : _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppNavigator<B, S>(
      pageMapper: pageMapper,
      navigatorKey: navigatorKey,
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {}
}
