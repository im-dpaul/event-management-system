import 'package:event_management_system/authentication/views/login_screen.dart';
import 'package:event_management_system/main.dart';
import 'package:event_management_system/user_dashboard/providers/dashboard_provider.dart';
import 'package:event_management_system/user_dashboard/repository/user_data_repository.dart';
import 'package:event_management_system/user_dashboard/views/edit_profile.dart';
import 'package:event_management_system/user_dashboard/views/my_profile.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab>
    with AutomaticKeepAliveClientMixin<SettingsTab> {
  final utils = Utils();
  final userDataRepo = UserDataRepository();
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.14,
                width: width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      color: Color.fromARGB(255, 230, 245, 248),
                      //spreadRadius: 3,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.07,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      onTap: () async {
                        await userDataRepo.fetchUserProfile().then(
                              (value) => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyProfile(value),
                                  ),
                                ),
                              },
                            );
                      },
                      leading: const Icon(
                        Icons.person_3_outlined,
                        size: 24,
                        color: counterCyan,
                      ),
                      title: Text(
                        'My Profile',
                        style: styleRegular,
                      ),
                    ),
                    ListTile(
                      //onTap: () {},
                      leading: Icon(
                        Icons.format_paint_outlined,
                        size: 24,
                        color: Colors.grey.shade600,
                        //color: counterCyan,
                      ),
                      title: Text(
                        'Appearance',
                        style: styleRegular,
                      ),
                    ),
                    ListTile(
                      ////onTap: () {},
                      leading: Icon(
                        Icons.payments_outlined,
                        size: 24,
                        color: Colors.grey.shade600,
                        //color: counterCyan,
                      ),
                      title: Text(
                        'Payments Settings',
                        style: styleRegular,
                      ),
                    ),
                    ListTile(
                      ////onTap: () {},
                      leading: Icon(
                        Icons.edit_notifications_outlined,
                        size: 24,
                        color: Colors.grey.shade600,
                      ),
                      title: Text(
                        'Notifications Settings',
                        style: styleRegular,
                      ),
                    ),
                    ListTile(
                      //onTap: () {},
                      leading: Icon(
                        Icons.info_outline_rounded,
                        size: 24,
                        color: Colors.grey.shade600,
                      ),
                      title: Text(
                        'About App',
                        style: styleRegular,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('token', '');
                        await prefs.setString('role', '');
                        await prefs.setString('firstName', '');
                        await prefs.setString('lastName', '');
                        await prefs.setString('email', '');
                        await prefs.setString('phone', '');
                        fName = '';
                        lName = '';
                        emailId = '';
                        phoneNum = '';
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                        dashboardProvider.selectedIndex = 1;
                        dashboardProvider.isSettingsScreen = false;
                      },
                      leading: const Icon(
                        Icons.logout_outlined,
                        size: 24,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Logout',
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.1,
              horizontal: MediaQuery.of(context).size.width * 0.20,
            ),
            child: Card(
              elevation: 0,
              shadowColor: Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: counterCyan, width: 0.5),
              ),
              child: Container(
                height: 65,
                width: 250,
                alignment: Alignment.center,
                child: Text(
                  'Settings',
                  style: styleBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
