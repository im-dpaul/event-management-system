import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/bookings/views/booking_details.dart';
import 'package:event_management_system/event_details/models/slot_model.dart';
import 'package:event_management_system/event_details/providers/event_details_provider.dart';
import 'package:event_management_system/event_details/repository/event_repository.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  final Map eventData;
  const EventScreen({required this.eventData, super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final utils = Utils();
  final eventRepository = EventRepository();
  late Widget icon;

  @override
  void initState() {
    super.initState();
    icon = determineCategoryIcon(widget.eventData['eventCategory']);
  }

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'img-tag-${widget.eventData['eventImage']}',
                  child: CachedNetworkImage(
                    height: height * 0.5,
                    width: width,
                    imageUrl: widget.eventData['eventImage'],
                    fit: BoxFit.fill,
                    errorWidget: (
                      context,
                      url,
                      error,
                    ) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: height * 0.43,
                  right: width * 0.01,
                  child: IconButton(
                    onPressed: () {},
                    icon: icon,
                    iconSize: 22,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.eventData['eventTitle'],
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.eventData['eventVenue'],
                          style: styleSemiBold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.eventData['eventDate'],
                          style: styleSemiBold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      'About',
                      style: styleBold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      widget.eventData['eventDescription'],
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        color: counterCyan,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: CustomButton(
            title: 'Book now',
            bgColor: Colors.transparent,
            textColor: white,
            onPressed: () async {
              // ignore: use_build_context_synchronously
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: const Color.fromARGB(255, 244, 249, 250),
                elevation: 15,
                isDismissible: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) {
                  return FutureBuilder<SlotModel>(
                      future: eventRepository
                          .getEventSlots(widget.eventData['eventID']),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.cancel_outlined),
                                iconSize: 22,
                                color: Colors.grey.shade700,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.01,
                                ),
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: ListTile(
                                        iconColor: counterCyan,
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data!.data![index].slotName
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: styleSemiBold,
                                            ),
                                            Text(
                                              'Available- ${snapshot.data!.data![index].available.toString()}',
                                              style: GoogleFonts.openSans(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 230, 245, 248),
                                                textStyle: const TextStyle(
                                                  color: counterCyan,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          children: [
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_city,
                                                  size: 18,
                                                  color: Colors.grey.shade400,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  snapshot
                                                      .data!.data![index].venue
                                                      .toString(),
                                                  style: styleRegular,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size: 18,
                                                  color: Colors.grey.shade400,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${snapshot.data!.data![index].startTime}-${snapshot.data!.data![index].endTime}',
                                                  style: styleRegular,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .monetization_on_outlined,
                                                  size: 18,
                                                  color: Colors.grey.shade400,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '₹${snapshot.data!.data![index].price} only',
                                                  style: styleRegular,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            if (snapshot.data!.data![index]
                                                    .available ==
                                                0) {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'No more tickets available for this slot, please try another slot!',
                                              );
                                            } else {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingDetails(
                                                    eventID: widget
                                                        .eventData['eventID'],
                                                    eventName: widget.eventData[
                                                        'eventTitle'],
                                                    slotID: snapshot
                                                        .data!.data![index].id
                                                        .toString(),
                                                    availableTickets: snapshot
                                                        .data!
                                                        .data![index]
                                                        .available!,
                                                    price: snapshot.data!
                                                        .data![index].price!,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                              Icons.arrow_forward_ios),
                                          iconSize: 18,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.grey.shade400,
                                      thickness: 1,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: counterCyan,
                            ),
                          );
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                'Cannot fetch slot details',
                                style: styleSemiBold,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.20,
                                  vertical: height * 0.02,
                                ),
                                child: CustomButton(
                                  title: 'Try Again',
                                  bgColor: counterCyan,
                                  textColor: white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      });
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget determineCategoryIcon(String category) {
    if (category == "music") {
      return const Icon(Icons.music_note);
    } else if (category == "movies & theatre") {
      return const Icon(Icons.theater_comedy_rounded);
    } else if (category == "art") {
      return const Icon(Icons.art_track_sharp);
    } else {
      return const Icon(Icons.sports_basketball_rounded);
    }
  }
}
