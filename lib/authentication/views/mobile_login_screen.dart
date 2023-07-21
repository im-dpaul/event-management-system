import 'package:event_management_system/authentication/repository/auth_repository.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/auth_background.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:event_management_system/authentication/views/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final mobileController = TextEditingController();
  final otpController = OtpFieldController();
  final utils = Utils();
  int otp = 0;

  @override
  void dispose() {
    super.dispose();
    mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final authRepository = AuthRepository();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (loadingProvider.isLoading)
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
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
                          FocusScope.of(context).unfocus();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * .22,
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
                              padding: EdgeInsets.fromLTRB(
                                55,
                                height * 0.05,
                                55,
                                0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: IntlPhoneField(
                                controller: mobileController,
                                cursorColor: activeCyan,
                                initialCountryCode: 'IN',
                                dropdownIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: activeCyan,
                                ),
                                autofocus: true,
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
                                onSaved: (phone) {
                                  mobileController.text = phone!.completeNumber;
                                },
                                onCountryChanged: (country) {
                                  if (kDebugMode) {
                                    print(
                                      'Country changed to: ' + country.name,
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.15,
                              ),
                              child: CustomButton(
                                title: 'Get OTP',
                                bgColor: counterCyan,
                                textColor: Colors.white,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (mobileController.text == "" ||
                                      mobileController.text.length < 10) {
                                    utils.showSnackBar(
                                      context: context,
                                      content:
                                          "Please enter a valid mobile no.",
                                    );
                                  } else {
                                    String result = 'failed';
                                    result =
                                        await authRepository.signinWithPhone(
                                      mobileController.text.trim(),
                                    );
                                    if (result == 'success') {
                                      // ignore: use_build_context_synchronously
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        elevation: 15,
                                        isDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: SizedBox(
                                              height: height * 0.35,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      splashRadius: 0.1,
                                                      onPressed: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel_outlined,
                                                        size: 22,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.025),
                                                  OTPTextField(
                                                    controller: otpController,
                                                    length: 4,
                                                    width: width * .55,
                                                    fieldWidth: 46,
                                                    style: styleMedium,
                                                    fieldStyle: FieldStyle.box,
                                                    onCompleted: (pin) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      otp = int.parse(pin);
                                                    },
                                                  ),
                                                  const SizedBox(height: 25),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: width * 0.25,
                                                    ),
                                                    child: CustomButton(
                                                      title: 'Verify',
                                                      bgColor: counterCyan,
                                                      textColor: Colors.white,
                                                      onPressed: () async {
                                                        if (otp == 0) {
                                                          utils.showSnackBar(
                                                            context: context,
                                                            content:
                                                                'Please enter otp!',
                                                          );
                                                        } else {
                                                          String result = '';
                                                          result =
                                                              await authRepository
                                                                  .verifyOTP(
                                                            int.parse(
                                                              mobileController
                                                                  .text
                                                                  .trim(),
                                                            ),
                                                            otp,
                                                          );
                                                          if (result ==
                                                              'success') {
                                                            // ignore: use_build_context_synchronously
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const Dashboard(),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Didn\'t receive OTP?',
                                                      ),
                                                      const SizedBox(width: 10),
                                                      GestureDetector(
                                                        child: const Text(
                                                          'Resend',
                                                          style: TextStyle(
                                                            color: counterCyan,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          String result =
                                                              'failed';
                                                          result =
                                                              await authRepository
                                                                  .signinWithPhone(
                                                            mobileController
                                                                .text
                                                                .trim(),
                                                          );
                                                          if (result ==
                                                              'success') {
                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  'OTP sent successfully!',
                                                            );
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                  // ignore: use_build_context_synchronously
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
                                      color: counterCyan,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 15,
                            //     vertical: 30,
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       Expanded(
                            //         child: Container(
                            //           height: 2,
                            //           color: Colors.grey.shade400,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 5),
                            //         child: Text(
                            //           'OR Continue with',
                            //           style: styleLight,
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //           height: 2,
                            //           color: Colors.grey.shade400,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 30,
                            //   ),
                            //   child: CustomButton(
                            //     title: "Email address        >",
                            //     bgColor: counterCyan,
                            //     textColor: Colors.white,
                            //     onPressed: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => const LoginScreen(),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
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
