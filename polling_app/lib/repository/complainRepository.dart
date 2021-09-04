import 'package:polling_app/data_provider/complain/complainDataProvider.dart';
import 'package:polling_app/models/model.dart';

class PollingRepository {
  final ComplainDataProvider complainDataProvider;
  PollingRepository(this.complainDataProvider);

  Future<Complain> createComplain(Complain complain) async {
    return this.complainDataProvider.createComplain(complain);
  }


  Future<List<Complain>> fetchAllComplain() async {
    return this.complainDataProvider.fetchAllComplain();
  }


 Future<List<Complain>> deleteComplain(int id) async {
    return this.complainDataProvider.deleteComplain(id);
  }
  
}
