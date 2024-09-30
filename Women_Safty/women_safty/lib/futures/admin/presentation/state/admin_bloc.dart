

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/admin/domain/usecase/admin_usecase.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_event.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent,AdminState>{
  final AdminUsecase adminUsecase;

  AdminBloc({
    required this.adminUsecase
  }):super(AdminIntialState()) {

    on<GetAdminData>(
      (event,emit) async {
        emit(AdminLoadingState());
        final result = await adminUsecase.getGardianData();
        result.fold(
          (l)=> emit(AdminErrorState(message: 'try again')),
          (r) => emit(AdminSuccessState(adminEntity: r)));
      }
    );
  }
}