import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/modules/shop_login.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orange.shade100,
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,

      ),
      home: ShopLoginScreen(),
    );
  }
}

