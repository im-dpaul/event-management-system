import 'package:event_management_system/admin/views/admin_home_screen.dart';
import 'package:event_management_system/authentication/providers/authentication_provider.dart';
import 'package:event_management_system/authentication/repository/auth_repository.dart';
import 'package:event_management_system/authentication/views/forgot_password_screen.dart';
import 'package:event_management_system/authentication/views/mobile_login_screen.dart';
import 'package:event_management_system/main.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/auth_background.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_password_field.dart';
import 'package:event_management_system/utils/shared/shared_widgets/cutom_text_field.dart';
import 'package:event_management_system/utils/shared/shared_widgets/loading.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:event_management_system/authentication/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final utils = Utils();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final authRepo = AuthRepository();
    return Scaffold(
      extendBody: true,
      body: loadingProvider.isLoading
          ? const Loading()
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                children: [
                  const AuthBackground(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * .15,
                      horizontal: 30,
                    ),
                    child: Card(
                      elevation: 5.0,
                      shadowColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "Let's continue",
                                style: styleBold,
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                55,
                                height * 0.05,
                                55,
                                0,
                              ),
                              child: CustomButton(
                                title: 'Login',
                                bgColor: counterCyan,
                                textColor: Colors.white,
                                onPressed: () async {
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text)) {
                                    utils.showSnackBar(
                                      context: context,
                                      content: "Please enter a valid email!",
                                    );
                                  } else if (passwordController.text.length <
                                      6) {
                                    utils.showSnackBar(
                                      context: context,
                                      content: 'Please enter a valid password',
                                    );
                                  } else {
                                    loadingProvider.setLoading(true);
                                    String result = '';
                                    result = await authRepo.loginWithEmail(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                    loadingProvider.setLoading(false);
                                    if (result == 'success') {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              (role == 'ADMIN')
                                                  ? const AdminHome()
                                                  : const Dashboard(),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: GoogleFonts.openSans(
                                      color: activeCyan,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 30,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 2,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'OR Continue with',
                                      style: styleLight,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 2,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: IntlPhoneField(
                                autofocus: false,
                                cursorColor: activeCyan,
                                initialCountryCode: 'IN',
                                dropdownIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: activeCyan,
                                ),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MobileLoginScreen(),
                                    ),
                                  );
                                },
                                //autofocus: true,
                                style: styleRegular,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  hintStyle: styleLight,
                                  labelStyle: const TextStyle(
                                    color: activeCyan,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: activeCyan,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: activeCyan,
                                    ),
                                  ),
                                ),
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },
                                onCountryChanged: (country) {
                                  print('Country changed to: ' + country.name);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
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
