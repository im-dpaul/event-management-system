import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/admin/controller/event_controller.dart';
import 'package:event_management_system/admin/models/admin_event_model.dart';
import 'package:event_management_system/event_details/repository/event_repository.dart';
import 'package:event_management_system/event_details/views/event_screen.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/user_dashboard/models/event_category_model.dart';
import 'package:event_management_system/user_dashboard/repository/search_data_repository.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/loading.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCategory extends StatefulWidget {
  String category;
  EventCategory(this.category, {super.key});

  @override
  State<EventCategory> createState() => _EventCategoryState();
}

class _EventCategoryState extends State<EventCategory> {
  List<AdminEventModel> event = EventController().getEventModel();
  final eventRepository = EventRepository();
  final searchDataRepo = SearchDataReposirtoy();
  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);

    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;

    String category = widget.category;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 245, 248),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Text(
          category,
          style: styleBold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: FutureBuilder<EventCategoryModel?>(
          future: searchDataRepo.eventCategory(category.toLowerCase()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.eventData!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      onTap: () {
                        final eventData = {
                          'eventID': snapshot.data!.eventData![index].id,
                          'eventImage': snapshot
                              .data!.eventData![index].eventFeatureImage,
                          'eventTitle':
                              snapshot.data!.eventData![index].eventName,
                          'eventVenue':
                              snapshot.data!.eventData![index].eventVenue,
                          'eventDate':
                              snapshot.data!.eventData![index].eventDate,
                          'eventDescription':
                              snapshot.data!.eventData![index].eventDescription,
                          'eventCategory':
                              snapshot.data!.eventData![index].eventCategory,
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventScreen(
                              eventData: eventData,
                            ),
                          ),
                        );
                      },
                      leading: Hero(
                        tag:
                            'img-tag-${snapshot.data!.eventData![index].eventFeatureImage!}',
                        child: CachedNetworkImage(
                          height: height * 0.3,
                          width: 75,
                          imageUrl: snapshot
                              .data!.eventData![index].eventFeatureImage!,
                          fit: BoxFit.fill,
                          errorWidget: (
                            context,
                            url,
                            error,
                          ) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data!.eventData![index].eventName!,
                              style: styleSemiBold,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Venue : ${snapshot.data!.eventData![index].eventVenue}",
                              style: styleRegular,
                            ),
                            Text(
                              "Date : ${snapshot.data!.eventData![index].eventDate}",
                              style: styleRegular,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Something went wrong', style: styleSemiBold),
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
                        loadingProvider.setLoading(true);
                        const Dashboard();
                        loadingProvider.setLoading(false);
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
}
