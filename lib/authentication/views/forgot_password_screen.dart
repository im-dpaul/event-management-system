import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/auth_background.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/cutom_text_field.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final utils = Utils();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    //final auth = Auth();
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AuthBackground(),
            Positioned(
              height: height * 0.15,
              left: width * 0.02,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: utils.getScreenSize().height * .28,
                horizontal: 30,
              ),
              child: Card(
                elevation: 5.0,
                shadowColor: Colors.grey.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Reset Password",
                        style: styleBold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: CustomTextField(
                        hint: "Email",
                        controller: emailController,
                        icon: const Icon(Icons.mail),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(35),
                      child: CustomButton(
                        title: 'Reset Password',
                        bgColor: counterCyan,
                        textColor: Colors.white,
                        onPressed: () async {
                          // String output = await auth.resetPassword(
                          //     context, emailController.text);
                          // if (output == 'success') {
                          //   Fluttertoast.showToast(
                          //     msg:
                          //         "A link for resetting password was sent to the given email",
                          //     backgroundColor: Colors.grey.shade600,
                          //     textColor: Colors.white,
                          //   );
                          //   Future.delayed(const Duration(milliseconds: 300),
                          //       () {
                          //     Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => const LoginScreen(),
                          //       ),
                          //     );
                          //   });
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
