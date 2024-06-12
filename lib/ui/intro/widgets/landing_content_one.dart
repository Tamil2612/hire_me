import 'package:flutter/material.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Discover Your Dream Job!",
            style:TextStyle(fontSize: 30,height:1.2),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Step into a world of opportunities and find the job that fits you best. Create a standout profile to catch the eyes of top employers, receive personalized job recommendations, and stay ahead with instant notifications.  Start your journey with us today!",
            style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade300),
          ),
        ],
      ),
    );
  }
}
