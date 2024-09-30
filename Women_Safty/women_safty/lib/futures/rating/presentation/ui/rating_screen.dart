import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/bottom_bar/bottom_bar.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_bloc.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_event.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_state.dart';
import 'package:women_safty/futures/rating/presentation/widget/rating_container.dart';
import 'package:women_safty/futures/rating/presentation/widget/rating_input.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          context.read<RatingBloc>().add(GetRating());
          print(1234);
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: const Customtext(
                text: 'Give Rating',
                color: Colors.white,
                size: 25,
                weight: FontWeight.bold),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const RatingDialog();  // Display the RatingDialog UI
                    },
                  );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    color: Colors.blue,
                    child: const Center(
                      child: Customtext(
                          text: 'Press Here To give Your Rating',
                          color: Colors.white,
                          size: 17,
                          weight: FontWeight.normal),
                    ),
                  ),
                ),
                BlocBuilder<RatingBloc, RatingState>(

                  builder: (context, state) {
                    if (state is RatingLoadingState) {
                      return const Expanded(child: Center(child: CircularProgressIndicator(),));
                    }
                    else if (state is RatingSuccessState){
                      final listData = state.ratingEntity.rating;
                      return Expanded(
                      // This ensures the ListView takes available space
                      child: ListView.builder(
                        itemCount: listData.length, // Number of rating items
                        itemBuilder: (context, index) {
                          final current = listData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0), // Space between items
                            child: RatingContainer(
                              title: current['title'],
                              detail: current['detail'],
                              star: current['star'],
                            ),
                          );
                        },
                      ),
                    );
                    }
                    else {
                    return  Expanded(
                      // This ensures the ListView takes available space
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            context.read<RatingBloc>().add(GetRating());
                          },
                          child: Container(
                            color: Colors.blue,
                            padding: const EdgeInsets.all(10),
                            child: const Text('Try Again'),
                          ),
                        ),
                      )
                    );
                    }
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomBar(
            indicatore: 5,
          ),
        ),
      ),
    );
  }
}
