import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/event_details/views/event_screen.dart';
import 'package:event_management_system/user_dashboard/models/search_model.dart';
import 'package:event_management_system/user_dashboard/providers/dashboard_provider.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchResult extends StatefulWidget {
  SearchModel searchModel;
  SearchResult(this.searchModel, {super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult>
    with AutomaticKeepAliveClientMixin<SearchResult> {
  @override
  bool get wantKeepAlive => true;
  final utils = Utils();

  @override
  Widget build(BuildContext context) {
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().height;

    super.build(context);
    return Scaffold(
      appBar: AppBar(
        //title: Text('Result'),
        backgroundColor: const Color.fromARGB(255, 230, 245, 248),
        foregroundColor: counterCyan,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.01,
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.searchModel.data!.length,
          itemBuilder: (context, index) {
            return Consumer<DashboardProvider>(
                builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  final eventData = {
                    'eventID': widget.searchModel.data![index].id,
                    'eventImage':
                        widget.searchModel.data![index].eventFeatureImage,
                    'eventTitle': widget.searchModel.data![index].eventName,
                    'eventVenue': widget.searchModel.data![index].eventVenue,
                    'eventDate': widget.searchModel.data![index].eventDate,
                    'eventDescription':
                        widget.searchModel.data![index].eventDescription,
                    'eventCategory':
                        widget.searchModel.data![index].eventCategory,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventScreen(
                        eventData: eventData,
                      ),
                    ),
                  );
                  value.selectedIndex = 1;
                },
                child: Padding(
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
                              child: Hero(
                                tag:
                                    'img-tag-${widget.searchModel.data![index].eventFeatureImage!}',
                                child: CachedNetworkImage(
                                  imageUrl: widget.searchModel.data![index]
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
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.searchModel.data![index].eventName!,
                                  style: styleSemiBold,
                                ),
                                SizedBox(width: width * 0.01),
                                Icon(
                                  Icons.music_note,
                                  size: 20,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                Text(
                                  widget.searchModel.data![index].eventDate!,
                                  style: styleRegular,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.009),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                Text(
                                  widget.searchModel.data![index].eventVenue!,
                                  style: styleRegular,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
