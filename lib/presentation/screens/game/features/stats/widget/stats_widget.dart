import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/game/features/stats/bloc/stats_bloc.dart';
import 'package:game_player_client/presentation/widgets/app_insets.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const AppInsets.topHorizontal(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(state.character?.name ?? '', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Text(state.character?.description ?? '', style: Theme.of(context).textTheme.bodyMedium),
              ]),
            ),
          ),
          SliverPadding(
            padding: const AppInsets.topHorizontal(16),
            sliver: SliverToBoxAdapter(
              child: Text('Attributes', style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          SliverPadding(
            padding: const AppInsets.topHorizontal(16),
            sliver: SliverList.separated(
              itemCount: state.character?.attributes.length ?? 0,
              itemBuilder: (context, index) => Row(
                children: [
                  Expanded(child: Text(state.character?.attributes[index].name ?? '')),
                  const VerticalDivider(),
                  Expanded(
                    child: Text(state.character?.attributes[index].value.toString() ?? '', textAlign: TextAlign.end),
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
          SliverPadding(
            padding: const AppInsets.topHorizontal(16),
            sliver: SliverToBoxAdapter(
              child: Text('Skills', style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.separated(
              itemCount: state.character?.skills.length ?? 0,
              itemBuilder: (context, index) => Row(
                children: [
                  Expanded(child: Text(state.character?.skills[index].name ?? '')),
                  const VerticalDivider(),
                  Expanded(
                    child: Text(
                      state.character?.skills[index].attribute.toString() ?? '',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: Text(state.character?.skills[index].value.toString() ?? '', textAlign: TextAlign.end),
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
