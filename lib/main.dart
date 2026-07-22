import 'package:flutter/material.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_cubit.dart';
import 'package:news_app/pages/on_boarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNewsCubit(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: OnBoarding()),
    );
  }
}
