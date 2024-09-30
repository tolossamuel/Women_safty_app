

import 'package:women_safty/futures/contact/domain/entity/contact_entity.dart';

abstract class ContactState {
  const ContactState();
}

class ContactInitialState extends ContactState {
  const ContactInitialState();
}

class ContactLoadingState extends ContactState {
  const ContactLoadingState();
}

class ContactLoadedState extends ContactState {
  final ContactEntity contact;
  const ContactLoadedState({required this.contact});
}

class ContactErrorState extends ContactState {
  final String message;
  const ContactErrorState({required this.message});
}
