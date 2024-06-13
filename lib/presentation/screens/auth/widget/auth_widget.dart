import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:game_player_client/presentation/widgets/gap.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthEvent.loginRequested());
                      },
                      child: const Text('Login'),
                    ),
                    const Gap(16),
                    OutlinedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthEvent.registerRequested());
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
              if (state.isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
