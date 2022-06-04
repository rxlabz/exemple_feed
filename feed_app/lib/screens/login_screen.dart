import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.loginTask != null)
                  Center(
                    child: controller.loginTask!.maybeWhen(
                      loading: () => const CircularProgressIndicator(),
                      error: (message) => Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ),
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

  void _login(AuthController controller) {
    if (_formKey.currentState?.validate() == true) {
      controller.login(
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
