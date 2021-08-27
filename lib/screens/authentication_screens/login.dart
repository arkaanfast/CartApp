import 'package:cart_app/screens/authentication_screens/register.dart';
import 'package:cart_app/screens/cart_screen/cart_screen.dart';
import 'package:cart_app/services/auth_services.dart';
import 'package:cart_app/services/local_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  bool _isProcessing = false;
  bool _isError = false;
  final _userNameController = TextEditingController();
  final _paswordController = TextEditingController();
  GlobalKey<FormState> _signIn = new GlobalKey<FormState>();
  final snackBar =
      SnackBar(content: Text('ERROR NOT AUTHENTICATED USING BIOMETRICS'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: _getSignInForm(context));
  }

  Widget _getSignInForm(BuildContext context) {
    return FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                child: Form(
              key: _signIn,
              child: _getForm(context),
            ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _getForm(BuildContext context) {
    return Column(
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
              hintText: "Email",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          height: 68,
          child: TextFormField(
            obscureText: true,
            controller: _paswordController,
            validator: (pass) => pass!.length == 0 ? "please enter" : null,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              hintText: "Password",
            ),
          ),
        ),
        _isProcessing
            ? CircularProgressIndicator()
            : GestureDetector(
                onTap: () async {
                  _authenticate();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
        SizedBox(height: 20.0),
        _isError
            ? Container(
                child: Text("Not registred or Wrong credentials",
                    style: TextStyle(color: Colors.red)))
            : Container(),
        _isError ? SizedBox(height: 20.0) : Container(),
        _isProcessing
            ? Container()
            : GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Container(
                  child: Text(
                    "Register here !",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
      ],
    );
  }

  _authenticate() async {
    if (_signIn.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
        _isError = false;
      });
      User? user = await AuthService.signInUsingEmailPassword(
        email: _userNameController.text,
        password: _paswordController.text,
      );
      if (user != null) {
        bool _isAuthDone = await _bioMetricLogin();
        if (_isAuthDone) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CartScreen(user: user)),
              ModalRoute.withName("/Cart"));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            _isError = false;
            _isProcessing = false;
          });
        }
      } else {
        setState(() {
          _isError = true;
          _isProcessing = false;
        });
      }
    }
  }

  Future<bool> _bioMetricLogin() async {
    bool _isSupported = await LocalAuth.isBiometricSupported();
    if (_isSupported) {
      return await LocalAuth.authenticateWithBiometrics();
    } else {
      return false;
    }
  }
}
