import 'package:equatable/equatable.dart';
import 'package:polling_app/models/User.dart';


// import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisteringUser extends RegisterEvent {
  final User user;

  RegisteringUser(this.user);
  @override
  List<Object?> get props => [user];
}
