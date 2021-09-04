import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polling_app/application_states/bloc/login/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LogingUserEvent) {
      yield Loging();
    }
    if (event is LogoutEvent) {
      yield Logedin();
    }

    if (event is DeleteUserEvent) {}
  }
}
