import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_cubit.dart';
import 'package:game_player_client/presentation/navigation/common/navigation_state.dart';
import 'package:game_player_client/presentation/navigation/common/page_mapper.dart';

class AppNavigator<B extends NavigationCubit<S>, S extends NavigationState> extends StatefulWidget {
  final PageMapper<S> pageMapper;
  final Key? navigatorKey;

  const AppNavigator({super.key, required this.pageMapper, this.navigatorKey});

  @override
  State<AppNavigator> createState() => _AppNavigatorState<B, S>();
}

class _AppNavigatorState<B extends NavigationCubit<S>, S extends NavigationState> extends State<AppNavigator> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        return NavigatorPopHandler(
          onPop: () {
            if (state.getPrevState() != null) {
              _navigatorKey.currentState?.maybePop();
            }
          },
          child: Navigator(
            key: widget.navigatorKey ?? navigatorKey,
            onPopPage: (route, result) => _onPopPage(context, route, result, state),
            pages: _buildPages(context, state),
          ),
        );
      },
    );
  }

  List<Page> _buildPages(BuildContext context, S state) {
    final pages = <Page>[];

    S? currentState = state;
    do {
      if (currentState != null) {
        final page = widget.pageMapper.map(context, currentState);
        pages.insert(0, page);
        currentState = currentState.getPrevState();
      }
    } while (currentState != null);
    return pages;
  }

  bool _onPopPage(BuildContext context, Route<dynamic> route, result, S state) {
    if (route.isFirst) {
      Navigator.maybeOf(context)?.maybePop();
      return false;
    }

    final didPop = route.didPop(result);

    if (didPop) {
      BlocProvider.of<B>(context).back();
    }

    return didPop;
  }

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
