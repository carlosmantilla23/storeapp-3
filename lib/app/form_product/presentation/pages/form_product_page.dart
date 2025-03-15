import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependecy_injection.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_event.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_state.dart';
import 'package:storeapp/app/login/presentation/pages/login_mixin.dart';

class FormProductPage extends StatelessWidget {
  final String? id;
  const FormProductPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<FormProductBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            id == null ? "Agregar Producto" : "Actualizar Producto",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: Column(
          children: [
            BodyLoginWidget(id),
          ],
        ),
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget(this.id, {super.key});
  final String? id;

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormProductBloc>();
    if (widget.id != null) {
      bloc.add(GetProductEvent(widget.id!));
    }
    TextEditingController nameField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    TextEditingController urlField = TextEditingController();

    return BlocListener<FormProductBloc, FormProductState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            break;
          case SubmitErrorState():
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
                    ));
            break;
        }
      },
      child: BlocBuilder<FormProductBloc, FormProductState>(
        builder: (context, state) {
          nameField.text = state.model.name;
          priceField.text = state.model.price;
          urlField.text = state.model.urlImage;

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    Text(state.model.name),
                    TextFormField(
                      controller: nameField,
                      onChanged: (value) =>
                          bloc.add(NameChangedEvent(name: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Nombre Producto:",
                        icon: Icon(Icons.card_giftcard),
                        hintText: "Escriba el nombre del producto",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      controller: urlField,
                      onChanged: (value) =>
                          bloc.add(UrlImageChangedEvent(urlImage: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Url:",
                        icon: Icon(Icons.image),
                        hintText: "Escriba la url del producto",
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      controller: priceField,
                      onChanged: (value) =>
                          bloc.add(PriceChangedEvent(price: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Precio:",
                        icon: Icon(Icons.attach_money),
                        hintText: "Escriba el precio del producto",
                      ),
                    ),
                    SizedBox(height: 48.0),
                    FilledButton(
                      onPressed: () => {bloc.add(SubmitEvent())},
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(widget.id == null ? "Crear" : "Actualizar",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
