import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_player_client/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:game_player_client/presentation/widgets/app_insets.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.error != curr.error,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const AppInsets.topHorizontal(16).add(
                        EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      ),
                      sliver: SliverToBoxAdapter(
                        child: TextFormField(
                          enabled: !state.isLoading,
                          controller: nameController,
                          decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const AppInsets.topHorizontal(16),
                      sliver: SliverToBoxAdapter(
                        child: TextFormField(
                          enabled: !state.isLoading,
                          controller: passwordController,
                          decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                          obscureText: true,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            const Spacer(),
                            const Gap(16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () {
                                        context.read<AuthBloc>().add(
                                            AuthEvent.loginRequested(nameController.text, passwordController.text));
                                      },
                                child: const Text('Login'),
                              ),
                            ),
                            const Gap(16),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () {
                                        context.read<AuthBloc>().add(
                                            AuthEvent.registerRequested(nameController.text, passwordController.text));
                                      },
                                child: const Text('Register'),
                              ),
                            ),
                            const Gap(16),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (state.isLoading) const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
