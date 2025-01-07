import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopLocation extends StatefulWidget {
  final double lat;
  final double lng;
  final String address;

  const ShopLocation({
    super.key,
    required this.lat,
    required this.lng,
    required this.address,
  });
  @override
  State<ShopLocation> createState() => _LocationState();
}

class _LocationState extends State<ShopLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  var myMarkers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: GoogleMap(
        mapType: MapType.terrain,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.lng),
          zoom: 15,
        ),
        onTap: (argument) async {},
        onMapCreated: (GoogleMapController googleMapController) async {
          _controller.complete(googleMapController);
          setState(() {
            myMarkers.add(
              Marker(
                markerId: const MarkerId('1'),
                position: LatLng(widget.lat, widget.lng),
                infoWindow: InfoWindow(
                  title: widget.address,
                ),
                onTap: () {},
              ),
            );
          });
        },
        markers: myMarkers,
      ),
    );
  }
}
