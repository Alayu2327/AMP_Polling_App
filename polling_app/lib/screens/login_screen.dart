import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {

  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<LogInScreen> {
  bool _obsecure = true;
  final emailTextController = TextEditingController();

  final passwordTextController = TextEditingController();

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
                        "Sign In",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15, color: Colors.teal),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: emailTextController,
                    decoration: textFieldDecoration.copyWith(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.teal),
                      hintStyle: TextStyle(color: Colors.teal),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? email) {
                      if (email == null) return null;

                      if (!email.contains('@')) {
                        return 'Invalid email, updated';
                      }

                      return null;
                    },
                    onChanged: (String email) {},
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: passwordTextController,
                    obscureText: _obsecure,
                    textInputAction: TextInputAction.done,
                    decoration: textFieldDecoration.copyWith(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.teal),
                        hintStyle: TextStyle(color: Colors.teal),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obsecure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obsecure = !_obsecure;
                            });
                          },
                        )),
                    validator: (String? pass) {
                      if (pass == null) return null;

                      if (pass.length < 8) {
                        return 'Password too short';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      final formValid = formKey.currentState?.validate();

                      if (!formValid!) {
                        print("form is invalid");
                        return;
                      }

                      final email = emailTextController.text;

                      final password = passwordTextController.text;
                      print(email);
                      print(password);
                     
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.teal),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
