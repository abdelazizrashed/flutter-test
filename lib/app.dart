import 'package:evaluation_project/logic/bloc/auth/auth_bloc.dart';
import 'package:evaluation_project/logic/bloc/home/home_bloc.dart';
import 'package:evaluation_project/logic/bloc/product/product_bloc.dart';
import 'package:evaluation_project/logic/core/app_router.dart';
import 'package:evaluation_project/logic/repositories/auth/auth_repository.dart';
import 'package:evaluation_project/logic/repositories/home/home_repository.dart';
import 'package:evaluation_project/logic/repositories/product/product_repository.dart';
import 'package:evaluation_project/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            repository: HomeRepository.get(),
          )..add(GetHomeDataEvent()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            repository: ProductRepository.get(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            repository: AuthRepository.get(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
