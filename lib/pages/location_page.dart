import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? mapCtrl;
  LatLng? coords;
  double dist = 0;
  StreamSubscription? locUpdate;
  Position? lastPos;

  @override
  void initState() {
    super.initState();
    track();
  }

  Future track() async {
    var perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.deniedForever ||
        perm == LocationPermission.denied)
      return;

    locUpdate = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((pos) {
      var newCoords = LatLng(pos.latitude, pos.longitude);
      if (lastPos != null) {
        dist += Geolocator.distanceBetween(
          lastPos!.latitude,
          lastPos!.longitude,
          pos.latitude,
          pos.longitude,
        );
      }
      setState(() {
        coords = newCoords;
        lastPos = pos;
      });
      mapCtrl?.animateCamera(CameraUpdate.newLatLng(newCoords));
    });
  }

  @override
  void dispose() {
    locUpdate?.cancel();
    mapCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: coords ?? const LatLng(6.9271, 79.8612),
              zoom: 13,
            ),
            onMapCreated: (ctrl) => mapCtrl = ctrl,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 35,
            left: 50,
            right: 70,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
              decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Distance: ${dist.toStringAsFixed(2)} m',
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
