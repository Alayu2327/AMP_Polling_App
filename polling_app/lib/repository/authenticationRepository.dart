import 'package:polling_app/data_provider/Auth/authentication.dart';
import 'package:polling_app/models/model.dart';

class AuthenticationRepository {
  //Register Repo
  AuthenticationDataProvider authenticationDataProvider;

  AuthenticationRepository({ required this.authenticationDataProvider});

  Future<User> register(User user) async {
    print("passed to authentication");
    return await authenticationDataProvider.register(user);
  }

  //Delete repo
   Future<void> deleteAccount() async {
    print("Delete User ");
    
  }

  Future<void> login() async {
    print("log in User ");
    
  }
}
