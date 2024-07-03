import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/profile/bloc/profile_bloc.dart';
import 'package:game_player_client/presentation/widgets/app_insets.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) => prev.error != curr.error,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Profile'),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(const ProfileEvent.logout());
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
                pinned: true,
              ),
              SliverPadding(
                padding: const AppInsets.topHorizontal(16),
                sliver: SliverToBoxAdapter(
                  child: BlocListener<ProfileBloc, ProfileState>(
                    listenWhen: (previous, current) => previous.username != current.username,
                    listener: (context, state) {
                      nameController.text = state.username;
                    },
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                      onChanged: (value) => context.read<ProfileBloc>().add(ProfileEvent.userNameChanged(value)),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ProfileBloc>().add(const ProfileEvent.saveRequested());
                          },
                          child: const Text('Save'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
