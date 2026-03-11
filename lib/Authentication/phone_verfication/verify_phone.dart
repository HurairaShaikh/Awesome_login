import 'package:advanced/local/home.dart';
import 'package:advanced/utils/style.dart';
import 'package:advanced/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  final String verficationid;
  const VerifyPhone({super.key, required this.verficationid});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final auth = FirebaseAuth.instance;
  TextEditingController verifycode = TextEditingController();
  bool loading = false;
  final form = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F3F6),
        title: Text("Verify Phone Number"),
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
                    return "Enter code";
                  }
                  return null;
                },
                controller: verifycode,
                keyboardType: TextInputType.number,
                decoration: inputDecoration("6-digit Code", Icon(Icons.phone)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                if (form.currentState!.validate()) {
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verficationid,
                    smsCode: verifycode.text,
                  );
                  try {
                    await auth.signInWithCredential(credential);
                    setState(() {
                      loading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Toast1().msg(e.toString());
                  }
                }
               
              },
              style: Style().style,
              child:
                  loading
                      ? Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            backgroundColor: Colors.white,
                            color: Colors.blue,
                          ),
                        )
                      :
                  Row(
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
