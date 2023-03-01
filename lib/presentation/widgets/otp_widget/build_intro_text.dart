import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps/utils/my_colors.dart';

class BuildIntoText extends StatelessWidget {
  const BuildIntoText({
    Key? key,
    required this.phonNumber,
  }) : super(key: key);
  final String phonNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'verify  your phone number ?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
        SizedBox(
          height: 22.h,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: 'please enter your 6 code number send to ',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: phonNumber,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
                color: MyColor.blue,
                height: 1.1.h),
          ),
        ]))
      ],
    );
  }
}
