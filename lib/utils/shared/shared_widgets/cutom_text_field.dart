import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool? enabled;
  final String hint;
  final TextEditingController controller;
  final Icon? icon;
  final TextInputType keyboardType;
  final int? lines;

  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.icon,
    required this.keyboardType,
    this.lines,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: styleRegular,
      cursorColor: activeCyan,
      autofocus: false,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLines: (lines == null) ? 1 : lines,
      onSaved: (value) {
        controller.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: icon,
        prefixIconColor: Colors.grey,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        hintText: hint,
        labelStyle: const TextStyle(
          color: activeCyan,
        ),
        hintStyle: styleLight,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: activeCyan,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
