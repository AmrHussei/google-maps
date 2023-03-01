import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps/helper/location_helper.dart';
import 'package:maps/utils/my_colors.dart';
import 'package:maps/utils/strings.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  static Position? position;
  Completer<GoogleMapController> MapController = Completer();
  Future<void> getCurrentLocation() async {
    await LocationHelper.getCurrentLocation();

    position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });
  }

  static final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(
      position!.latitude,
      position!.longitude,
    ),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 17,
  );

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        MapController.complete(controller);
      },
    );
  }

  goToMYCurrentLocation() async {
    final GoogleMapController controller = await MapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            position != null
                ? buildMap()
                : const Center(
                    child: CircularProgressIndicator(
                      color: MyColor.blue,
                    ),
                  )
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10.w, 30.h),
          child: FloatingActionButton(
            onPressed: goToMYCurrentLocation,
            child: const Icon(
              Icons.place,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
 /*
   child: BlocProvider<PhoneAuthCubit>(
        create: (context) => PhoneAuthCubit(),
        child: ElevatedButton(
          onPressed: () {
            phoneAuthCubit.logOut();
            Navigator.pushReplacementNamed(context, registerScreen);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(80.w, 40.h),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.sp)),
          ),
          child: Text(
            'Verify',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ),
      ),
 */