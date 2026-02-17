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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Phone Authentication"),
      ),
      backgroundColor: Colors.lightGreen,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phone,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                isDense: true,
                filled: true,
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
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   loading = false;
                // });
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
