import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'landing_content_one.dart';
import 'landing_content_two.dart';
import 'landing_content_three.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({super.key});

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  String _getButtonText(double page) {
    if (page >= 1.5) {
      return "Get Started";
    } else if (page >= 0.5) {
      return "Next";
    } else {
      return "Next";
    }
  }

  double _getButtonBottomPosition(double page) {
    if (page >= 1.5) {
      return 330;
    } else if (page >= 0.5) {
      return 250;
    } else {
      return 50;
    }
  }

  double _getButtonSize(double page) {
    if (page >= 1.5) {
      return 80;
    } else if (page >= 0.5) {
      return 40;
    } else {
      return 40;
    }
  }

  Future<void> _onIntroCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showIntro', false);
    if (context.mounted) {
      context.pushReplacement("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h +
          (_pageController.hasClients ? _pageController.page ?? 0 : 0) * 160.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(height: 16.h),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: const [
                    IntroScreenOne(),
                    IntroScreenTwo(),
                    IntroScreenThree(),
                  ],
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
                height: 50.h,
                bottom: _getButtonBottomPosition(_pageController.page ?? 0),
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    if (_pageController.page!.round() < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );
                    } else {
                      _onIntroCompleted();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.4, 0.8],
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ],
                      ),
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: _getButtonSize(_pageController.page ?? 0),
                            child: Text(
                              _getButtonText(_pageController.page ?? 0),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 24,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
