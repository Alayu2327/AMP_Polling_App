import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polling_app/application_states/bloc/login/login_bloc.dart';
import 'package:polling_app/application_states/bloc/register/register_bloc.dart';
import 'package:polling_app/bloc_observer.dart';
import 'package:polling_app/data_provider/Auth/authentication.dart';
import 'package:polling_app/repository/authenticationRepository.dart';
import 'package:polling_app/routes/routes.dart';

void main() {
  Bloc.observer = MyObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(
              authenticationRepository: AuthenticationRepository(
                  authenticationDataProvider: AuthenticationDataProvider())),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Roboto', primarySwatch: Colors.teal),
        debugShowCheckedModeBanner: false,
        title: "Polling App",
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
