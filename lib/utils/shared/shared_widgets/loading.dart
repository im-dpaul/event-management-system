import 'package:event_management_system/utils/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitDualRing(
        lineWidth: 2,
        color: counterCyan,
      ),
    );
  }
}
