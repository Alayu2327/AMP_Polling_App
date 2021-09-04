

import 'package:bloc/bloc.dart';
import 'package:polling_app/application_states/bloc/polling/polling.dart';


class PollingBloc extends Bloc<PollingEvent, PollingState> {
  PollingBloc() : super(PollingInitial());

  @override
  Stream<PollingState> mapEventToState(
    PollingEvent event,
  ) async* {
    
  }
}
