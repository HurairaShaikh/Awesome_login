import 'package:advanced/phone_auth.dart';
import 'package:advanced/local/home.dart';
import 'package:advanced/utils/style.dart';
import 'package:advanced/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:advanced/register.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color login = Colors.white;
  Color register = Colors.white;
  bool loginactive = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authstatechange => firebaseAuth.authStateChanges();
  final formkey = GlobalKey<FormState>();
  bool loading = false;
  bool isobscure = true;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.black),
  );

  void loggin() {
    setState(() {
      loading = true;
    });

    firebaseAuth
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
          setState(() {
            loading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        })
        .onError((error, stackTrace) {
          Toast1().msg(error.toString());
          setState(() {
            loading = false;
          });
        });
    setState(() {
      email.clear();
      password.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 450,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loginactive = true;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: loginactive
                                ? Colors.white
                                : const Color(0xFFF1F3F6),
                            foregroundColor: Colors.black,
                            shadowColor: Colors.grey.shade400,
                            elevation: 6,
                          ),
                          child: const Text("Login"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loginactive = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: !loginactive
                                ? Colors.white
                                : const Color(0xFFF1F3F6),
                            foregroundColor: Colors.black,
                            shadowColor: Colors.grey.shade400,
                            elevation: 6,
                          ),
                          child: const Text("Register"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter email";
                              }
                              return null;
                            },
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              isDense: true,
                              filled: true,
                              suffixIcon: Icon(Icons.email),
                              fillColor: Colors.white,
                              border: border,
                              enabledBorder: border,
                              focusedBorder: border,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              }
                              return null;
                            },
                            controller: password,
                            obscureText: isobscure,
                            keyboardType: TextInputType.emailAddress,

                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              isDense: true,
                              filled: true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isobscure = !isobscure;
                                  });
                                },
                                child: isobscure
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                              fillColor: Colors.white,
                              border: border,
                              enabledBorder: border,
                              focusedBorder: border,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          loading = false;
                        });
                        if (formkey.currentState!.validate()) {
                          loggin();
                        }
                      },
                      style: Style().style,
                      child: loading
                          ? Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                backgroundColor: Colors.white,
                                color: Colors.blue,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.key, color: Colors.black),
                                Text(
                                  " LogIn",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Forgetpass()),
                        );
                      },
                      child: const Text("Forgot Your Password?"),
                    ),
                    const SizedBox(height: 15),
                    const Text("OR Continue with"),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            "G",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            "F",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Forgetpass(),
                                ),
                              );
                            },
                            icon: Icon(Icons.phone, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
