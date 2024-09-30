

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:women_safty/futures/auth/domain/usecase/atuh_usecase.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_event.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_state.dart';

class AuthBloc  extends Bloc<AuthEvent,AuthState>{

  final AuthUsecase authUsecase;

  AuthBloc ({
    
    required this.authUsecase
  }):super(AuthInitial()){
    String email = '';
    String password = '';
    String confirmPassword = '';
    String guardianEmail = '';
    String phoneNumber = '';
    String name = '';

    on<AuthInput>(
      (event,emit) {
        if (event.indicatore.contains('guardian') ) {
          guardianEmail = event.text;
        }
        else if (event.indicatore.contains('child') ) {
          guardianEmail = event.text;
        }
        else if (event.indicatore.contains('email')){
          email = event.text;
        } 
        else if (event.indicatore.contains('retype')){
          confirmPassword = event.text;
        } 
        else if (event.indicatore.contains('phone')){
          phoneNumber = event.text;
        } 
        else if (event.indicatore.contains('name')){
          name = event.text;
        } 
        else if (event.indicatore.contains('password')) {
          password = event.text;
        }
      }
    );
    on<SignIn>(
      
      (event,emit) async {
      print(email);
      print(password);
      
        if (email.isEmpty) {
        
          emit(AuthError(message: "email cant be null"));
          
        } 
        else if (!EmailValidator.validate(email)) {
        
          
            
            emit(AuthError(message: 'invalid-email'));
          
        } 
        
        else if (password.isEmpty) {
          emit(AuthError(message: "password cant be null"));
        } 
       
        else {
          print(1234555);
        emit(AuthLoading());
        final result = await authUsecase.signInWithEmailPassword(email, password);
        result.fold(
          (failure){

            emit(AuthFailure(message: "email or password is not correct"));
          },
          (data) {
            emit(AuthSuccess(authEntity: data));
          }
        );
        }
      }
    );

    on<SignUp>(
      (event,emit) async {
        print('=============-----');
        
        if (name.isEmpty) {
          emit(AuthError(message: "name cant be null"));
          
        } 
        else if (phoneNumber.isEmpty) {
          emit(AuthError(message: "phone Number cant be null"));
        } 
        else if (email.isEmpty) {
          emit(AuthError(message: "Email cant be null"));
          
        } 
        else if (!EmailValidator.validate(email)){
            
            emit(AuthError(message: 'invalid-email'));
          }
        
        else if (guardianEmail.isEmpty) {
          emit(AuthError(message: "guardian Email cant be null"));
          
        } 
       
          else if (!EmailValidator.validate(guardianEmail)){
            emit(AuthError(message: 'invalid guardian email'));
          }
        
        
        else if (password.isEmpty) {
          emit(AuthError(message: "password cant be null"));
        } 
        else if (password != confirmPassword) {
          emit(AuthError(message: "password  is not similare"));
        } 
   
        else {
          print(1234);
        emit(AuthLoading());

        final result = await authUsecase.signUp(name,email,guardianEmail,phoneNumber,password);
        result.fold(
          (failure){
            emit(AuthFailure(message: failure.message));
          },
          (data) {
            emit(AuthSuccess(authEntity: data));
          }
        );
        }
      }
    );

    on<SignOut>(
      (event,emit) async{
        emit(AuthLoading());
        final result = await authUsecase.signOut();
        result.fold(
          (failure){
            emit(AuthFailure(message: failure.message));
          },
          (data) {
            emit(AuthLogoutSeccuss(logedout: data));
          }
        );
      }
    );
  }

}