import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons/heroicons.dart';

import '../../../models/job_model.dart';
import '../../../utils/color_resources.dart';

class CustomPaintWidget extends StatelessWidget {
  final Job job;
  final VoidCallback onViewPressed;

  CustomPaintWidget({
    required this.job,
    required this.onViewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width - 20).w,
          height: 232.h, // Set the desired height
          child: CustomPaint(
            painter: RPSCustomPainter(),
          ),
        ),
        Positioned(
          right: 6,
          top: 5,
          child: GestureDetector(
            onTap: onViewPressed,
            child: Container(
              height: 45.h,
              width: (MediaQuery.of(context).size.width - 285).w,
              decoration: BoxDecoration(
                  color: ColorResources.primaryColor,
                  borderRadius: BorderRadius.circular(20.r)),
              child:  Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                    4.horizontalSpace,
                    const HeroIcon(
                      HeroIcons.arrowTrendingUp,
                      size: 15,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      job.image,
                      height: 50.h,
                      width: 50.w,
                    ),
                  ),
                 10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      6.verticalSpace,
                      Text(
                        job.company,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              12.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(HeroIcons.mapPin, job.location),
                  _buildInfoChip(HeroIcons.academicCap, job.experience),
                  _buildInfoChip(HeroIcons.clock, job.jobType),
                ],
              ),
              12.verticalSpace,
              Text(
                job.description,
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              35.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 20),
                      10.horizontalSpace,
                      Text(
                        job.postedTime,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Text(job.salary),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(HeroIcons icon, String label) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeroIcon(icon, size: 16),
              5.horizontalSpace,
              Text(
                label,
                style: TextStyle(fontSize: 10.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6600366, 0);
    path_0.lineTo(size.width * 0.06016937, 0);
    path_0.cubicTo(
        size.width * 0.04017382,
        0,
        size.width * 0.0001827170,
        size.height * 0.01949009,
        size.width * 0.0001827170,
        size.height * 0.09745043);
    path_0.lineTo(size.width * 0.0001827170, size.height * 0.8728922);
    path_0.cubicTo(
        size.width * -0.001721620,
        size.height * 0.9152586,
        size.width * 0.01046615,
        size.height,
        size.width * 0.07445183,
        size.height);
    path_0.lineTo(size.width * 0.9314031, size.height);
    path_0.cubicTo(
        size.width * 0.9542565,
        size.height * 0.9971767,
        size.width * 0.9999607,
        size.height * 0.9751207,
        size.width * 0.9999607,
        size.height * 0.9073276);
    path_0.lineTo(size.width * 0.9999607, size.height * 0.4267241);
    path_0.cubicTo(
        size.width * 0.9999607,
        size.height * 0.3534483,
        size.width * 0.9909974,
        size.height * 0.2650862,
        size.width * 0.9201571,
        size.height * 0.2650862);
    path_0.lineTo(size.width * 0.8468586, size.height * 0.2650862);
    path_0.cubicTo(
        size.width * 0.8272251,
        size.height * 0.2650862,
        size.width * 0.7968429,
        size.height * 0.2650862,
        size.width * 0.7657068,
        size.height * 0.2435345);
    path_0.cubicTo(
        size.width * 0.7514241,
        size.height * 0.2336483,
        size.width * 0.7172775,
        size.height * 0.1961207,
        size.width * 0.7212042,
        size.height * 0.08620690);
    path_0.cubicTo(size.width * 0.7228979, size.height * 0.03879310,
        size.width * 0.6976440, 0, size.width * 0.6600366, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = ColorResources.primaryColor;
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(0, size.height * 0.7543103);
    path_1.lineTo(size.width, size.height * 0.7543103);
    path_1.lineTo(size.width, size.height * 0.9094828);
    path_1.cubicTo(size.width, size.height * 0.9594741, size.width * 0.9753874,
        size.height, size.width * 0.9450262, size.height);
    path_1.lineTo(size.width * 0.06544503, size.height);
    path_1.cubicTo(size.width * 0.02930079, size.height, 0,
        size.height * 0.9517543, 0, size.height * 0.8922414);
    path_1.lineTo(0, size.height * 0.7543103);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Colors.white.withOpacity(0.7);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
