import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependecy_injection.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/login/presentation/pages/login_mixin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<LoginBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: const [
            HeaderLoginWidget(),
            Expanded(child: BodyLoginWidget()),
            FooterLoginWidget(),
          ],
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.fitWidth,
            "https://marketplace.canva.com/EADaosozdz0/1/0/1600w/canva-purple-sky-profile-header-XBJ23wlhl0s.jpg",
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Inicio de Sesión",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyFrom = GlobalKey<FormState>();

  @override
  void dispose() {
    _autoShowTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case LoginSuccessState():
            GoRouter.of(context).pushReplacementNamed("home");
            break;
          case LoginErrorState():
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            break;
          default:
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm =
              validatedEmail(state.model.email) == null &&
              validatedPassword(state.model.password) == null;

          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: keyFrom,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          onChanged: (value) => setState(() {
                            bloc.add(EmailChangedEvent(email: value));
                          }),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: validatedEmail,
                          decoration: const InputDecoration(
                            labelText: "Email:",
                            hintText: "Ingresa tu email",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          onChanged: (value) => setState(() {
                            bloc.add(PasswordChangedEvent(password: value));
                          }),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: validatedPassword,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            hintText: "Ingresa tu contraseña",
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                            suffixIcon: InkWell(
                              onTap: () {
                                _autoShowTimer?.cancel();
                                if (!_showPassword) {
                                  _autoShowTimer =
                                      Timer(const Duration(seconds: 3), () {
                                    if (mounted) {
                                      setState(() {
                                        _showPassword = false;
                                      });
                                    }
                                  });
                                }
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey.shade300;
                                }
                                return Colors.purple;
                              },
                            ),
                            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.black87;
                                }
                                return Colors.white;
                              },
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 16),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          onPressed: isValidForm ? () => bloc.add(SubmitEvent()) : null,
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Divider(indent: 40, endIndent: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("¿Aún no tienes cuenta?"),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed("sign-up"),
                child: const Text(
                  "Regístrate aquí",
                  style: TextStyle(
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
