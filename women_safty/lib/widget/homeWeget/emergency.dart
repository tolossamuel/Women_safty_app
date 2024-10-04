import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safty/widget/homeWeget/Emergency/alarm.dart';
import 'package:women_safty/widget/homeWeget/Emergency/ambulance.dart';
import 'package:women_safty/widget/homeWeget/Emergency/arm.dart';
import 'package:women_safty/widget/homeWeget/Emergency/fire.dart';


class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);
  void phoneCall(String address) {
   
     launch('tel://' + address);
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.46,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: (){
              phoneCall('100');
            },
            child: PoliceEmergency()),
          GestureDetector(
            onTap: (){
              phoneCall('102');
            },
            child: AmbulanceEmergency()),
          GestureDetector(
            onTap: (){
              phoneCall('101');
            },
            child: FirebrigadeEmergency()),
          GestureDetector(
            onTap: (){
              phoneCall('112');
            },
            child: ArmyEmergency()),
        ],
      ),
    );
  }
}