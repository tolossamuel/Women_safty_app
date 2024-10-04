import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safty/widget/homeWeget/life_save/location.dart';

class LifeSave extends StatelessWidget {
  const LifeSave({super.key});
  static Future<void> openMap(String place) async {
      String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$place';
      final Uri url = Uri.parse(googleUrl);
      try {
        await launchUrl(url);
      } catch (e) {
        Fluttertoast.showToast(msg: 'showing error');
      }
    }
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:  Row(
                        children: [
                          Locations(
                            location: 'Police Station',
                            locationImage: 'assets/police-badge.png',
                            onmaps: openMap,
                          ),
                           SizedBox(
                            width: 10,
                          ),
                          Locations(
                          location: 'Hospital',
                          locationImage: 'assets/hospital.png',
                          onmaps: openMap,
                        ),
                        SizedBox(
                            width: 10,
                          ),
                          Locations(
                          location: 'Pharmacy',
                          locationImage: 'assets/pharmacy.png',
                          onmaps: openMap,
                        ),
                        SizedBox(
                            width: 5,
                          ),
                          Locations(
                          location: 'Bus Station',
                          locationImage: 'assets/bus-stop.png',
                          onmaps: openMap,
                        )
                        ],
                      ),
                    ),
    );
  }         
}