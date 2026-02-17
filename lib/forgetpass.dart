import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(children: [
        ElevatedButton(onPressed: (){
          
        }, child: Text("data")),

        ],
      ),
    );
  }
}
