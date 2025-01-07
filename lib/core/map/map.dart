// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:collection';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import '../constants/colors.dart';
import '../service/cubit/app_cubit.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import 'location_helper.dart';

class MapScreen extends StatefulWidget {
  final bool? isTab;
  const MapScreen({super.key, this.isTab = false});
  @override
  State<MapScreen> createState() => _LocationState();
}

class _LocationState extends State<MapScreen> {
  static Position? position;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  var myMarkers = HashSet<Marker>();

  @override
  void initState() {
    getMyCurrentLocation();
    super.initState();
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.determinePosition().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 600.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
          ),
          child: Stack(
            children: [
              position != null
                  ? GoogleMap(
                      mapType: MapType.terrain,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(position!.latitude, position!.longitude),
                        zoom: 15,
                      ),
                      onTap: (argument) async {
                        myMarkers.clear();
                        final placeMarks = await placemarkFromCoordinates(
                          argument.latitude,
                          argument.longitude,
                        );
                        AppCubit.get(context).changeAddress(
                          newAddress: placeMarks[0].street ?? "",
                        );
                        debugPrint(AppCubit.get(context).address);
                        setState(() {
                          AppCubit.get(context).lat = argument.latitude;
                          AppCubit.get(context).lng = argument.longitude;
                          debugPrint(
                              "${AppCubit.get(context).lat} + ${AppCubit.get(context).lng}");
                        });

                        myMarkers.add(Marker(
                          markerId: const MarkerId("2"),
                          position: argument,
                          infoWindow:
                              InfoWindow(title: AppCubit.get(context).address),
                          onTap: () {},
                        ));
                      },
                      onMapCreated:
                          (GoogleMapController googleMapController) async {
                        _controller.complete(googleMapController);
                        final placeMarks = await placemarkFromCoordinates(
                            position!.latitude, position!.longitude);
                        setState(() {
                          AppCubit.get(context).changeAddress(
                              newAddress: placeMarks[0].street ?? "");
                          debugPrint(AppCubit.get(context).address);
                          AppCubit.get(context).lat = position!.latitude;
                          AppCubit.get(context).lng = position!.longitude;
                          debugPrint(AppCubit.get(context).lat.toString());
                          debugPrint(AppCubit.get(context).lng.toString());
                          myMarkers.add(
                            Marker(
                              markerId: const MarkerId('1'),
                              position: LatLng(
                                  position!.latitude, position!.longitude),
                              infoWindow: InfoWindow(
                                title:
                                    AppCubit.get(context).address ?? "location",
                              ),
                              onTap: () {},
                            ),
                          );
                        });
                      },
                      markers: myMarkers,
                    )
                  : const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    ),
              widget.isTab == true
                  ? const SizedBox()
                  : Positioned(
                      bottom: 50.h,
                      right: 0,
                      left: 0,
                      child: AppButton(
                        start: 40.w,
                        end: 40.w,
                        onPressed: () {
                          AppRouter.pop(context);
                        },
                        child: AppText(
                          text: LocaleKeys.confirmLocation.tr(),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          size: 18.sp,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
