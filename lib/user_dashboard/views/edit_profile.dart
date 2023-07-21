//import 'dart:html';

import 'package:event_management_system/main.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/user_dashboard/providers/dashboard_provider.dart';
import 'package:event_management_system/user_dashboard/repository/user_data_repository.dart';
import 'package:event_management_system/user_dashboard/views/my_profile.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_password_field.dart';
import 'package:event_management_system/utils/shared/shared_widgets/cutom_text_field.dart';
import 'package:event_management_system/utils/shared/shared_widgets/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  // final emailController = TextEditingController();
  // final phoneController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final utils = Utils();

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final userDataRepo = UserDataRepository();
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: counterCyan),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (firstNameController.text.isEmpty ||
                      lastNameController.text.isEmpty) {
                    utils.showSnackBar(
                      context: context,
                      content: "First & Last name both are required!",
                      color: Colors.red,
                    );
                  } else if (!RegExp(r'^[a-zA-Z]{3,8}$')
                      .hasMatch(firstNameController.text)) {
                    utils.showSnackBar(
                      context: context,
                      content: "Invalid First Name!",
                    );
                  } else if (!RegExp(r'^[a-zA-Z]{3,8}$')
                      .hasMatch(lastNameController.text)) {
                    utils.showSnackBar(
                      context: context,
                      content: "Invalid Last Name!",
                    );
                  } else {
                    loadingProvider.setLoading(true);
                    SharedPreferences prefs;
                    await userDataRepo
                        .updateUserProfile(
                          firstNameController.text,
                          lastNameController.text,
                          // emailController.text,
                          // phoneController.text,
                        )
                        .then(
                          (value) async => {
                            if (value == 200)
                              {
                                fName = firstNameController.text,
                                lName = lastNameController.text,
                                prefs = await SharedPreferences.getInstance(),
                                await prefs.setString('firstName', fName),
                                await prefs.setString('lastName', lName),
                                dashboardProvider
                                    .setName(firstNameController.text),
                                loadingProvider.setLoading(false),
                                FocusScope.of(context).unfocus(),
                                utils.showSnackBar(
                                  context: context,
                                  content: "Updated Successfully!",
                                  color: Colors.green,
                                ),
                              }
                            else
                              {
                                loadingProvider.setLoading(false),
                                utils.showSnackBar(
                                  context: context,
                                  content: "Failed to Update!",
                                  color: Colors.red,
                                ),
                              }
                          },
                        );
                  }
                },
                icon: const Icon(Icons.done_outlined)),
          )
        ],
      ),
      body: loadingProvider.isLoading
          ? const Loading()
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.08),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: const <Widget>[
                      CircleAvatar(
                        radius: 75,
                        backgroundColor: lightGrey,
                        child: Icon(
                          Icons.person_3_outlined,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: CustomTextField(
                      hint: 'First name',
                      controller: firstNameController,
                      icon: const Icon(Icons.person_2_outlined),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: CustomTextField(
                      hint: 'Last name',
                      controller: lastNameController,
                      icon: const Icon(Icons.person_2_outlined),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 25),
                  //   child: CustomTextField(
                  //     hint: 'Email Address',
                  //     controller: emailController,
                  //     icon: const Icon(Icons.email_outlined),
                  //     keyboardType: TextInputType.emailAddress,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 25),
                  //   child: CustomTextField(
                  //     hint: 'Phone no.',
                  //     controller: phoneController,
                  //     icon: const Icon(Icons.phone_iphone_sharp),
                  //     keyboardType: TextInputType.phone,
                  //   ),
                  // ),
                  Visibility(
                    visible: emailId.isEmpty ? false : true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () {
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
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.01,
                                          horizontal: width * 0.01),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              splashColor: Colors.transparent,
                                              splashRadius: 0.1,
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.cancel_outlined,
                                                size: 24,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.08),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: CustomPasswordField(
                                                    hint: 'Old Password',
                                                    controller:
                                                        oldPasswordController,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: CustomPasswordField(
                                                    hint: 'New Password',
                                                    controller:
                                                        passwordController,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: CustomPasswordField(
                                                    hint:
                                                        'Confirm New Password',
                                                    controller:
                                                        newPasswordController,
                                                  ),
                                                ),
                                                const SizedBox(height: 25),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.25,
                                                  ),
                                                  child: CustomButton(
                                                    title: 'Save',
                                                    bgColor: counterCyan,
                                                    textColor: Colors.white,
                                                    onPressed: () async {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      if (passwordController
                                                              .text !=
                                                          newPasswordController
                                                              .text) {
                                                        if (kDebugMode) {
                                                          print(
                                                              'New Password mismatch');
                                                        }
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "New Password mismatch!",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else if (passwordController
                                                              .text.length <
                                                          6) {
                                                        if (kDebugMode) {
                                                          print(
                                                              'Password length should be more than 6');
                                                        }
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Password should contain atleast 6 AlphaNumeric characters!",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        await userDataRepo
                                                            .changePassword(
                                                                oldPasswordController
                                                                    .text,
                                                                newPasswordController
                                                                    .text)
                                                            .then((value) {
                                                          loadingProvider
                                                              .setLoading(
                                                                  false);
                                                          if (value == 200) {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            utils.showSnackBar(
                                                              context: context,
                                                              content:
                                                                  "Password Updated Successfully!",
                                                              color:
                                                                  Colors.green,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Failed to Update Password!');
                                                            utils.showSnackBar(
                                                              context: context,
                                                              content:
                                                                  "Failed to Update Password!",
                                                              color: Colors.red,
                                                            );
                                                          }
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 25),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('Change Password'),
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
