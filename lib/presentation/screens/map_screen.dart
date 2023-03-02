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
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../widgets/map_screen/my_drawer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();

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

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: floatingSearchBarController,
      elevation: 6,
      hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey[800]),
      queryStyle: TextStyle(fontSize: 18.sp),
      hint: 'search for place..',
      border: BorderSide(style: BorderStyle.none),
      margins: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: MyColor.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {},
      onFocusChanged: (_) {
        // hide distance and time row
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
              icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
              onPressed: () {}),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            position != null
                ? buildMap()
                : const Center(
                    child: CircularProgressIndicator(
                      color: MyColor.blue,
                    ),
                  ),
            buildFloatingSearchBar(),
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
