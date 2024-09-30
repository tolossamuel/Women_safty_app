import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safty/core/bottom_bar/bottom_bar.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/homepage/presentation/state/homePageBloc/homepage_bloc.dart';
import 'package:women_safty/futures/homepage/presentation/state/homePageBloc/homepage_event.dart';
import 'package:women_safty/futures/homepage/presentation/state/homePageBloc/homepage_state.dart';
import 'package:women_safty/futures/homepage/presentation/widget/card_image.dart';
import 'package:women_safty/futures/homepage/presentation/widget/center_card.dart';
import 'package:women_safty/futures/homepage/presentation/widget/location.dart';
import 'package:women_safty/futures/homepage/presentation/widget/share_location.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_bloc.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomepageBloc>().add(GetHomepage());
    context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }
  static Future<void> openMap(String place) async {
      String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$place';
      final Uri url = Uri.parse(googleUrl);
      try {
        await launchUrl(url);
      } catch (e) {
        Fluttertoast.showToast(msg: 'showing error');
      }
    }

    static Future<void> webistes(String address) async {
      String googleUrl = address;
      final Uri url = Uri.parse(googleUrl);
      try {
        await launchUrl(url);
      } catch (e) {
        Fluttertoast.showToast(msg: 'showing error');
      }
    }

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Customtext(
                              text: 'We admire',
                              size: 19,
                              color: Colors.grey,
                              weight: FontWeight.bold,
                            ),
                            Customtext(
                              text: 'Your strong personality',
                              size: 20,
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<HomepageBloc, HomepageState>(
                    builder: (context, state) {
                      print(state);
                      
                      if (state is HomepageLoading) {
                        return CarouselSlider(
                                options: CarouselOptions(
                                  height: 240,
                                  enlargeCenterPage: true,
                                  disableCenter: false,
                                  viewportFraction: .8
                                ),
                                items: List.generate(
                                  3,
                                  (index) => const CardImage(
                                            webste: webistes,
                                            imageUrl: '',
                                            text: '',
                                            webstite: '',
                                        )
                                ),
                              );
                      }
                      
                      else if (state is HomepageLoaded) {
                        return CarouselSlider(
                                options: CarouselOptions(
                                  height: screenWidth * 0.6,
                                  enlargeCenterPage: true,
                                  disableCenter: false,
                                  viewportFraction: .8
                                ),
                                items: List.generate(
                                  state.homepageEntity.data.length,
                                  
                                  (index) {
                                   
                                    final String imageUrl = state.homepageEntity.data[index]['imageUrl']?? '';
                                    final String text = state.homepageEntity.data[index]['topicName']?? '';
                                    final String webstite = state.homepageEntity.data[index]['websiteUrl']?? '';
                                    return CardImage(
                                            webste: webistes,
                                            imageUrl: imageUrl,
                                            text: text,
                                            webstite: webstite,
                                        );
                                        }
                                ),
                              );
                      }
                     
                      else {
                        return CarouselSlider(
                                options: CarouselOptions(
                                  height: screenWidth * 0.6,
                                  enlargeCenterPage: true,
                                  disableCenter: false,
                                  viewportFraction: .8
                                ),
                                items: List.generate(
                                  3,
                                  (index) => const CardImage(
                                            webste: webistes,
                                            imageUrl: '',
                                            text: '',
                                            webstite: '',
                                        )
                                ),
                              );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
              
                  const Row(
                    children: [
                      Customtext(
                        text: 'Emergency',
                        size: 24,
                        weight: FontWeight.bold,
                        color: Colors.black,
                      ),
                       Spacer(),
                      Customtext(
                        text: 'View all',
                        size: 15,
                        weight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 162, 255),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  Row(
                      children: [
                          CenterCard(
                          topImage: 'assets/image/alarm.png',
                          message: 'Active Emergency',
                          callNumber: '1-1-5',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CenterCard(
                          topImage: 'assets/image/ambulance.png',
                          message: 'Ambulance',
                          callNumber: '9-8-6',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CenterCard(
                          topImage: 'assets/image/army.png',
                          message: 'NACTA',
                          callNumber: '1-7-1-7',
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
                  const Customtext(text: 'Explore LiveSafe', color: Colors.black, size: 20, weight: FontWeight.bold),
                  const SizedBox(
                    height: 10,
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:  Row(
                      children: [
                        Locations(
                          location: 'Police Station',
                          locationImage: 'assets/image/police-badge.png',
                          onmaps: openMap,
                        ),
                         SizedBox(
                          width: 10,
                        ),
                        Locations(
                        location: 'Hospital',
                        locationImage: 'assets/image/hospital.png',
                        onmaps: openMap,
                      ),
                      SizedBox(
                          width: 10,
                        ),
                        Locations(
                        location: 'Pharmacy',
                        locationImage: 'assets/image/pharmacy.png',
                        onmaps: openMap,
                      ),
                      SizedBox(
                          width: 5,
                        ),
                        Locations(
                        location: 'Bus Station',
                        locationImage: 'assets/image/bus-stop.png',
                        onmaps: openMap,
                      )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShareLocation(),
                ],
              ),
            ),
            
          ),
          
        ),
        bottomNavigationBar: const BottomBar(indicatore: 1,),
      ),
    );
  }
}
