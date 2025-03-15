import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(routes: [
      GoRoute(
        path: "/login",
        builder: (_, __) => LoginPage(),
        name: "login",
        redirect: (context, state) async {
          final prefs = await SharedPreferences.getInstance();
          final bool authenticated = prefs.getBool("isLoggedIn") ?? false;
          print("Estado de sesión en SharedPreferences: $authenticated");
          if (authenticated) {
            return "/";
          }
          return null;

        },
      ),
      GoRoute(
          path: "/sign-up", builder: (_, __) => SignUpPage(), name: "sign-up"),
      GoRoute(
        path: "/",
        builder: (_, __) => HomePage(),
        name: "home",

        redirect: (context, state) async {
          final prefs = await SharedPreferences.getInstance();
          final bool authenticated = prefs.getBool("isLoggedIn") ?? false;
          print(
              "Estado de sesión home en SharedPreferences: $authenticated");
          if (!authenticated) {
            return "/login";
          }
          return null;
        },
      ),
      GoRoute(
          path: "/form-product",
          builder: (_, __) => FormProductPage(),
          name: "form-product"),
      GoRoute(
          path: "/form-product/:id",
          builder: (_, state) => FormProductPage(
                id: state.pathParameters["id"],
              ),
          name: "form-product-u"),
    ]);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestStateful extends StatefulWidget {
  @override
  State<TestStateful> createState() => TestStatefulState();
}

class TestStatefulState extends State<TestStateful> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
