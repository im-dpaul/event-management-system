import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SuccessfulBooking extends StatefulWidget {
  const SuccessfulBooking({Key? key}) : super(key: key);

  @override
  State<SuccessfulBooking> createState() => _SuccessfulBookingState();
}

class _SuccessfulBookingState extends State<SuccessfulBooking> {
  final utils = Utils();

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: height * 0.04),
        child: Column(
          children: [
            SizedBox(height: height * 0.2),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              maxRadius: 85,
              backgroundImage: AssetImage(
                'assets/successful_booking/success.gif',
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              'Successful',
              textAlign: TextAlign.center,
              style: styleBold,
            ),
            SizedBox(height: height * 0.15),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Your tickets have been booked succesfully.\n\nEnjoy your event:)',
                textAlign: TextAlign.center,
                style: styleSemiBold,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                width * 0.01,
                height * 0.01,
                width * 0.01,
                height * 0.02,
              ),
              child: Text(
                'Tickets will be sent to registered email/phone no.',
                style: styleRegular,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: CustomButton(
                title: 'Continue',
                bgColor: counterCyan,
                textColor: white,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
