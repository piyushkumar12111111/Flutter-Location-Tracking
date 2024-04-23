import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class LocationWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  // Constructor requiring latitude and longitude
  const LocationWidget({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String _address = "Unknown";

  @override
  void initState() {
    super.initState();
    _getAddressFromLatLng(widget.latitude, widget.longitude);
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];  // Using the first returned result
        setState(() {
          _address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        });
      } else {
        setState(() {
          _address = "No address available";
        });
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        _address = "Failed to get address";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Coordinates: (${widget.latitude}, ${widget.longitude})'),
        SizedBox(height: 10),
        Text('Address: $_address'),
      ],
    );
  }
}
