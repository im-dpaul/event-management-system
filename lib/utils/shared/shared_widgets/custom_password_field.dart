import 'package:event_management_system/authentication/providers/password_field_provider.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomPasswordField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;

  const CustomPasswordField({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordFieldProvider = Provider.of<PasswordFieldProvider>(context);

    return TextFormField(
      cursorColor: activeCyan,
      style: styleRegular,
      autofocus: false,
      controller: controller,
      obscureText: (hint == "Password*")
          ? passwordFieldProvider.isPasswordObscure
          : passwordFieldProvider.isConfirmPasswordObscure,
      onSaved: (value) {
        controller!.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.vpn_key,
          size: 18,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        hintText: hint,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        hintStyle: styleLight,
        suffixIcon: InkWell(
          onTap: () {
            (hint == "Password*")
                ? passwordFieldProvider.setPasswordVisibility()
                : passwordFieldProvider.setConfirmPasswordVisibility();
          },
          child: Icon(
            (hint == "Password*" && passwordFieldProvider.isPasswordObscure)
                ? Icons.visibility_off
                : (hint == "Confirm Password*" &&
                        passwordFieldProvider.isConfirmPasswordObscure)
                    ? Icons.visibility_off
                    : Icons.visibility,
          ),
        ),
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
