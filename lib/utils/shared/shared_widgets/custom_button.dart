import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String title;
  Color? bgColor, textColor;
  final VoidCallback onPressed;

  CustomButton({
    Key? key,
    required this.title,
    this.bgColor,
    this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        textColor: textColor,
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: styleSemiBold,
        ),
      ),
    );
  }
}
