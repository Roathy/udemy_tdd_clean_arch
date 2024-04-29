import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({required this.controller, super.key});

  final TextEditingController controller;

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
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'username'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final name = controller.text.trim();
                        context.read<AuthenticationCubit>().createUser(name: name, avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/871.jpg", createdAt: DateTime.now().toString());
                        Navigator.of(context).pop();
                      },
                      child: const Text('Create User')),
                ]))));
  }
}
