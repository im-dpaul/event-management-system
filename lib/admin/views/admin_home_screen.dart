import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/admin/controller/event_controller.dart';
import 'package:event_management_system/admin/models/admin_event_model.dart';
import 'package:event_management_system/authentication/views/login_screen.dart';
import 'package:event_management_system/event_details/models/all_event_model.dart';
import 'package:event_management_system/event_details/models/event_model.dart';
import 'package:event_management_system/admin/views/create_event.dart';
import 'package:event_management_system/admin/views/event_details_screen.dart';
import 'package:event_management_system/event_details/repository/event_repository.dart';
import 'package:event_management_system/event_details/views/event_screen.dart';
import 'package:event_management_system/main.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<AdminEventModel> event = EventController().getEventModel();
  final eventRepository = EventRepository();
  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);

    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 230, 245, 248),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: styleBold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: const Icon(
                Icons.logout_rounded,
                color: Colors.red,
                size: 30,
              ),
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
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: FutureBuilder<AllEventModel>(
          future: eventRepository.getAllEvents(),
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
                            builder: (context) => EventDetailsScreen(
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
                              style: styleBold,
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
                              style: styleSemiBold,
                            ),
                            Text(
                              "Date : ${snapshot.data!.eventData![index].eventDate}",
                              style: styleSemiBold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEvent(),
            ),
          );
        },
        elevation: 3.0,
        backgroundColor: counterCyan,
        foregroundColor: Colors.white,
        label: const Text('Event'),
        splashColor: activeCyan,
        hoverColor: activeCyan,
        hoverElevation: 35,
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
