import 'dart:async';
import 'package:event_management_system/main.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:event_management_system/user_dashboard/models/search_model.dart';
import 'package:event_management_system/user_dashboard/providers/dashboard_provider.dart';
import 'package:event_management_system/user_dashboard/repository/search_data_repository.dart';
import 'package:event_management_system/user_dashboard/repository/user_data_repository.dart';
import 'package:event_management_system/user_dashboard/views/my_events_tab.dart';
import 'package:event_management_system/user_dashboard/views/my_profile.dart';
import 'package:event_management_system/user_dashboard/views/search_result.dart';
import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/shared_widgets/loading.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:event_management_system/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

final pageController = PageController(initialPage: 1);
final searchController = TextEditingController();

final utils = Utils();

@override
void dispose() {
  pageController.dispose();
}

class _DashboardState extends State<Dashboard> {
  final userDataRepo = UserDataRepository();
  final searchDataRepo = SearchDataReposirtoy();
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final height = utils.getScreenSize().height;
    final width = utils.getScreenSize().width;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: dashboardProvider.selectedIndex,
        selectedItemColor: counterCyan,
        selectedLabelStyle: styleSemiBold,
        unselectedLabelStyle: styleRegular,
        selectedIconTheme: const IconThemeData(
          size: 24,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 22,
          color: Colors.grey,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'My Events',
            backgroundColor: Color.fromARGB(255, 230, 245, 248),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
            backgroundColor: Color.fromARGB(255, 230, 245, 248),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
            backgroundColor: Color.fromARGB(255, 230, 245, 248),
          ),
        ],
        onTap: (index) {
          dashboardProvider.changeTab(index, pageController);
        },
      ),
      appBar: dashboardProvider.isSettingsScreen
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(height * 0.09),
              child: AppBar(
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 230, 245, 248),
                leading: Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, top: 12),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      minRadius: 30,
                      child: IconButton(
                        splashColor: white,
                        color: Colors.grey.shade700,
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                  );
                }),
                title: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: TextFormField(
                    style: styleSemiBold,
                    cursorColor: activeCyan,
                    autofocus: false,
                    controller: searchController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      hintText: "Search an event",
                      labelStyle: const TextStyle(
                        color: activeCyan,
                      ),
                      hintStyle: styleLight,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: activeCyan,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: IconButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (searchController.text.isNotEmpty) {
                          loadingProvider.setLoading(true);
                          SearchModel? searchModel = await searchDataRepo
                              .allEvent(searchController.text);
                          loadingProvider.setLoading(false);
                          if (searchModel!.data!.isEmpty) {
                            // ignore: use_build_context_synchronously
                            utils.showSnackBar(
                                context: context, content: "No event found!");
                          } else if (searchModel.data!.isNotEmpty) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResult(searchModel),
                              ),
                            );
                          } else {
                            // ignore: use_build_context_synchronously
                            utils.showSnackBar(
                                context: context,
                                content: "Failed to search event!");
                          }
                        } else {
                          utils.showSnackBar(
                              context: context,
                              content: "Please input event name to search!");
                        }
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                      ),
                      color: activeCyan,
                      iconSize: 25,
                    ),
                  )
                ],
              ),
            ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 230, 245, 248),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.07,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: lightGrey,
                  child: Icon(
                    Icons.person_3_outlined,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'Hello $fName',
                  style: styleSemiBold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  endIndent: 22,
                  indent: 22,
                  color: counterCyan,
                ),
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  dashboardProvider.changeTab(1, pageController);
                  await userDataRepo.fetchUserProfile().then(
                        (value) => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfile(value),
                            ),
                          ),
                        },
                      );
                },
                leading: const Icon(
                  Icons.person_3_outlined,
                  size: 24,
                  color: counterCyan,
                ),
                title: Text(
                  'My Profile',
                  style: styleRegular,
                ),
              ),
              ListTile(
                //onTap: () {},
                leading: Icon(
                  Icons.favorite_border_rounded,
                  size: 24,
                  color: Colors.grey.shade600,
                ),
                title: Text(
                  'Favourites',
                  style: styleRegular,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  dashboardProvider.changeTab(0, pageController);
                },
                leading: const Icon(
                  Icons.event_available_sharp,
                  size: 24,
                  color: counterCyan,
                ),
                title: Text(
                  'My Events',
                  style: styleRegular,
                ),
              ),
              ListTile(
                //onTap: () {},
                leading: Icon(
                  Icons.notifications_on_outlined,
                  size: 24,
                  color: Colors.grey.shade600,
                ),
                title: Text(
                  'Notifications',
                  style: styleRegular,
                ),
              ),
            ],
          ),
        ),
      ),
      body: (loadingProvider.isLoading)
          ? const Loading()
          : PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: tabs,
            ),
    );
  }
}
