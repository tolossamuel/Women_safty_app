import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safty/utils/constant.dart';
import 'package:women_safty/widget/safewebview.dart';

class Customcarouel extends StatefulWidget {
  final bool trans;
  const Customcarouel({super.key, required this.trans});

  

  @override
  State<Customcarouel> createState() => _CustomcarouelState();
}

class _CustomcarouelState extends State<Customcarouel> {
  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }
  static Future<void> openWebsite(String address) async {
    final Uri url = Uri.parse(address);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(msg: 'Could not launch $address');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: CarouselSlider(
                                options: CarouselOptions(
                                  height: screenWidth * 0.6,
                                  enlargeCenterPage: true,
                                  disableCenter: false,
                                  viewportFraction: .8
                                ),
                                items: List.generate(
                                  articleTitle.length,
                                  
                                  (index) {
                                   
                                    
                                    return CardImage(
                                            webste: openWebsite,
                                            imageUrl: imageSliders[index],
                                            text: widget.trans?articleTitle[index]:translate[index],
                                            webstite: websiteUrl[index],
                                        );
                                        }
                                ),
                              )
    );
  }
}