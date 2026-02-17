import 'package:advanced/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:advanced/login.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Color login = Colors.white;
  Color register = Colors.white;
  bool loginactive = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authstatechange => firebaseAuth.authStateChanges();
  final formkey = GlobalKey<FormState>();
  bool loading = false;
  bool isobscure = true;

  void signup() {
    setState(() {
      loading = true;
    });
    firebaseAuth
        .createUserWithEmailAndPassword(
          email: email.text.toString(),
          password: password.text.toString(),
        )
        .then((value) {
          setState(() {
            loading = false;
          });
        })
        .onError((error, stackTrace) {
          Toast1().msg(error.toString());
          setState(() {
            loading = false;
          });
        });

    // setState(() {
    //   email.clear();
    //   password.clear();
    //   confirmpass.clear();
    //   fullname.clear();
    // });
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
              height: 550,
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
                            //  shadowColor: Colors.grey.shade400,
                            //  elevation: 6,
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
                            //  shadowColor: Colors.grey.shade400,
                            //  elevation: 6,
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
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Fullname";
                              }
                              return null;
                            },
                            controller: fullname,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "FULL NAME",
                              prefixIcon: Icon(Icons.person),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Email";
                              }
                              return null;
                            },
                            controller: email,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "EMAIL",
                              prefixIcon: Icon(Icons.email),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: isobscure,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              }
                              return null;
                            },
                            controller: password,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "PASSWORD",
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
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: isobscure,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter again password";
                              }
                              return null;
                            },
                            controller: confirmpass,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "CONFIRM PASSWORD",
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
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
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
                          signup();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.grey.shade400,
                        minimumSize: Size(double.infinity, 40),
                        elevation: 6,
                      ),
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
                                Icon(
                                  Icons.person_add_sharp,
                                  color: Colors.black,
                                ),
                                Text(
                                  " Register",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Or Continue with "),
                    const SizedBox(height: 15),
                    const Row(
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
                          child: Text(
                            "@",
                            style: TextStyle(color: Colors.blue),
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
