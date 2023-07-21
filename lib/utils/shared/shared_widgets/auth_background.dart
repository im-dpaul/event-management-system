import 'package:event_management_system/utils/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: activeCyan,
            spreadRadius: 3,
          ),
        ],
      ),
    );
  }
}
