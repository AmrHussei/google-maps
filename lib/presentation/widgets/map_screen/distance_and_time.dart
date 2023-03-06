import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/place_directions.dart';
import '../../../utils/my_colors.dart';

class DistanceAndTime extends StatelessWidget {
  final PlaceDirections placeDirections;
  // ignore: prefer_typing_uninitialized_variables
  final isTimeAndDistanceVisible;

  const DistanceAndTime(
      {Key? key,
      required this.placeDirections,
      required this.isTimeAndDistanceVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTimeAndDistanceVisible,
      child: Positioned(
        top: 0,
        bottom: 565.h,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.sp),
                ),
                margin: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.access_time_filled,
                    color: MyColor.blue,
                    size: 25.sp,
                  ),
                  title: Text(
                    placeDirections.totalDuration,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30.w,
            ),
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.sp),
                ),
                margin: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.directions_car_filled,
                    color: MyColor.blue,
                    size: 25.sp,
                  ),
                  title: Text(
                    placeDirections.totalDistance,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
