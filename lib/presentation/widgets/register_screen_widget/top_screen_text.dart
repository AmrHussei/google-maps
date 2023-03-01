import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopScreenText extends StatelessWidget {
  const TopScreenText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is your phone number ?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
        SizedBox(
          height: 22.h,
        ),
        Text(
          'Please enter your phone number to verify your account .',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.sp),
        ),
      ],
    );
  }
}
