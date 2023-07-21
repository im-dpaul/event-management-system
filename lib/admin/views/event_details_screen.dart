import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/bookings/views/booking_details.dart';
import 'package:event_management_system/event_details/models/slot_model.dart';
import 'package:event_management_system/event_details/repository/event_repository.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final Map eventData;
  const EventDetailsScreen({required this.eventData, super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
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
