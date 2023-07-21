import 'package:event_management_system/authentication/repository/auth_repository.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/auth_background.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_password_field.dart';
import 'package:event_management_system/utils/shared/shared_widgets/cutom_text_field.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:event_management_system/authentication/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  final utils = Utils();
  final authRepo = AuthRepository();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
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
                vertical: height * .18,
                horizontal: 30,
              ),
              child: Card(
                elevation: 5.0,
                shadowColor: Colors.grey.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Let's get started",
                          style: styleBold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomTextField(
                          hint: "First Name*",
                          controller: firstNameController,
                          icon: const Icon(
                            Icons.person,
                            size: 18,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomTextField(
                          hint: "Last Name*",
                          controller: lastNameController,
                          icon: const Icon(
                            Icons.person,
                            size: 18,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomTextField(
                          hint: "Email*",
                          controller: emailController,
                          icon: const Icon(
                            Icons.mail,
                            size: 18,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomPasswordField(
                          hint: "Password*",
                          controller: passwordController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomPasswordField(
                          hint: "Confirm Password*",
                          controller: retypePasswordController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                        child: CustomButton(
                          title: 'Sign Up',
                          bgColor: counterCyan,
                          textColor: white,
                          onPressed: () async {
                            if (passwordController.text !=
                                retypePasswordController.text) {
                              utils.showSnackBar(
                                context: context,
                                content: "Passwords do not match!",
                              );
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text)) {
                              utils.showSnackBar(
                                context: context,
                                content: "Please enter a valid email!",
                              );
                            } else {
                              String result = '';
                              result = await authRepo.signupWithEmail(
                                emailController.text,
                                passwordController.text,
                                firstNameController.text,
                                lastNameController.text,
                              );
                              if (result == 'success') {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a user?',
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                (context),
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: activeCyan,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
