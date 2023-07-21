import 'package:event_management_system/main.dart';
import 'package:event_management_system/user_dashboard/models/user_profile.dart';
import 'package:event_management_system/user_dashboard/providers/dashboard_provider.dart';
import 'package:event_management_system/user_dashboard/repository/user_data_repository.dart';
import 'package:event_management_system/user_dashboard/views/edit_profile.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  UserProfile userProfile;
  MyProfile(this.userProfile, {super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

final pageController = PageController(initialPage: 1);
@override
void dispose() {
  pageController.dispose();
}

class _MyProfileState extends State<MyProfile> {
  final utils = Utils();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    String name = ((widget.userProfile.firstName == null) ||
            (widget.userProfile.firstName == null))
        ? 'Please complete your profile'
        : '${widget.userProfile.firstName} ${widget.userProfile.lastName}';
    dynamic email = widget.userProfile.email.toString().isEmpty
        ? null
        : widget.userProfile.email;
    dynamic phoneNumber = widget.userProfile.phoneNumber.toString().isEmpty
        ? null
        : widget.userProfile.phoneNumber;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: counterCyan),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                  dashboardProvider.changeTab(1, pageController);
                },
                icon: const Icon(Icons.edit_outlined)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.03, horizontal: width * 0.1),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 75,
                backgroundColor: lightGrey,
                child: Icon(
                  Icons.person_3_outlined,
                  size: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  label: Text(
                    name,
                    style: styleSemiBold,
                  ),
                  enabled: false,
                  icon: const Icon(Icons.person_3_outlined),
                ),
              ),
            ),
            email == null
                ? const SizedBox(
                    height: 10,
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        label: Text(
                          email,
                          style: styleSemiBold,
                        ),
                        enabled: false,
                        icon: const Icon(Icons.email_outlined),
                      ),
                    ),
                  ),
            phoneNumber == null
                ? const SizedBox(
                    height: 10,
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          label: Text(
                            phoneNumber.toString(),
                            style: styleSemiBold,
                          ),
                          enabled: false,
                          icon: const Icon(Icons.phone_iphone_sharp)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
