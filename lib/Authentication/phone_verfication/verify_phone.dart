import 'package:advanced/utils/style.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  final String verficationid;
  const VerifyPhone({super.key, required this.verficationid});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
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
                  auth.verifyPhoneNumber(
                    phoneNumber: phone.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      Toast1().msg(e.toString());
                    },
                    codeSent: (String verificationid, int? token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VerifyPhone(verficationid: verificationid),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Toast1().msg(e.toString());
                    },
                  );
                }
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
