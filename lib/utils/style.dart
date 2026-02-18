import 'package:flutter/material.dart';

class Style {
  final style = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    shadowColor: Colors.grey.shade400,
    minimumSize: Size(double.infinity, 40),
    elevation: 6,
  );
}
