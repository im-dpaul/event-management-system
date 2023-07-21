import 'dart:developer';

import 'package:event_management_system/bookings/providers/booking_provider.dart';
import 'package:event_management_system/bookings/repository/booking_repository.dart';
import 'package:event_management_system/bookings/views/successful_booking.dart';
import 'package:event_management_system/main.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/cutom_text_field.dart';
import 'package:event_management_system/utils/shared/shared_widgets/loading.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookingDetails extends StatefulWidget {
  final String eventID, eventName, slotID;
  final int availableTickets;
  final int price;
  const BookingDetails(
      {required this.eventID,
      required this.eventName,
      required this.slotID,
      required this.availableTickets,
      required this.price,
      super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  final utils = Utils();
  final bookingRepository = BookingRepository();
  final nameController = TextEditingController(
      text: fName.isNotEmpty ? '$fName $lName' : 'Name (Not updated)');
  final emailController = TextEditingController(text: emailId);
  final phoneController = TextEditingController(text: phoneNum);
  final ticketController = TextEditingController(text: '1');

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    ticketController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    String attendee = '$fName $lName';
    return Scaffold(
      bottomNavigationBar: Consumer<BookingProvider>(
        builder: ((context, value, child) {
          return GestureDetector(
            onTap: () async {
              String result = 'failed';
              if (ticketController.text == '0' ||
                  ticketController.text.contains('-') ||
                  ticketController.text.contains('.')) {
                // ignore: use_build_context_synchronously
                utils.showSnackBar(
                  content: "Please select a valid no. of tickets!",
                  context: context,
                );
              } else {
                loadingProvider.setLoading(true);
                result = await bookingRepository.createBooking(
                  widget.eventID,
                  widget.slotID,
                  value.tickets,
                );
                loadingProvider.setLoading(false);
                if (result == 'success') {
                  value.tickets = 1;
                  ticketController.clear();
                  value.isChecked = false;
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                    this.context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessfulBooking(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              }
            },
            child: Container(
              height: height * 0.065,
              color: (value.isChecked) ? counterCyan : Colors.grey.shade400,
              child: Center(
                child: Container(
                  height: height * 0.065,
                  color: (value.isChecked) ? counterCyan : Colors.grey.shade400,
                  child: Center(
                    child: Text(
                      'Proceed to pay',
                      style: styleSemiBoldWhite,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 230, 245, 248),
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.eventName,
          overflow: TextOverflow.ellipsis,
          style: styleBold,
        ),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: (loadingProvider.isLoading)
          ? const Loading()
          : Padding(
              padding: EdgeInsets.only(
                top: height * 0.12,
                left: width * 0.07,
                right: width * 0.07,
                //bottom: height * 0.12,
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      'Please confirm the booking details',
                      style: styleSemiBold,
                    ),
                    SizedBox(height: height * 0.07),
                    CustomTextField(
                      hint: fName.isEmpty ? 'Name (Not updated)' : attendee,
                      controller: nameController,
                      icon: const Icon(Icons.person),
                      keyboardType: TextInputType.name,
                      enabled: false,
                    ),
                    SizedBox(height: height * 0.02),
                    Visibility(
                      visible: emailId.isEmpty ? false : true,
                      child: CustomTextField(
                        hint: emailId,
                        controller: emailController,
                        icon: const Icon(Icons.mail),
                        keyboardType: TextInputType.emailAddress,
                        enabled: false,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Visibility(
                      visible: phoneNum.isEmpty ? false : true,
                      child: CustomTextField(
                        hint: phoneNum,
                        controller: phoneController,
                        icon: const Icon(Icons.phone),
                        keyboardType: TextInputType.number,
                        enabled: false,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Consumer<BookingProvider>(builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Tickets',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: TextField(
                                  style: styleRegular,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: activeCyan,
                                      ),
                                    ),
                                  ),
                                  controller: ticketController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^[1-9][0-9]*'),
                                    )
                                  ],
                                  onSubmitted: (val) {
                                    if (val.isNotEmpty) {
                                      if (int.parse(val) >
                                          widget.availableTickets) {
                                        ticketController.text = '1';
                                        FocusScope.of(context).unfocus();
                                        utils.showSnackBar(
                                          context: context,
                                          content:
                                              'Please enter valid no. of tickets!',
                                        );
                                      } else {
                                        ticketController.text = val;
                                        value.noOfTickets(
                                            int.parse(val.trimLeft()));
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Amount: ₹${widget.price * (int.tryParse(ticketController.text.toString()) ?? 1)}',
                                style: styleSemiBold,
                              )
                            ],
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: height * 0.07),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<BookingProvider>(
                          builder: (context, value, child) {
                            return Checkbox(
                              activeColor: Colors.transparent,
                              checkColor: Colors.black,
                              value: value.isChecked,
                              onChanged: (val) {
                                value.setCheck();
                              },
                            );
                          },
                        ),
                        Text(
                          'I agree with terms and condition',
                          style: styleRegular,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
