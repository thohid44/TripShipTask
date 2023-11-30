
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LiveLocationTracker extends StatefulWidget {
  @override
  _LiveLocationTrackerState createState() => _LiveLocationTrackerState();
}

class _LiveLocationTrackerState extends State<LiveLocationTracker> {
  GoogleMapController? _mapController;
  Location _location = Location();
  LatLng? _sourceLocation;
  LatLng? _destinationLocation;
  List<LatLng> _locationList = [];

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _sourceLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _locationList.add(_sourceLocation!);
        _mapController!.animateCamera(CameraUpdate.newLatLng(_sourceLocation!));
      });
    });

    _destinationLocation = LatLng(22.895445, 91.533592); // Replace with your destination coordinates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location Tracker'),
        centerTitle: true,
         backgroundColor: Colors.amber,
         elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GoogleMap(
      
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: 13.5,
          ),
          markers: Set<Marker>.from([
            if (_sourceLocation != null)
              Marker(
                markerId: const MarkerId('source'),
                position: _sourceLocation!,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                infoWindow: const InfoWindow(title: 'Source'),
              ),
            if (_destinationLocation != null)
              Marker(
                markerId: const MarkerId('destination'),
                position: _destinationLocation!,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                infoWindow: const InfoWindow(title: 'Destination'),
              ),
          ]),
          polylines: Set<Polyline>.from([
            if (_locationList.isNotEmpty)
              Polyline(
                polylineId: const PolylineId('route'),
                color: Colors.blue,
                width: 5,
                points: _locationList,
              ),
          ]),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: LiveLocationTracker()));
}
