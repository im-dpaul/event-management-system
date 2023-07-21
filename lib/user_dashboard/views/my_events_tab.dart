import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/user_dashboard/providers/dashboard_provider.dart';
import 'package:event_management_system/user_dashboard/repository/cancel_booking_repository.dart';
import 'package:event_management_system/user_dashboard/repository/my_events_repository.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEventsTab extends StatefulWidget {
  const MyEventsTab({super.key});

  @override
  State<MyEventsTab> createState() => _MyEventsTabState();
}

class _MyEventsTabState extends State<MyEventsTab>
    with AutomaticKeepAliveClientMixin<MyEventsTab> {
  @override
  bool get wantKeepAlive => true;

  final flipController = FlipCardController();
  final myEventsRepository = MyEventsRepository();
  final cancelBookingRepository = CancelBookingRepository();
  final utils = Utils();

  late Widget icon;

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().height;

    super.build(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.01,
        ),
        child: FutureBuilder(
          future: myEventsRepository.getMyEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  icon = determineCategoryIcon(
                    snapshot.data!.data![index].eventId!.eventCategory!,
                  );
                  return FlipCard(
                    controller: flipController,
                    speed: 600,
                    fill: Fill.fillBack,
                    front: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 100,
                                  color: Colors.grey.shade400,
                                  child: CachedNetworkImage(
                                    width: 130,
                                    imageUrl: snapshot.data!.data![index]
                                        .eventId!.eventFeatureImage!,
                                    fit: BoxFit.fill,
                                    errorWidget: (
                                      context,
                                      url,
                                      error,
                                    ) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    determineCategoryIcon(snapshot.data!
                                        .data![index].eventId!.eventCategory!),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        snapshot.data!.data![index].eventId!
                                            .eventName!,
                                        style: styleSemiBold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.012),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        snapshot.data!.data![index].eventId!
                                            .eventDate!,
                                        style: styleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.009),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        snapshot.data!.data![index].eventId!
                                            .eventVenue!,
                                        style: styleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.009),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on_outlined,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        'Booked Tickets- ${snapshot.data!.data![index].numberOfTickets.toString()}',
                                        style: styleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    back: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!.data![index].eventId!
                                      .eventDescription!,
                                  style: styleSemiBold,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 100,
                                  //color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          String result = 'failed';
                                          loadingProvider.setLoading(true);
                                          result = await cancelBookingRepository
                                              .cancelBooking(
                                            snapshot.data!.data![index].id!,
                                          );
                                          loadingProvider.setLoading(false);
                                          if (result == 'success') {
                                            const Dashboard();
                                            dashboardProvider.selectedIndex = 1;
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        'Cancel',
                                        textAlign: TextAlign.center,
                                        style: styleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: counterCyan,
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Something went wrong', style: styleSemiBold),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                      vertical: height * 0.02,
                    ),
                    child: Consumer<DashboardProvider>(
                      builder: (context, value, child) {
                        return CustomButton(
                          title: 'Try Again',
                          bgColor: counterCyan,
                          textColor: white,
                          onPressed: () {
                            loadingProvider.setLoading(true);
                            const Dashboard();
                            loadingProvider.setLoading(false);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
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
