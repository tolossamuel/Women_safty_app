import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_bloc.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_event.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_state.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    bool indicatore = false;

    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactErrorState) {
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
        } else if (state is ContactLoadingState){
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
        title: const Text('Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onChanged: (value) {
                context
                    .read<ContactBloc>()
                    .add(InputContact(indicatore: 1, text: value));
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter contact emial',
              ),
            ),
            
            TextFormField(
              onChanged: (value) {
                context
                    .read<ContactBloc>()
                    .add(InputContact(indicatore: 2, text: value));
              },
              decoration: const InputDecoration(
                labelText: 'Phone',
                hintText: 'Enter contact phone',
              ),
           // Allow multi-line input for the detail field
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
              context.read<ContactBloc>().add(AddContactEvent());// Close the dialog after "Save"
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
