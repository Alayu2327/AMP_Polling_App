import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<ChangePasswordScreen> {
  
  final oldPasswordController = TextEditingController();

  final newpasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: <Widget>[
                      Text(
                        "Change Password",
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: oldPasswordController,
                    decoration: textFieldDecoration.copyWith(
                      labelText: "Old Password",
                      labelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? oldpassword) {
                      if (oldpassword == null) return null;

                

                      return null;
                    },
                    onChanged: (String oldpassword) {},
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: oldPasswordController,
                    decoration: textFieldDecoration.copyWith(
                      labelText: "new Password",
                      labelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? oldpassword) {
                      if (oldpassword == null) return null;

                

                      return null;
                    },
                    onChanged: (String oldpassword) {},
                  ),
          
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      final formValid = formKey.currentState?.validate();

                      if (!formValid!) {
                        print("form is invalid");
                        return;
                      }

                      final oldpassword = oldPasswordController.text;

                      final newpassword = newpasswordController.text;
                      print(oldpassword);
                      print(newpassword);
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
