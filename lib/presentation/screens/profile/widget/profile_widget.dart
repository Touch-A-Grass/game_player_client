import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/profile/bloc/profile_bloc.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ProfileBloc>().add(const ProfileEvent.logout());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocListener<ProfileBloc, ProfileState>(
                listenWhen: (previous, current) => previous.username != current.username,
                listener: (context, state) {
                  nameController.text = state.username;
                },
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                  readOnly: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
