import 'package:polling_app/models/polling.dart';

class PollingDataProvider {

  List<Polling> _polling = [];
  Future<Polling> createPolling(Polling polling) async {
     _polling.add(polling);
     return polling;
    
  }

  Future<List<Polling>> fetchAllPolling() async {
    return _polling;
  }

  Future<List<Polling>> deletePolling(int id) async{

    return _polling;
  }


}
