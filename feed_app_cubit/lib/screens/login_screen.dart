import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import 'auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthCubit>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(const Size(320, double.infinity)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AuthCubit, AsyncTask<User?>?>(
                    builder: (context, state) {
                  if (state == null) return const SizedBox.shrink();

                  return Center(
                    child: state.maybeWhen(
                      loading: () => const CircularProgressIndicator(),
                      error: (message) => Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  );
                }),
                FieldContainer(
                  TextFormField(
                    key: const Key('fieldMail'),
                    controller: mailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (String? value) =>
                        isEmail(value ?? '') ? null : 'Email invalide',
                  ),
                ),
                FieldContainer(
                  TextFormField(
                    key: const Key('fieldPass'),
                    controller: passwordController,
                    decoration:
                        const InputDecoration(labelText: 'Mot de passe'),
                    validator: (String? value) => (value?.length ?? 0) > 7
                        ? null
                        : '8 caractères minimum',
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                  key: const Key('btLogin'),
                  onPressed: () => _login(controller),
                  child: const Text('Entrer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(AuthCubit authController) {
    if (_formKey.currentState?.validate() == true) {
      authController.login(
        mail: mailController.text,
        password: passwordController.text,
      );
    }
  }
}

class FieldContainer extends StatelessWidget {
  final Widget child;

  const FieldContainer(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(12),
        child: child,
      );
}
