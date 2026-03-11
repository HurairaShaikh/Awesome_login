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
    return Scaffold(body: Center(child: Text("data")));
  }
}
