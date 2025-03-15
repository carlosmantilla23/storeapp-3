import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/home/presentation/widgets/products_list_widget.dart';
import 'package:storeapp/app/users/presentation/widgets/users_list_widget.dart';
import 'package:storeapp/app/users/presentation/bloc/user_bloc.dart';
import 'package:storeapp/app/users/presentation/bloc/user_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/di/dependecy_injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ProductsListWidget(),
    const UsersListWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: DependencyInjection.serviceLocator.get<HomeBloc>()
            ..add(GetProductsEvent()),
        ),
        BlocProvider(
          create: (_) => DependencyInjection.serviceLocator.get<UserBloc>()
            ..add(GetUsersEvent()),
        ),
      ],
      child: Builder(builder: (context) {
        final homeBloc = context.read<HomeBloc>();
        return WillPopScope(
          onWillPop: () async {
            if (_selectedIndex == 1) {
              setState(() {
                _selectedIndex = 0;
              });
              return false; 
            }
            return true; 
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "StoreApp",
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_selectedIndex == 1) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _selectedIndex == 1 ? Colors.yellow : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = (_selectedIndex == 0) ? 1 : 0;
                    });
                  },
                ),
                InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Cerrar Sesión'),
                      content:
                          const Text("¿Estás seguro de cerrar la sesión?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            homeBloc.add(LogoutEvent());
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, 'Cancelar'),
                          child: const Text('Cancelar'),
                        ),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 18.0),
              ],
              backgroundColor: Colors.purple,
            ),
            body: _screens[_selectedIndex],
          ),
        );
      }),
    );
  }
}
