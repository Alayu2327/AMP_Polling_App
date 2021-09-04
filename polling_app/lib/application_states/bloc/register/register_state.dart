import 'package:equatable/equatable.dart';
import 'package:polling_app/models/User.dart';


class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Registering extends RegisterState {}

class FailedToRegister extends RegisterState {}

class Registered extends RegisterState {

  final User registeredUser;
  Registered(this.registeredUser);
  @override
  List<Object?> get props => [registeredUser];
  
}
