

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/homepage/domain/usecase/homepage_usecase.dart';
import 'package:women_safty/futures/homepage/presentation/state/homePageBloc/homepage_event.dart';
import 'package:women_safty/futures/homepage/presentation/state/homePageBloc/homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent,HomepageState>{
  final HomepageUsecase homepageUsecase;
  
  HomepageBloc ({
    
    required this.homepageUsecase
  }):super(HomepageInitial()){

    on<GetHomepage>(
      (event,emit) async {
        emit(HomepageLoading());
        final result = await homepageUsecase.getHomepage();
        result.fold(
          (l) => emit(HomepageError(message: l.message)),
          (r) => emit(HomepageLoaded(homepageEntity: r))
        );
      }
    );
  }
}