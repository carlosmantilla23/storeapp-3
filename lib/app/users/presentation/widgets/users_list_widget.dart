import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/users/presentation/bloc/user_bloc.dart';
import 'package:storeapp/app/users/presentation/bloc/user_event.dart';
import 'package:storeapp/app/users/presentation/bloc/user_state.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class UsersListWidget extends StatefulWidget {
  const UsersListWidget({super.key});

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<UserBloc>();
    bloc.add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          switch (state) {
            case UserErrorState():
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.message),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        bloc.add(GetUsersEvent());
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          switch (state) {
            case UserLoadingState():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20.0),
                    const Text("Cargando usuarios..."),
                  ],
                ),
              );
            case UserEmptyState():
              return const Center(child: Text("No se encontraron usuarios"));
            case UserLoadedState():
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) =>
                    UserItemWidget(state.users[index]),
              );
            default:
              return const Center(child: Text("Error al obtener usuarios"));
          }
        },
      ),
    );
  }
}

class UserItemWidget extends StatelessWidget {
  final UserEntity user;
  const UserItemWidget(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                user.imageUrl,
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
