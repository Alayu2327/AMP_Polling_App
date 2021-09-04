
import 'package:polling_app/data_provider/Polling/pollingDataProvider.dart';
import 'package:polling_app/models/polling.dart';

class PollingRepository {
  final PollingDataProvider pollingDataProvider;
  PollingRepository(this.pollingDataProvider);

  Future<Polling> createPolling(Polling polling) async {
    return this.pollingDataProvider.createPolling(polling);
  }


  Future<List<Polling>> fetchAllPolling() async {
    return this.pollingDataProvider.fetchAllPolling();
  }


 Future<List<Polling>> deletePolling(int id) async {
    return this.pollingDataProvider.deletePolling(id);
  }
  
}
