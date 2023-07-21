import 'package:event_management_system/admin/models/slots_model.dart';
import 'package:event_management_system/admin/providers/event_provider.dart';
import 'package:event_management_system/admin/repository/admin_event_repository.dart';
import 'package:event_management_system/admin/views/admin_home_screen.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/cutom_text_field.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEvetState();
}

class _CreateEvetState extends State<CreateEvent> {
  final eventTitleController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventVenueController = TextEditingController();
  final slotVenueController = TextEditingController();
  final slotNameController = TextEditingController();
  final slotCapacityController = TextEditingController();
  final slotPriceController = TextEditingController();
  final utils = Utils();
  final eventRepository = AdminEventRepository();

  // List of items in our dropdown menu
  List<String> items = <String>[
    'Movies & Theatre',
    'Music',
    'Art',
    'Sports',
  ];

  @override
  void dispose() {
    super.dispose();
    eventTitleController.dispose();
    eventDescriptionController.dispose();
    eventVenueController.dispose();
    slotVenueController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    // Initial Selected Value
    //String dropdownvalue = eventProvider.eventCategory;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        titleTextStyle: GoogleFonts.openSans(
          textStyle: const TextStyle(
            fontSize: 18,
            letterSpacing: -1,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text('New Event'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          iconSize: 28,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: height * 0.05),
              CustomTextField(
                hint: 'Event Title*',
                controller: eventTitleController,
                icon: const Icon(Icons.title_outlined),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: height * 0.03),
              CustomTextField(
                hint: 'Event Description*',
                controller: eventDescriptionController,
                icon: null,
                keyboardType: TextInputType.name,
                lines: 7,
              ),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Event Category',
                    style: styleSemiBold,
                  ),
                  Consumer<EventProvider>(
                    builder: ((context, value, child) {
                      return DropdownButton<String>(
                        items:
                            items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: eventProvider.eventCategory,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        alignment: Alignment.center,
                        elevation: 15,
                        iconEnabledColor: Colors.grey,
                        focusColor: const Color.fromARGB(255, 230, 245, 248),
                        underline: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        onChanged: (String? newValue) {
                          eventProvider.setEventCategory(newValue!);
                        },
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              CustomTextField(
                hint: 'Event Venue*',
                controller: eventVenueController,
                icon: const Icon(Icons.location_city),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Event Date',
                    style: styleSemiBold,
                  ),
                  Consumer<EventProvider>(
                    builder: ((context, value, child) {
                      return InkWell(
                        onTap: () async {
                          value.selectDate(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: counterCyan,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (value.selectedDate == null)
                                  ? 'Select a date'
                                  : "${value.selectedDate!.day.toString().padLeft(2, "0")}-${value.selectedDate!.month.toString().padLeft(2, "0")}-${value.selectedDate!.year}",
                              style: styleRegular,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Image',
                    style: styleSemiBold,
                  ),
                  Consumer<EventProvider>(
                    builder: ((context, value, child) {
                      return InkWell(
                        onTap: () {
                          value.selectImage(ImageSource.gallery);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: counterCyan,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (value.image == null)
                                  ? 'Select an image'
                                  : "Image Selected",
                              style: styleRegular,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: counterCyan,
                  ),
                ),
                child: Consumer<EventProvider>(
                  builder: (context, value, child) {
                    return ExpandablePanel(
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Slots',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                letterSpacing: -1,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: (value.slots.isEmpty)
                                ? white
                                : const Color.fromARGB(255, 230, 245, 248),
                            child: (value.slots.isEmpty)
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
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
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: width * 0.04,
                                              vertical: height * 0.035,
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: value.slots.length,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                          bottom: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(8),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  activeCyan),
                                                        ),
                                                        child: ExpandablePanel(
                                                          header: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 8,
                                                              left: 8,
                                                            ),
                                                            child: Text(
                                                              'Slot- ${value.slots[index].slotName}',
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      -1,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          expanded: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 10,
                                                              right: 10,
                                                              bottom: 6,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Booking Price:',
                                                                      style:
                                                                          styleRegular,
                                                                    ),
                                                                    Text(
                                                                      value
                                                                          .slots[
                                                                              index]
                                                                          .slotPrice,
                                                                      style:
                                                                          styleRegular,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Slot Capacity:',
                                                                      style:
                                                                          styleRegular,
                                                                    ),
                                                                    Text(
                                                                      value
                                                                          .slots[
                                                                              index]
                                                                          .slotCapacity
                                                                          .toString(),
                                                                      style:
                                                                          styleRegular,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Slot Timing:',
                                                                      style:
                                                                          styleRegular,
                                                                    ),
                                                                    Text(
                                                                      "${value.slots[index].slotStartTime} - ${value.slots[index].slotEndTime}",
                                                                      style:
                                                                          styleRegular,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          collapsed: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 8,
                                                              bottom: 8,
                                                            ),
                                                            child: Text(
                                                              'Expand to see slot details',
                                                              style:
                                                                  styleRegular,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      splashRadius: 15,
                                                      onPressed: () {
                                                        value
                                                            .deleteSlots(index);
                                                        Fluttertoast.showToast(
                                                          msg: 'Slot deleted',
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                      ),
                                                      iconSize: 26,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      value.slots.length.toString(),
                                      style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                          color: counterCyan,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      expanded: Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              hint: 'Slot Name*',
                              controller: slotNameController,
                              icon: null,
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(height: height * 0.015),
                            CustomTextField(
                              hint: 'Slot Venue',
                              controller: slotVenueController,
                              icon: const Icon(Icons.location_city_rounded),
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(height: height * 0.015),
                            CustomTextField(
                              hint: 'Booking Price*',
                              controller: slotPriceController,
                              icon: null,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: height * 0.015),
                            CustomTextField(
                              hint: 'Slots Capacity*',
                              controller: slotCapacityController,
                              icon: null,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'From',
                                  style: styleMedium,
                                ),
                                InkWell(
                                  onTap: () async {
                                    value.selecStartTime(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      border: Border.all(
                                        color: counterCyan,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Text(
                                        (value.selectedStartTime == null)
                                            ? 'Select start time*'
                                            : "${value.selectedStartTime!.hour}:${value.selectedStartTime!.minute.toString().padLeft(2, "0")}",
                                        style: styleRegular,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'To',
                                  style: styleMedium,
                                ),
                                InkWell(
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    if (value.selectedStartTime == null) {
                                      Fluttertoast.showToast(
                                        msg:
                                            'Please select a start time first!',
                                      );
                                    } else {
                                      value.selectEndTime(context);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      border: Border.all(
                                        color: counterCyan,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Text(
                                        (value.selectedEndTime == null)
                                            ? 'Select end time*'
                                            : "${value.selectedEndTime!.hour}:${value.selectedEndTime!.minute.toString().padLeft(2, "0")}",
                                        style: styleRegular,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.05),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.15,
                              ),
                              child: Consumer<EventProvider>(
                                builder: (context, value, child) {
                                  return CustomButton(
                                    bgColor: const Color.fromARGB(
                                        255, 230, 245, 248),
                                    textColor: counterCyan,
                                    title: 'Add this slot',
                                    onPressed: () async {
                                      String result = '';
                                      if (slotVenueController.text.isEmpty &&
                                          eventVenueController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Please select a venue for event/slot');
                                      } else if (eventVenueController
                                              .text.isNotEmpty &&
                                          slotVenueController.text.isEmpty) {
                                        slotVenueController.text =
                                            eventVenueController.text;
                                      }
                                      if (slotNameController.text.isNotEmpty &&
                                          slotPriceController.text.isNotEmpty &&
                                          slotCapacityController
                                              .text.isNotEmpty &&
                                          value.selectedStartTime != null &&
                                          value.selectedEndTime != null) {
                                        SlotsModel slot = SlotsModel(
                                            slotVenue:
                                                slotVenueController.text.trim(),
                                            slotName:
                                                slotNameController.text.trim(),
                                            slotPrice:
                                                slotPriceController.text.trim(),
                                            slotCapacity: int.parse(
                                              slotCapacityController.text
                                                  .trim(),
                                            ),
                                            slotStartTime:
                                                '${value.selectedStartTime!.hour}:${value.selectedStartTime!.minute.toString().padLeft(2, "0")}',
                                            slotEndTime:
                                                '${value.selectedEndTime!.hour}:${value.selectedEndTime!.minute.toString().padLeft(2, "0")}');
                                        result = await eventRepository.addSlot(
                                          slotVenueController.text.trim(),
                                          '${value.selectedStartTime!.hour}:${value.selectedStartTime!.minute.toString().padLeft(2, "0")}',
                                          '${value.selectedEndTime!.hour}:${value.selectedEndTime!.minute.toString().padLeft(2, "0")}',
                                          slotNameController.text.trim(),
                                          slotPriceController.text.trim(),
                                          int.parse(
                                            slotCapacityController.text
                                                .toString()
                                                .trim(),
                                          ),
                                        );
                                        if (result != 'failed') {
                                          value.addSlots(slot);
                                          value.slotIDs.add(result);
                                          slotNameController.clear();
                                          slotPriceController.clear();
                                          slotVenueController.clear();
                                          slotCapacityController.clear();
                                        }
                                      } else {
                                        utils.showSnackBar(
                                          context: context,
                                          content:
                                              'Please enter all the required details',
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      collapsed: Text(
                        'Add slot(s) for your event',
                        style: styleRegular,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                child: Consumer<EventProvider>(
                  builder: (context, value, child) {
                    return CustomButton(
                      bgColor: counterCyan,
                      textColor: white,
                      title: 'Create Event',
                      onPressed: () async {
                        String result = '';
                        String imageUploadResult = '';
                        print('category- ${value.eventCategory}');
                        if (eventTitleController.text.isNotEmpty &&
                            eventDescriptionController.text.isNotEmpty &&
                            eventVenueController.text.isNotEmpty &&
                            eventProvider.selectedDate != null &&
                            eventProvider.image != null &&
                            eventProvider.slotIDs.isNotEmpty) {
                          result = await eventRepository.addEvent(
                            title: eventTitleController.text.trim(),
                            date:
                                "${value.selectedDate!.day.toString().padLeft(2, "0")}-${value.selectedDate!.month.toString().padLeft(2, "0")}-${value.selectedDate!.year}",
                            slots: eventProvider.slotIDs,
                            description: eventDescriptionController.text.trim(),
                            category: value.eventCategory.toLowerCase(),
                            venue: eventVenueController.text,
                          );
                          if (result != 'failed') {
                            imageUploadResult = await eventRepository
                                .uploadImage(eventProvider.image, result);
                            if (imageUploadResult == 'success') {
                              print('Image uploaded successfully');
                            } else {
                              print('Image upload failed');
                            }
                            //ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminHome(),
                                ),
                                (Route<dynamic> route) => false);
                            eventTitleController.clear();
                            eventDescriptionController.clear();
                            value.setEventCategory('Movies & Theatre');
                            value.selectedDate = null;
                            value.slots.clear();
                            value.slotIDs.clear();
                          }
                        } else {
                          utils.showSnackBar(
                            context: context,
                            content: 'Please fill all the required details',
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
