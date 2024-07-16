import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


class IntroScreenThree extends StatelessWidget {
  const IntroScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(24.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Unlock Opportunities",
            style: TextStyle(fontSize: 30.sp, height: 1.2),
          ),
           SizedBox(
            height: 16.h,
          ),
          Text(
            "Experience a job search like never before. Our intuitive platform connects you with the best opportunities that match your skills and aspirations. Easily browse through job listings, apply with a tap, and track your application progress in real-time. With tailored job alerts and expert career advice, you're always in the know and ahead of the game. Dive into a world of possibilities and unlock your future with us. Start now and transform your career path!",
            style: TextStyle(fontSize: 14.sp, color: Colors.blueGrey.shade300),
          ),
           SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Lottie.asset(
              'assets/animation/job_opp.json',
            ),
          ),
        ],
      ),
    );
  }
}
