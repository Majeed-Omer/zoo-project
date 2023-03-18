import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo/features/zoo_folder/presentation/Screens/login_screen.dart';
import 'package:zoo/features/zoo_folder/Services/auth_services.dart';
import 'package:zoo/features/zoo_folder/Services/globals.dart';
import 'package:zoo/features/zoo_folder/presentation/Widgets/rounded_button.dart';
import 'package:zoo/features/zoo_folder/presentation/Widgets/wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';
  Map _userObj = {};

  createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (emailValid) {
      http.Response response =
          await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isLoggedIn", true);
        preferences.setString("name", _name);
        preferences.setString("email", _email);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Wrapper(
                email: _email,
                name: _name,
                image:
                    'https://icons-for-free.com/download-icon-man+person+profile+user+worker+icon-1320190557331309792_512.png',
              ),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final f = MediaQuery.of(context).textScaleFactor;

    googleLogin() async {
      print("mom");
      GoogleSignIn _googleSignIn = GoogleSignIn();
      try {
        var user = await _googleSignIn.signIn();

        if (user == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Sign in Failed")));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Wrapper(
                    email: user.email,
                    image: user.photoUrl,
                    name: user.displayName!,
                  )));
        }

        print(user);
      } catch (error) {
        print(error);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Registration',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        toolbarHeight: h / 12,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: 'Name', hintStyle: TextStyle(fontSize: 15)),
                onChanged: (value) {
                  _name = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Email', hintStyle: TextStyle(fontSize: 15)),
                onChanged: (value) {
                  _email = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password', hintStyle: TextStyle(fontSize: 15)),
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              RoundedButton(
                btnText: 'Create Account',
                onBtnPressed: () => createAccountPressed(),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "-----------------------------OR--------------------------------",
                style: TextStyle(fontSize: (w / 70) + (h / 70)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Image.asset('assets/facebook_image.jpg',
                        width: w / 10, height: h / 10),
                    onTap: () {
                      FacebookAuth.instance
                          .login(permissions: ["public_profile", "email"]).then(
                              (value) {
                        FacebookAuth.instance
                            .getUserData()
                            .then((userData) async {
                          setState(() async {
                            _userObj = userData;
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setBool("isLoggedIn", true);
                            preferences.setString("name", _userObj["name"]);
                            preferences.setString("email", _userObj["email"]);
                            preferences.setString(
                                "image", _userObj["picture"]["data"]["url"]);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Wrapper(
                                      email: _userObj["email"],
                                      name: _userObj["name"],
                                      image: _userObj["picture"]["data"]
                                          ["url"]),
                                ));
                          });
                        });
                      });
                    },
                  ),
                  InkWell(
                    child: Image.asset('assets/google_image.png',
                        width: w / 10, height: h / 10),
                    onTap: () {
                      googleLogin();
                    },
                  ),
                  InkWell(
                    child: Image.asset('assets/Instagram_image.jpg',
                        width: w / 10, height: h / 10),
                    onTap: () {
                      print("mom");
                    },
                  ),
                  InkWell(
                    child: Image.asset('assets/twitter_image.png',
                        width: w / 10, height: h / 10),
                    onTap: () {
                      print("mom");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginScreen(),
                      ));
                },
                child: Text(
                  'already have an account',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
