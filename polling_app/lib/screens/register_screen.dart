import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polling_app/application_states/bloc/register/register.dart';
import 'package:polling_app/application_states/bloc/register/register_bloc.dart';
import 'package:polling_app/data_provider/Auth/authentication.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:polling_app/application_states/bloc/register/register_bloc.dart';
// import 'package:polling_app/application_states/bloc/register/register_event.dart';
// import 'package:polling_app/application_states/bloc/register/register_state.dart';
import 'package:polling_app/models/model.dart';
import 'package:polling_app/repository/authenticationRepository.dart';

class RegisterController extends StatelessWidget {
  const RegisterController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authenticationRepository = AuthenticationRepository(
        authenticationDataProvider: AuthenticationDataProvider());
    return BlocProvider<RegisterBloc>(
      create: (_) =>
          RegisterBloc(authenticationRepository: authenticationRepository),
      child: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmTextController = TextEditingController();
  final phoneTextController = TextEditingController();

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
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Text(
                      "Create an account, It's free ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: nameTextController,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: textFieldDecoration.copyWith(hintText: "Name"),
                  validator: (String? name) {
                    if (name == null) return null;

                    if (name.length < 8) {
                      return 'Name is too short';
                    }
                    return null;
                  },
                  onChanged: (String email) {},
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: phoneTextController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration:
                      textFieldDecoration.copyWith(hintText: "Phone Number"),
                  validator: (String? phone) {
                    if (phone == null) return null;

                    if (phone.length < 8) {
                      return 'Phone is too short';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: emailTextController,
                  decoration: textFieldDecoration.copyWith(hintText: "Email"),
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
                SizedBox(height: 15.0),
                TextFormField(
                  controller: passwordTextController,
                  decoration:
                      textFieldDecoration.copyWith(hintText: "Password"),
                  textInputAction: TextInputAction.next,
                  validator: (String? pass) {
                    if (pass == null) return null;

                    if (pass.length < 8) {
                      return 'Password too short';
                    }

                    return null;
                  },
                  onChanged: (String email) {},
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: confirmTextController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: textFieldDecoration.copyWith(
                      hintText: "Confirm Password"),
                  validator: (String? pass) {
                    if (pass == null) return null;

                    if (pass.length < 8) {
                      return 'Password too short';
                    }
                    if (pass != passwordTextController.text) {
                      return 'Password Not Match';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () async {
                    final formValid = formKey.currentState?.validate();

                    if (!formValid!) {
                      print("form is invalid");
                      return;
                    }

                    User newuser = User(
                        username: nameTextController.text.toString(),
                        phone_number: phoneTextController.text.toString(),
                        email: emailTextController.text,
                        password: passwordTextController.text,
                        password_confirm: confirmTextController.text);

                    RegisterEvent registerEvent = RegisteringUser(newuser);
                    BlocProvider.of<RegisterBloc>(context).add(registerEvent);

                    // final user = User(
                    //     nameTextController.text,
                    //     phoneTextController.text,
                    //     emailTextController.text,
                    //     passwordTextController.text,
                    //     confirmTextController.text);

                    //     print(user.username);
                    // _register.add(RegisteringUser(user));
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
                      "Register",
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
                    Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        " Log In",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    )
                  ],
                ),
                BlocBuilder<RegisterBloc, RegisterState>(builder: (_, state) {
                  if (state is Registering) {
                    return Text("waiting");
                  }
                  if (state is Registered) {
                    return Text("You have successfully Registered!");
                  }
                  if (state is FailedToRegister) {
                    return Text("Failed!");
                  }
                  return Text("");
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
