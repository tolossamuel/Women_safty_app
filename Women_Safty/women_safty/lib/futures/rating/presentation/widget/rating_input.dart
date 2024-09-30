import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_bloc.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_event.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_state.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    bool indicatore = false;
    return BlocListener<RatingBloc, RatingState>(
      listener: (context, state) {
        if (state is RatingErrorState) {
            if (indicatore) {
              indicatore = false;
              Navigator.pop(context);
            }
            ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 2),
                  ),
                );
        } else if (state is RatingLoadingState){
          indicatore = true;
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
        }
        else {
          if (indicatore) {
              indicatore = false;
              Navigator.pop(context);
            }
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('saved!!'),
                    duration: Duration(seconds: 2),
                  ),
                );
        }
      },
      child: AlertDialog(
        title: const Text('Add Rating'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onChanged: (value) {
                context
                    .read<RatingBloc>()
                    .add(RatingInput(indicatore: 1, text: value));
              },
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter title',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                context
                    .read<RatingBloc>()
                    .add(RatingInput(indicatore: 2, text: value));
              },
              decoration: const InputDecoration(
                labelText: 'Detail',
                hintText: 'Enter detail',
              ),
              maxLines: 3, // Allow multi-line input for the detail field
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                context
                    .read<RatingBloc>()
                    .add(RatingInput(indicatore: 3, text: value));
              },
              decoration: const InputDecoration(
                labelText: 'Rating',
                hintText: 'Enter rating out of 5.0',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<RatingBloc>()
                  .add(AddRating()); // Close the dialog after "Save"
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
