import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependecy_injection.dart';
import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_mixin.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<SignUpBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Registro Usuario",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: BodySignUpWidget(),
          ),
        ),
      ),
    );
  }
}

class BodySignUpWidget extends StatefulWidget {
  const BodySignUpWidget({super.key});

  @override
  State<BodySignUpWidget> createState() => _BodySignUpWidgetState();
}

class _BodySignUpWidgetState extends State<BodySignUpWidget> with SignupMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SuccessSignUpState) {
          GoRouter.of(context).pushNamed("login");
        } else if (state is ErrorSignUpState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: "Nombre", icon: Icon(Icons.person)),
                validator: (value) =>
                    value!.isEmpty ? "El nombre es obligatorio" : null,
              ),
              const SizedBox(height: 20.0),


              TextFormField(
                controller: emailController,
                onChanged: (value) => setState(() {
                  bloc.add(EmailChangedEvent(email: value));
                }),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validatedEmail,
                decoration: const InputDecoration(
                  labelText: "Email:",
                  icon: Icon(Icons.person),
                  hintText: "Escribe tu email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),


              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                    labelText: "URL Imagen de Perfil",
                    icon: Icon(Icons.image)),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 20.0),


              TextFormField(
                controller: passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  icon: const Icon(Icons.lock),
                  hintText: "Escribe tu contraseña",
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => _showPassword = !_showPassword),
                    child: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                validator: (value) =>
                    validatedPassword(value, confirmPasswordController.text),
              ),
              const SizedBox(height: 20.0),


              TextFormField(
                controller: confirmPasswordController,
                obscureText: !_showConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Repetir Contraseña",
                  icon: const Icon(Icons.lock),
                  hintText: "Repite tu contraseña",
                  suffixIcon: GestureDetector(
                    onTap: () => setState(
                        () => _showConfirmPassword = !_showConfirmPassword),
                    child: Icon(_showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                validator: (value) =>
                    validatedPassword(passwordController.text, value),
              ),
              const SizedBox(height: 40.0),


              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final signupEntity = SignUpEntity(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      imageUrl: imageUrlController.text,
                    );
                    context
                        .read<SignUpBloc>()
                        .add(SubmitSignUpEvent(signupEntity: signupEntity));
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text("Registrarse", textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 20.0),


              TextButton(
                onPressed: () => GoRouter.of(context).pushNamed("login"),
                child: const Text("¿Ya tienes una cuenta? Inicia sesión aquí"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
