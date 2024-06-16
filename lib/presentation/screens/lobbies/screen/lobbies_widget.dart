import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/lobbies/bloc/lobbies_bloc.dart';
import 'package:game_player_client/presentation/widgets/app_insets.dart';
import 'package:game_player_client/presentation/widgets/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LobbiesWidget extends StatefulWidget {
  const LobbiesWidget({super.key});

  @override
  State<LobbiesWidget> createState() => _LobbiesWidgetState();
}

class _LobbiesWidgetState extends State<LobbiesWidget> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LobbiesBloc, LobbiesState>(
      listenWhen: (prev, curr) => prev.error != curr.error && curr.error != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? '')));
      },
      child: BlocBuilder<LobbiesBloc, LobbiesState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Join lobby')),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const AppInsets.topHorizontal(16),
                    sliver: SliverToBoxAdapter(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Enter Code', style: Theme.of(context).textTheme.titleMedium),
                              const Gap(16),
                              BlocListener<LobbiesBloc, LobbiesState>(
                                listenWhen: (prev, curr) => curr.code != codeController.text,
                                listener: (context, state) => codeController.text = state.code,
                                child: PinCodeTextField(
                                  enabled: !state.isLoading,
                                  appContext: context,
                                  length: state.codeLength,
                                  controller: codeController,
                                  textCapitalization: TextCapitalization.characters,
                                  onChanged: (code) => context.read<LobbiesBloc>().add(LobbiesEvent.codeChanged(code)),
                                  textInputAction: state.isValidCode ? TextInputAction.done : TextInputAction.none,
                                  keyboardType: TextInputType.text,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                                  onCompleted: (code) =>
                                      context.read<LobbiesBloc>().add(const LobbiesEvent.joinRequested()),
                                  onSubmitted: (code) =>
                                      context.read<LobbiesBloc>().add(const LobbiesEvent.joinRequested()),
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    selectedColor: Colors.lightGreen,
                                    inactiveColor: Theme.of(context).colorScheme.primary,
                                    disabledColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              OutlinedButton(
                                onPressed: state.isValidCode && !state.isLoading
                                    ? () => context.read<LobbiesBloc>().add(const LobbiesEvent.joinRequested())
                                    : null,
                                child: const Text('Join'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const AppInsets.topHorizontal(16),
                    sliver: SliverToBoxAdapter(
                      child: Center(child: Text('or', style: Theme.of(context).textTheme.titleMedium)),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Scan QR', style: Theme.of(context).textTheme.titleMedium),
                              const Gap(16),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.qr_code_scanner,
                                  size: 64,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (state.isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}