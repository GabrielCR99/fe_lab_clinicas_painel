import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import 'login_controller.dart';

final class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final class _LoginPageState extends State<LoginPage> {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _controller = Injector.get<LoginController>();

  @override
  void initState() {
    super.initState();
    context.messageListener(_controller);
    effect(() {
      if (_controller.logged) {
        Navigator.of(context).pushReplacementNamed<void, void>('/painel');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints(minHeight: sizeOf.height),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              constraints: BoxConstraints(maxWidth: sizeOf.width * 0.4),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('Login', style: titleStyle),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailEC,
                      decoration: const InputDecoration(label: Text('Email')),
                      validator: Validatorless.multiple([
                        Validatorless.required('Campo obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    Watch(
                      (_) => TextFormField(
                        controller: _passwordEC,
                        decoration: InputDecoration(
                          label: const Text('Senha'),
                          suffixIcon: IconButton(
                            onPressed: _controller.toggleObscurePassword,
                            icon: Icon(
                              _controller.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        obscureText: _controller.obscurePassword,
                        validator: Validatorless.required('Campo obrigatório'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: sizeOf.width * 0.8,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () =>
                            switch (_formKey.currentState?.validate()) {
                          null || false => null,
                          true => _controller.login(
                              email: _emailEC.text,
                              password: _passwordEC.text,
                            ),
                        },
                        child: const Text('ENTRAR'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }
}
