import 'package:flutter/material.dart';

class PatientProfile extends StatelessWidget {
  PatientProfile({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(id),
    );
  }
}
