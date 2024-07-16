import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Discover Your Dream Job!",
            style:TextStyle(fontSize: 30.sp,height:1.2),
          ),
           SizedBox(
            height: 16.sp,
          ),
          Text(
            "Step into a world of opportunities and find the job that fits you best. Create a standout profile to catch the eyes of top employers, receive personalized job recommendations, and stay ahead with instant notifications.  Start your journey with us today!",
            style: TextStyle(fontSize: 14.sp, color: Colors.blueGrey.shade300),
          ),
        ],
      ),
    );
  }
}
