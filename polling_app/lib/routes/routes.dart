import 'package:flutter/material.dart';
import 'package:polling_app/models/polling.dart';
import 'package:polling_app/screens/changepassword_screen.dart';
import 'package:polling_app/screens/detail_screen.dart';
import 'package:polling_app/screens/screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => LogInScreen());
      case '/register':
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case '/home':
        return MaterialPageRoute(
          builder: (context) {
            PollingArgumet args = settings.arguments as PollingArgumet;
            return HomeScreen(args);
          },
        );

      case '/detail':
        return MaterialPageRoute(
          builder: (context) {
            Polling args = settings.arguments as Polling;
            return DetailScreen(args);
          },
        );
      case '/addpolling':
        return MaterialPageRoute(builder: (context) => AddPollingScreen());
      case '/changepassword':
        return MaterialPageRoute(builder: (context) => ChangePasswordScreen());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class PollingArgumet {
  int? id;
  String? title;
  String? description;
  String? options;

  DateTime? startDate;
  DateTime? finalDate;
  PollingArgumet(this.id, this.title, this.description, this.options,this.startDate,this.finalDate);
}
