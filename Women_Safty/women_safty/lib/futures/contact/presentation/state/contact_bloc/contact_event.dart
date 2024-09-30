

abstract class ContactEvent {
  const ContactEvent();
}


class GetContactEvent extends ContactEvent {
  const GetContactEvent();
}

class AddContactEvent extends ContactEvent {
  
  const AddContactEvent();
}

class InputContact extends ContactEvent {
  final String text;
  final int indicatore;
  const InputContact({required this.text, required this.indicatore});
}