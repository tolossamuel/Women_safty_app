

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/profile/domain/usecase/profile_usecase.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_event.dart';

import 'profile_state.dart';

class ProfileBloc  extends Bloc<ProfileEvent,ProfileState>{
  final ProfileUsecase profileUsecase;

  ProfileBloc({required this.profileUsecase}) : super(ProfileInitialState()){
    String name = '';
    on<ProfileInput>(
      (event,emit){
        name = event.name;
        emit(state);
      }
    );
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      final result = await profileUsecase.getProfile();
      result.fold((l) => emit(ProfileErrorState(message: l.message)), (r) => emit(ProfileLoaded(profileEntity: r)));
    });

    on<ProfileUpdateEvent>(

      (event,emit) async{
        if (name.isEmpty){
          emit(state);
        } else{
        emit(ProfileLoadingState());
        final result = await profileUsecase.updateProfile(name);
        result.fold((l) {
          
          return emit(ProfileErrorState(message: l.message));}, 
          (r) => emit(ProfileLoaded(profileEntity: r)));
        }
      }
    );
  }



}