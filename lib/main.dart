import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/edit_category_screen.dart';

import 'providers/auth_provider.dart';
import 'providers/category_provider.dart';
import 'ui/screens/auth_screen.dart';
import 'ui/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CategoryProvider>(
          create: (ctx) => CategoryProvider(),
          update: (ctx, auth, previousCategories) =>
              previousCategories!..setParams(auth.token),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authData, child) {
          return MaterialApp(
            title: 'Wallet',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: authData.isAuth
                ? const MainScreen()
                : FutureBuilder(
                    future: authData.autoLogin(),
                    builder: (c, autoLoginData) {
                      if (autoLoginData.connectionState ==
                          ConnectionState.waiting) {
                        return const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return const AuthScreen();
                      }
                    },
                  ),
            routes: {
              MainScreen.routeName: (ctx) => const MainScreen(),
              AuthScreen.routeName: (ctx) => const AuthScreen(),
              EditCategoryScreen.routeName: (ctx) => const EditCategoryScreen(),
            },
          );
        },
      ),
    );
  }
}
