import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hire_me/models/user_details_model.dart';
import 'package:hire_me/ui/home/widgets/custom_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth_service.dart';
import '../../generated/assets.dart';
import '../../models/job_model.dart';
import '../../utils/color_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool isLoading = true;
  List<Job> jobs = [];
  final AuthService _authService = AuthService();
  GetUserDetailsResponse? getUserDetailsResponse;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchUserDetails();
    _populateJobs();
  }

  Future<void> _fetchUserDetails() async {
    getUserDetailsResponse = await _authService.getUserDetails();
    log("getUserDetailsResponse : $getUserDetailsResponse");

    setState(() {
      isLoading = false;
    });

    if (getUserDetailsResponse != null) {}
  }


  void _populateJobs() {
    jobs = [
      Job(
          title: 'Sr. Ux Designer',
          company: 'Google',
          location: 'Chennai',
          experience: '3 years exp.',
          jobType: 'Full-Time',
          description:
              'UX designers conduct user research, interviews and surveys, and use the information to create sitemaps, customer journey maps, wireframes, and prototypes.',
          postedTime: 'Posted 2 days ago',
          salary: '\$50k/month',
          image: Assets.imagesGoogle),
      Job(
          title: 'Software Engineer',
          company: 'Facebook',
          location: 'Chennai',
          experience: '2 years exp.',
          jobType: 'Full-Time',
          description:
              'Software engineers design, develop, and maintain software applications and systems.',
          postedTime: 'Posted 5 days ago',
          salary: '\$120k/year',
          image: Assets.imagesFacebook),
      Job(
          title: 'Art Director',
          company: 'Instagram',
          location: 'Chennai',
          experience: '6+ years exp.',
          jobType: 'Full-Time',
          description:
              'As an Art Director, you will be involved in every aspect of the design and development process —  from conceptualizing products and experiences, to directing and/or executing design and art assets, to supporting the development of technical capabilities that power products and experiences. ',
          postedTime: 'Posted 16 days ago',
          salary: '\$120k/year',
          image: Assets.imagesInstagram),
      Job(
          title: 'Product Designer',
          company: 'Whatsapp',
          location: 'Chennai',
          experience: '4+ years exp.',
          jobType: 'Full-Time',
          description:
              'We’re looking for an experienced visual and systems designer to join WhatsApp’s Foundations team. Our mission is to enable teams to design better interfaces, ship faster, and improve the experience for everyone through quality and accessibility. ',
          postedTime: 'Posted 5 days ago',
          salary: '\$120k/year',
          image: Assets.imagesWhatsapp),
      // Add more jobs as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: ColorResources.primaryColor, size: 50),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          title:
                              getUserDetailsResponse?.data?.companyName != null
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: Text(
                                        "Welcome, ${getUserDetailsResponse?.data?.companyName} 👋",
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: Text(
                                        "Welcome, ${getUserDetailsResponse?.data?.userName} 👋",
                                      ),
                                    ),
                          pinned: true,
                          floating: true,
                          expandedHeight: 80.h,
                          forceElevated: innerBoxIsScrolled,
                          shadowColor: Colors.transparent,
                          backgroundColor: ColorResources.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(40.r),
                            ),
                          ),
                          bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(0),
                              child: Container()),
                          actions: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, right: 10.w),
                              child: CircleAvatar(
                                backgroundImage:
                                    const AssetImage(Assets.imagesProf),
                                backgroundColor: const Color(0x0ff9f9f9),
                                radius: 25.r,
                              ),
                            ),
                          ],
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 8.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 85.h,
                              child: buildFloatingSearchBar(),
                            ),
                            ...jobs.map((job) => Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: CustomPaintWidget(
                                    job: job,
                                    onViewPressed: () {
                                      // Handle view button press
                                    },
                                  ),
                                )),
                            ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('loginDone', false);
                                await FirebaseAuth.instance.signOut();
                                if (context.mounted) {
                                  context.pushReplacement("/login");
                                }
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Search...',
      backdropColor: Colors.transparent,
      borderRadius: BorderRadius.circular(15.r),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600.w : 500.w,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112.h, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
