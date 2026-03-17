import 'package:advanced/utils/style.dart';
import 'package:advanced/utils/toast.dart';
import 'package:advanced/Authentication/phone_verfication/verify_phone.dart';
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
    setState(() {
      loading = true;
      auth.verifyPhoneNumber(
        phoneNumber: phone.text,

        verificationCompleted: (_) {
          setState(() {
            loading = false;
          });
        },
        verificationFailed: (e) {
          setState(() {
            loading = false;
          });
          Toast1().msg(e.toString());
        },
        codeSent: (String verificationid, int? token) {
          setState(() {
            loading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyPhone(verficationid: verificationid),
            ),
          );
        },
        codeAutoRetrievalTimeout: (e) {
          setState(() {
            loading = false;
          });
          Toast1().msg(e.toString());
        },
      );
    });
  }

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F3F6),
        title: Text("Phone Authentication"),
        centerTitle: true,
        //automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFFF1F3F6),

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
                if (form.currentState!.validate()) {
                  signinwithphone();
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
                        Icon(Icons.person_add_sharp, color: Colors.black),
                        SizedBox(width: 10),
                        Text("Continue", style: TextStyle(color: Colors.black)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
