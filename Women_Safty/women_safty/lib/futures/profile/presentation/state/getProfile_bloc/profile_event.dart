

abstract class ProfileEvent {}


class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();
}

class ProfileUpdateEvent extends ProfileEvent {

  ProfileUpdateEvent();

}

class ProfileInput extends ProfileEvent {
  final String name;
  ProfileInput({
    required this.name
  });
}