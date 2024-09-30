

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/guardina_homepage/domain/usecase/guardian_usecase.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_event.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_state.dart';

class GuardianBloc extends Bloc<GuardianEvent,GuardianState>{
  final GuardianUsecase guardianUsecase;

  GuardianBloc({
    required this.guardianUsecase
  }): super(GuardianIntialState()) {
    on<GetChildren>(
    (event,emit) async{
      emit(GuardianLoadingState());
      final result = await guardianUsecase.getChildren();
      result.fold(
        (l) => emit(GuardianErrorState(message: l.message)), 
        (r) => emit(GuardianSuccessState(guardianEntity: r)));
    }
    );
    on<GetGardian>(
    (event,emit) async{
      emit(GuardianLoadingState());
      
      final result = await guardianUsecase.getGardian();
      result.fold(
        (l) => emit(GuardianErrorState(message: l.message)), 
        (r) => emit(GuardianSuccessState(guardianEntity: r)));
    }
    );
  }
  

  
  
}