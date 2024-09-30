

abstract class AuthEvent {}

class SignIn extends AuthEvent {


  SignIn();
}

class SignUp extends AuthEvent {}

class SignOut extends AuthEvent {}

class AuthInput extends AuthEvent{
  final String indicatore;
  final String text;
  AuthInput ({
    required this.indicatore,
    this.text = '',
 
  });
}