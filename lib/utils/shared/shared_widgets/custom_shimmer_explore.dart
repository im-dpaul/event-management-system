import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management_system/user_dashboard/providers/explore_tab_provider.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomShimmerExplore extends StatelessWidget {
  CustomShimmerExplore({super.key});

  final utils = Utils();

  final flipController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    final exploreTabProider =
        Provider.of<ExploreTabProvider>(context, listen: false);
    final height = utils.getScreenSize().height;

    final width = utils.getScreenSize().width;
    return Scaffold(
        body: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: const Duration(seconds: 5),
      direction: ShimmerDirection.ltr,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 230, 245, 248),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        child: Card(
                          elevation: 0,
                          color: const Color.fromARGB(255, 230, 245, 248),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: counterCyan,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
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
                        child: Card(
                          elevation: 0,
                          color: const Color.fromARGB(255, 230, 245, 248),
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
                        child: Card(
                          elevation: 0,
                          color: const Color.fromARGB(255, 230, 245, 248),
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
                        child: Card(
                          elevation: 0,
                          color: const Color.fromARGB(255, 230, 245, 248),
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
                            final eventImage = featuredEventImages[index];
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
                          'Best of this week',
                          style: styleBold,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: height * 0.2,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  height: height * 0.18,
                                  width: 115,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'This is best of event',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.018),
                        Text(
                          'Featured Events',
                          style: styleBold,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: height * 0.22,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  child: Container(
                                    width: 115,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Featured Events',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.018),
                        Text(
                          'Fun Activities',
                          style: styleBold,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: height * 0.22,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: FlipCard(
                                  controller: flipController,
                                  speed: 800,
                                  fill: Fill.fillBack,
                                  front: Container(
                                    width: 115,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Fun activities',
                                      ),
                                    ),
                                  ),
                                  back: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: Colors.grey.shade600,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Venue and date of event',
                                      ),
                                    ),
                                  ),
                                  onFlipDone: (status) {
                                    if (status) {
                                      // navigate to next screen
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.06),
                        Text(
                          'Trending in Entertainment',
                          style: styleBold,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: height * 0.17,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  width: width * 0.65,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Latest in entertainment',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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
