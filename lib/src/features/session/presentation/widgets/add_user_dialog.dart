import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 21),
                padding: const EdgeInsets.all(21),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.white,
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'password'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        context.read<AuthenticationCubit>().login(email: email, password: password);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Login')),
                ]))));
  }
}
