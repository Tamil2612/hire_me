import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class IntroScreenTwo extends StatelessWidget {
  const IntroScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(24.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Boost Your Career!",
            style: TextStyle(fontSize: 30.sp, height: 1.2),
          ),
           SizedBox(
            height: 16.h,
          ),
          Text(
            "Unlock your potential and elevate your career journey. Discover jobs tailored just for you, get real-time notifications so you never miss an opportunity, and access expert career advice to shine in your job search. Your dream job is just a tap away. Get started now!",
            style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade300),
          ),
           SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Lottie.asset(
              'assets/animation/love_app.json',
            ),
          ),
        ],
      ),
    );
  }
}
