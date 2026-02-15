import 'package:advanced/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //  // Splash splash = Splash();
  //   @override
  //   void initState() {
  //     super.initState();
  //     splash.splash(context);
  //   }
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authstatechange => firebaseAuth.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Logged in page"),
        leading: IconButton(
          onPressed: () {
            firebaseAuth.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: Center(
        child: Text(
          currentUser!.displayName.toString() +
              "\n" +
              currentUser!.email.toString(),
        ),
      ),
    );
  }
}
