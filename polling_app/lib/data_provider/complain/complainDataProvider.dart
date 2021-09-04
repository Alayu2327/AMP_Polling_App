import 'package:polling_app/models/model.dart';
import 'package:polling_app/models/complain.dart';

class ComplainDataProvider {

  List<Complain> _complain = [];
  Future<Complain> createComplain(Complain complain) async {
     _complain.add(complain);
     return complain;
    
  }

  Future<List<Complain>> fetchAllComplain() async {
    return _complain;
  }

  Future<List<Complain>> deleteComplain(int id) async{

    return _complain;
  }


}
