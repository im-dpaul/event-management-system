import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management_system/event_details/models/all_event_model.dart';
import 'package:event_management_system/event_details/models/event_model.dart';
import 'package:event_management_system/event_details/repository/event_repository.dart';
import 'package:event_management_system/event_details/views/event_screen.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/user_dashboard/providers/explore_tab_provider.dart';
import 'package:event_management_system/user_dashboard/repository/search_data_repository.dart';
import 'package:event_management_system/user_dashboard/views/all_events.dart';
import 'package:event_management_system/user_dashboard/views/dashboard.dart';
import 'package:event_management_system/user_dashboard/views/event_category.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_button.dart';
import 'package:event_management_system/utils/shared/shared_widgets/custom_shimmer_explore.dart';
import 'package:event_management_system/utils/shared/shared_widgets/loading.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab>
    with AutomaticKeepAliveClientMixin<ExploreTab> {
  @override
  bool get wantKeepAlive => true;
  final utils = Utils();
  final flipController = FlipCardController();
  final eventRepository = EventRepository();
  final searchDataRepo = SearchDataReposirtoy();
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final exploreTabProider =
        Provider.of<ExploreTabProvider>(context, listen: false);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;
    return Scaffold(
      body: (loadingProvider.isLoading)
          ? const Loading()
          : FutureBuilder<EventModel>(
              future: eventRepository.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 230, 245, 248),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventCategory('Movies & Theatre'),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: const Color.fromARGB(
                                        255, 230, 245, 248),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: counterCyan,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.theater_comedy_rounded,
                                            color: counterCyan,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Movies & Theatre',
                                            style: TextStyle(
                                              color: counterCyan,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventCategory('Music'),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: const Color.fromARGB(
                                        255, 230, 245, 248),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(color: counterCyan),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.music_note_rounded,
                                            color: counterCyan,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Music',
                                            style: TextStyle(
                                              color: counterCyan,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventCategory('Art'),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: const Color.fromARGB(
                                        255, 230, 245, 248),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: counterCyan,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.art_track_sharp,
                                            color: counterCyan,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Art',
                                            style: TextStyle(
                                              color: counterCyan,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventCategory('Sports'),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: const Color.fromARGB(
                                        255, 230, 245, 248),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: counterCyan,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.sports_basketball_outlined,
                                            color: counterCyan,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Sports',
                                            style: TextStyle(
                                              color: counterCyan,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: width,
                                  child: CarouselSlider.builder(
                                    itemCount: featuredEventImages.length,
                                    itemBuilder: (context, index, realIndek) {
                                      final eventImage =
                                          featuredEventImages[index];
                                      return buildImage(eventImage, index);
                                    },
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        exploreTabProider.changeIndex(index);
                                      },
                                      viewportFraction: 1,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: height * 0.175,
                                  left: width * 0.4,
                                  child: Consumer<ExploreTabProvider>(
                                    builder: ((context, value, child) {
                                      return buildIndicator();
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.015),
                            Container(
                              margin: EdgeInsets.only(left: width * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Featured Events',
                                    style: styleBold,
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    height: height * 0.18,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data!.data!.featured!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              final eventData = {
                                                'eventID': snapshot.data!.data!
                                                    .featured![index].id,
                                                'eventImage': snapshot
                                                    .data!
                                                    .data!
                                                    .featured![index]
                                                    .eventFeatureImage,
                                                'eventTitle': snapshot
                                                    .data!
                                                    .data!
                                                    .featured![index]
                                                    .eventName,
                                                'eventVenue': snapshot
                                                    .data!
                                                    .data!
                                                    .featured![index]
                                                    .eventVenue,
                                                'eventDate': snapshot
                                                    .data!
                                                    .data!
                                                    .featured![index]
                                                    .eventDate,
                                                'eventDescription': snapshot
                                                    .data!
                                                    .data!
                                                    .featured![index]
                                                    .eventDescription,
                                                'eventCategory': snapshot
                                                    .data!
                                                    .data!
                                                    .featured![index]
                                                    .eventCategory,
                                              };
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventScreen(
                                                    eventData: eventData,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                              child: CachedNetworkImage(
                                                width: width * 0.55,
                                                imageUrl: snapshot
                                                    .data!
                                                    .data!
                                                    .featured![index]
                                                    .eventFeatureImage!,
                                                fit: BoxFit.fill,
                                                errorWidget: (
                                                  context,
                                                  url,
                                                  error,
                                                ) =>
                                                    const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  Text(
                                    'Best of this week',
                                    style: styleBold,
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    height: height * 0.18,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot
                                          .data!.data!.bestEvents!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            final eventData = {
                                              'eventID': snapshot.data!.data!
                                                  .bestEvents![index].id,
                                              'eventImage': snapshot
                                                  .data!
                                                  .data!
                                                  .bestEvents![index]
                                                  .eventDetails!
                                                  .first
                                                  .eventFeatureImage,
                                              'eventTitle': snapshot
                                                  .data!
                                                  .data!
                                                  .bestEvents![index]
                                                  .eventDetails!
                                                  .first
                                                  .eventName,
                                              'eventVenue': snapshot
                                                  .data!
                                                  .data!
                                                  .bestEvents![index]
                                                  .eventDetails!
                                                  .first
                                                  .eventVenue,
                                              'eventDate': snapshot
                                                  .data!
                                                  .data!
                                                  .bestEvents![index]
                                                  .eventDetails!
                                                  .first
                                                  .eventDate,
                                              'eventDescription': snapshot
                                                  .data!
                                                  .data!
                                                  .bestEvents![index]
                                                  .eventDetails!
                                                  .first
                                                  .eventDescription,
                                              'eventCategory': snapshot
                                                  .data!
                                                  .data!
                                                  .bestEvents![index]
                                                  .eventDetails!
                                                  .first
                                                  .eventCategory,
                                            };
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EventScreen(
                                                  eventData: eventData,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    height: height * 0.24,
                                                    width: width * 0.55,
                                                    imageUrl: snapshot
                                                        .data!
                                                        .data!
                                                        .bestEvents![index]
                                                        .eventDetails!
                                                        .first
                                                        .eventFeatureImage!,
                                                    fit: BoxFit.fill,
                                                    errorWidget: (
                                                      context,
                                                      url,
                                                      error,
                                                    ) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: height * 0.218,
                                                left: width * 0.014,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black45,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  width: 135,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 6,
                                                    ),
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .data!
                                                          .bestEvents![index]
                                                          .eventDetails!
                                                          .first
                                                          .eventName!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: styleMediumWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  Text(
                                    'Latest in Music',
                                    style: styleBold,
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    height: height * 0.16,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot
                                          .data!.data!.musicEvents!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            final eventData = {
                                              'eventID': snapshot.data!.data!
                                                  .musicEvents![index].id,
                                              'eventImage': snapshot
                                                  .data!
                                                  .data!
                                                  .musicEvents![index]
                                                  .eventFeatureImage,
                                              'eventTitle': snapshot
                                                  .data!
                                                  .data!
                                                  .musicEvents![index]
                                                  .eventName,
                                              'eventVenue': snapshot
                                                  .data!
                                                  .data!
                                                  .musicEvents![index]
                                                  .eventVenue,
                                              'eventDate': snapshot
                                                  .data!
                                                  .data!
                                                  .musicEvents![index]
                                                  .eventDate,
                                              'eventCategory': snapshot
                                                  .data!
                                                  .data!
                                                  .musicEvents![index]
                                                  .eventCategory,
                                              'eventDescription': snapshot
                                                  .data!
                                                  .data!
                                                  .musicEvents![index]
                                                  .eventDescription,
                                            };
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EventScreen(
                                                  eventData: eventData,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                width: 150,
                                                fit: BoxFit.fill,
                                                imageUrl: snapshot
                                                    .data!
                                                    .data!
                                                    .musicEvents![index]
                                                    .eventFeatureImage!,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'All Events',
                                        style: styleBold,
                                      ),
                                      GestureDetector(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AllEvents()),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.chevron_right_outlined,
                                            size: 32,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                      height: height * 0.17,
                                      child: FutureBuilder<AllEventModel>(
                                          future:
                                              eventRepository.getAllEvents(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: 4,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      final eventData = {
                                                        'eventID': snapshot
                                                            .data!
                                                            .eventData![index]
                                                            .id,
                                                        'eventImage': snapshot
                                                            .data!
                                                            .eventData![index]
                                                            .eventFeatureImage,
                                                        'eventTitle': snapshot
                                                            .data!
                                                            .eventData![index]
                                                            .eventName,
                                                        'eventVenue': snapshot
                                                            .data!
                                                            .eventData![index]
                                                            .eventVenue,
                                                        'eventDate': snapshot
                                                            .data!
                                                            .eventData![index]
                                                            .eventDate,
                                                        'eventDescription':
                                                            snapshot
                                                                .data!
                                                                .eventData![
                                                                    index]
                                                                .eventDescription,
                                                        'eventCategory':
                                                            snapshot
                                                                .data!
                                                                .eventData![
                                                                    index]
                                                                .eventCategory,
                                                      };
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventScreen(
                                                            eventData:
                                                                eventData,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 5,
                                                      ),
                                                      child: SizedBox(
                                                        width: width * 0.55,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(8),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            height:
                                                                height * 0.3,
                                                            width: 55,
                                                            imageUrl: snapshot
                                                                .data!
                                                                .eventData![
                                                                    index]
                                                                .eventFeatureImage!,
                                                            fit: BoxFit.fill,
                                                            errorWidget: (
                                                              context,
                                                              url,
                                                              error,
                                                            ) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return CustomShimmerExplore();
                                            } else {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('Something went wrong',
                                                      style: styleSemiBold),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: width * 0.20,
                                                      vertical: height * 0.02,
                                                    ),
                                                    child: CustomButton(
                                                      title: 'Try Again',
                                                      bgColor: counterCyan,
                                                      textColor: white,
                                                      onPressed: () {
                                                        loadingProvider
                                                            .setLoading(true);
                                                        const Dashboard();
                                                        loadingProvider
                                                            .setLoading(false);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          })),
                                  SizedBox(height: height * 0.03),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CustomShimmerExplore();
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
    );
  }

  Widget buildImage(String eventImage, int index) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Image.asset(
          eventImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Consumer<ExploreTabProvider>(
      builder: (context, value, child) {
        return AnimatedSmoothIndicator(
          effect: ScrollingDotsEffect(
            radius: 8,
            strokeWidth: 0.25,
            dotWidth: 6,
            dotHeight: 6,
            dotColor: Colors.grey.shade300,
            activeDotColor: counterCyan,
          ),
          activeIndex: value.activeIndex,
          count: featuredEventImages.length,
        );
      },
    );
  }
}
