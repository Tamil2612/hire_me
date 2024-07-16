import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hire_me/utils/color_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpModal extends StatelessWidget {
  const SignUpModal({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(8.0.w),
      child: Column(
        children: [
          Text(
            "What are you looking for?",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600,color: ColorResources.primaryColor),
          ),
           SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               SizedBox(
                height: 100.h,
                width: 100.w,
                child: GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('registerType', "employee");
                    if(context.mounted){
                      context.pushReplacement('/register');
                    }
                  },
                  child: Card(
                    shadowColor: ColorResources.primaryColor,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 10,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: ColorResources.primaryColor.withOpacity(0.2)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: const HeroIcon(
                              HeroIcons.user,
                              color: ColorResources.primaryColor,
                            ),
                          ),
                        ),
                        const Text(
                          "Employee",
                          style: TextStyle(color: ColorResources.primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('registerType', "jobs");
                    if(context.mounted){
                      context.pushReplacement('/register');
                    }
                  },
                  child: Card(
                    shadowColor: ColorResources.primaryColor,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 10,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: ColorResources.primaryColor.withOpacity(0.2)
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: const HeroIcon(HeroIcons.briefcase,
                                color: ColorResources.primaryColor),
                          ),
                        ),
                        const Text("Job",
                            style: TextStyle(color: ColorResources.primaryColor))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
