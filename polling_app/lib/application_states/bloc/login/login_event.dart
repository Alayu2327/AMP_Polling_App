import 'package:equatable/equatable.dart';
import 'package:polling_app/models/login.dart';
import 'package:polling_app/models/model.dart';
// import 'package:frontend/Models/User.dart';


class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogingUserEvent extends LoginEvent {
 
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends LoginEvent {}

// ignore: must_be_immutable
class DeleteUserEvent extends LoginEvent {
  

  @override
  List<Object?> get props => [];
}
