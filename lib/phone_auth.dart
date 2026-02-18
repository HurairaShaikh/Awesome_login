import 'package:advanced/utils/style.dart';
import 'package:advanced/utils/toast.dart';
import 'package:advanced/verify_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  final auth = FirebaseAuth.instance;
  TextEditingController phone = TextEditingController();
  bool loading = false;
  InputDecoration inputDecoration(String hint, Widget icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      isDense: true,
      filled: true,
      prefixIcon: icon,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
      ),
    );
  }

  void signinwithphone() {
    auth.verifyPhoneNumber(
      phoneNumber: phone.text,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {
        Toast1().msg(error.toString());
      },
      codeSent: (String verificationId, int? token) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyPhone(verficationid: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (error) {
        Toast1().msg(error.toString());
      },
    );
  }

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Phone Authentication"),
      ),
      backgroundColor: Colors.pink[100],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: form,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Number";
                  }
                  return null;
                },
                controller: phone,
                keyboardType: TextInputType.number,
                decoration: inputDecoration(
                  "Enter Phone Number",
                  Icon(Icons.phone),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (form.currentState!.validate()) {}
                // setState(() {
                //   loading = false;
                // });
              },
              style: Style().style,
              child:
                  // loading
                  //     ? Transform.scale(
                  //         scale: 0.5,
                  //         child: CircularProgressIndicator(
                  //           strokeWidth: 5,
                  //           backgroundColor: Colors.white,
                  //           color: Colors.blue,
                  //         ),
                  //       )
                  //     :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add_sharp, color: Colors.black),
                      SizedBox(width: 10),
                      Text("Login ", style: TextStyle(color: Colors.black)),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
