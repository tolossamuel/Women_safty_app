

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/contact/domain/usecase/contact_usecase.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_event.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent,ContactState>{
  final ContactUsecase contactUsecase;
  ContactBloc({required this.contactUsecase}) : super(ContactInitialState()) {
    String contact = '';
    String phone = '';
    on<InputContact>(
      (event, emit) {
      if(event.indicatore == 1){
        contact = event.text;
      } else {
        phone = event.text;
      }
      emit(state);
    });
    on<GetContactEvent>(
      (event, emit) async {

      emit(const ContactLoadingState());
      final result = await contactUsecase.getContact();
      result.fold((l) => emit(ContactErrorState(message: l.message),), (r) => emit(ContactLoadedState(contact: r)));
    });

    on<AddContactEvent>(
      (event, emit) async {
        if(contact.isEmpty || phone.isEmpty){
          emit(const ContactErrorState(message: 'Please fill all the fields'));
       
        }
        else {
          emit(const ContactLoadingState());
          final result = await contactUsecase.addContact(contact, phone);
          result.fold((l) => emit(ContactErrorState(message: l.message),), (r) => emit(ContactLoadedState(contact: r)));
        }
    });
  }
}