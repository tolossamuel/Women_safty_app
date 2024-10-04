import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:url_launcher/url_launcher.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: "Location services are disabled. Please enable them.");
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission denied.");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: "Location permissions are permanently denied.");
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Navigator.pop(context);
      setState(() {
        _currentPosition = position;
      });
      
      Fluttertoast.showToast(
        
          msg: "Current location: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error fetching location: $e");
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final Uri url = Uri.parse(googleUrl);
    try {
      await launchUrl(url);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error launching map: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
  }

  showModelSafeHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.4,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SEND YOUR CURRENT LOCATION IMMEDIATELY TO YOUR EMERGENCY CONTACTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                PrimaryButton(
                  title: "GET LOCATION",
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    await _getCurrentLocation();
                  },
                ),
                SizedBox(height: 10),
                PrimaryButton(
                  title: "OPEN MAP",
                  onPressed: () async {
                    if (_currentPosition != null) {
                      await openMap(
                          _currentPosition!.latitude, _currentPosition!.longitude);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      await _getCurrentLocation();
                      await openMap(
                          _currentPosition!.latitude, _currentPosition!.longitude);
                      
                    }
                  },
                ),
                SizedBox(height: 10),
                
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Send Location"),
                      subtitle: Text("Share Location"),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/route.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  PrimaryButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
