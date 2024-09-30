import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_bloc.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_event.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_state.dart';
import 'package:women_safty/futures/admin/presentation/widget/child_show.dart';

class AdminList extends StatelessWidget {
  const AdminList({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Customtext(
            text: 'Guardian Data',
            color: Colors.white,
            size: 25,
            weight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              if (state is AdminLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AdminSuccessState) {
                return ListView.builder(
                  itemCount: state.adminEntity.adminEntity.length,
                  itemBuilder: (context, index) {
                    final current = state.adminEntity.adminEntity[index];
                    return ChildShow(
                      parentEmail: current['guardianEmail'],
                      childEmail: current['email'],
                      childName: current['name'],
                      childPhone: current['phoneNumber'],
                    );
                  },
                );
              } else {
                // Handle error state if necessary
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<AdminBloc>().add(GetAdminData());
                    },
                    child: Container(
                      color: const Color.fromARGB(255, 224, 224, 224),
                      padding: const EdgeInsets.all(5),
                      child: const Customtext(
                        text: 'Try again',
                        color: Colors.black,
                        size: 10,
                        weight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              } 
            },
          ),
        ),
      ),
    );
  }
}
