import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

class UsersListWidget extends StatefulWidget {
  const UsersListWidget({super.key});

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://storeapp-3e889-default-rtdb.firebaseio.com/users.json";

  List<UserDataModel> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await _dio.get(_baseUrl);
      if (response.data != null) {
        setState(() {
          users = response.data.entries
              .map<UserDataModel>(
                  (entry) => UserDataModel.fromJson(entry.value, entry.key))
              .toList();
        });
      }
    } catch (e) {
      print("Error al obtener usuarios: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? const Center(child: Text("No existen usuarios registrados"))
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: user.imageUrl.isNotEmpty
                      ? NetworkImage(user.imageUrl)
                      : null,
                  child:
                      user.imageUrl.isEmpty ? const Icon(Icons.person) : null,
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
  }
}
