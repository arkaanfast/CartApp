import 'package:cart_app/screens/cart_screen/cart_screen.dart';
import 'package:cart_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isProcessing = false;
  GlobalKey<FormState> _registerForm = new GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _paswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
            child: Form(
          key: _registerForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                height: 68,
                child: TextFormField(
                  controller: _userNameController,
                  validator: (userName) =>
                      userName!.length == 0 ? "please enter" : null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "User Name",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                height: 68,
                child: TextFormField(
                  controller: _emailController,
                  validator: (email) =>
                      email!.length == 0 ? "please enter" : null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                height: 68,
                child: TextFormField(
                  controller: _paswordController,
                  obscureText: true,
                  validator: (pass) =>
                      pass!.length == 0 ? "please enter" : null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Password",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                height: 68,
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }

                    if (_paswordController.text != value) {
                      return "Passwords dont match";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Confirm Password",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              _isProcessing
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isProcessing = true;
                        });

                        if (_registerForm.currentState!.validate()) {
                          User? user =
                              await AuthService.registerUsingEmailPassword(
                            name: _userNameController.text,
                            email: _emailController.text,
                            password: _paswordController.text,
                          );

                          setState(() {
                            _isProcessing = false;
                          });

                          if (user != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CartScreen(user: user)),
                                ModalRoute.withName("/Cart"));
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
            ],
          ),
        )));
  }
}
