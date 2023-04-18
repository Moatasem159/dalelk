import 'package:dalilk/bloc_observer.dart';
import 'package:dalilk/cubit/category_cubit.dart';
import 'package:dalilk/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer=AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) =>CategoryCubit() ,
      child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
    );
  }
}