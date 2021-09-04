import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polling_app/models/model.dart';
import 'package:polling_app/repository/authenticationRepository.dart';
import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authenticationRepository})
      : super(RegisterState());
  AuthenticationRepository authenticationRepository;

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisteringUser) {
      yield Registering();

      // final user = event.user;
      // await authenticationRepository.register(user);
      try {
        final user = event.user;
        User newuser = await authenticationRepository.register(user);
        print(newuser.tojson());
        var response = newuser.tojson();
        if (response['emailAddress'] == '') {
          yield FailedToRegister();
        } else if (response['emailAddress'] != '') {
          yield Registered(newuser);
        }
      } catch (e) {
        yield FailedToRegister();
      }
    }
  }
}
