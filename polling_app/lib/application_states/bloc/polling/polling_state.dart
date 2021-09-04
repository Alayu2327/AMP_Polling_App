

import 'package:equatable/equatable.dart';

abstract class PollingState extends Equatable {
  const PollingState();
  
  @override
  List<Object> get props => [];
}

class PollingInitial extends PollingState {}
