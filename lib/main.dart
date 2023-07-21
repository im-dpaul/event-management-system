import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:event_management_system/admin/providers/event_provider.dart';
import 'package:event_management_system/admin/views/admin_home_screen.dart';
import 'package:event_management_system/authentication/providers/authentication_provider.dart';
import 'package:event_management_system/authentication/views/signup_screen.dart';
import 'package:event_management_system/bookings/providers/booking_provider.dart';
import 'package:event_management_system/event_details/providers/event_details_provider.dart';
import 'package:event_management_system/event_details/views/event_screen.dart';
import 'package:event_management_system/firebase_options.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/authentication/providers/password_field_provider.dart';
import 'package:event_management_system/authentication/views/login_screen.dart';
import 'package:event_management_system/user_dashboard/providers/dashboard_provider.dart';
import 'package:event_management_system/user_dashboard/providers/explore_tab_provider.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token = '';
String role = '';
String fName = '';
String lName = '';
String emailId = '';
String phoneNum = '';
dynamic prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  //print('token- ${prefs.getString('token')}');
  token = prefs.getString('token') ?? "";
  role = prefs.getString('role') ?? "";
  fName = prefs.getString('firstName') ?? "";
  lName = prefs.getString('lastName') ?? "";
  emailId = prefs.getString('email') ?? "";
  phoneNum = prefs.getString('phone') ?? "";
  print('token- $token');
  print('role- $role');
  print('First Name > $fName');
  print('Last Name >$lName');
  print('Phone Number >$phoneNum');
  print('Email Id >$emailId');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PasswordFieldProvider>(
          create: (_) => PasswordFieldProvider(),
        ),
        ChangeNotifierProvider<LoadingProvider>(
          create: (_) => LoadingProvider(),
        ),
        ChangeNotifierProvider<DashboardProvider>(
          create: (_) => DashboardProvider(),
        ),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<ExploreTabProvider>(
          create: (_) => ExploreTabProvider(),
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (_) => EventProvider(),
        ),
        ChangeNotifierProvider<EventDetailsProvider>(
          create: (_) => EventDetailsProvider(),
        ),
        ChangeNotifierProvider<BookingProvider>(
          create: (_) => BookingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EMS',
        home: AnimatedSplashScreen(
          splashIconSize: double.infinity,
          splashTransition: SplashTransition.fadeTransition,
          //backgroundColor: counterCyan,
          backgroundColor: const Color.fromARGB(255, 230, 245, 248),
          duration: 900,
          nextScreen: (token != '')
              ? (role == 'ADMIN')
                  ? const AdminHome()
                  : const Dashboard()
              : const LoginScreen(),
          splash: Image.asset('assets/logo/EMS-logo.png'),
        ),
      ),
    );
  }
}
