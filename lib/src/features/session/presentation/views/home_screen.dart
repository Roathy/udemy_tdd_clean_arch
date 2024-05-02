import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/authentication_cubit.dart';
import '../widgets/add_user_dialog.dart';
import '../widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(listener: (context, state) {
      if (state is AuthenticationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      } else if (state is UserCreated) {
        // getUsers();
      }
    }, builder: (context, state) {
      return Scaffold(
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Fetching Users')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating Users')
                  : state is UsersLoaded
                      ? Center(
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${state.response.success}'),
                            Text(state.response.message),
                            Text('${state.response.data['token']}'),
                          ]),
                          // child: ListView.builder(
                          //   itemCount: state.response.length,
                          //   itemBuilder: (context, index) {
                          //     debugPrint(state.response);
                          //     final user = state.response[index];
                          //     return ListTile(
                          //       leading: Text(user),
                          //     );
                          //   },
                          // ),
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AddUserDialog(
                        emailController: emailController,
                        passwordController: passwordController,
                      ));
            },
            icon: const Icon(Icons.add),
            label: const Text('Add User'),
          ));
    });
  }
}
