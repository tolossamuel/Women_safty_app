

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/message/domain/usecase/messages_usecase.dart';
import 'package:women_safty/futures/message/presentation/state/messages_event.dart';
import 'package:women_safty/futures/message/presentation/state/messages_state.dart';

class MessagesBloc  extends Bloc<MessagesEvent,MessagesState>{
  final MessagesUsecase messagesUsecase;

  MessagesBloc({required this.messagesUsecase}) : super(MessagesInitialState()){
    String messages = '';
    on<SendMessages>(
            
            (event, emit) async {
              if(messages.isEmpty){
                emit(state);
                return ;
              }
            emit(MessagesLoadingState());
            final result = await messagesUsecase.sendMessage(event.imageUrl, messages, event.soundUrl, event.senderEmail, event.receiverEmail);
            result.fold(
              (l) => emit(MessageErrorState(message: l.message)),
              (r) {
                print(123456);
                messages = '';
                return emit(MessagesLoadedState(messages: r));
              }
            );
        }
    );

    on<GetMessages>(
        (event, emit) async {
        emit(MessagesLoadingState());
        final result = await messagesUsecase.getMessages(event.userEmail, event.otherEmail);
        result.fold(
          (l) => emit(MessageErrorState(message: l.message)),
          (r) => emit(MessagesLoadedState(messages: r)));
        }
    );
    on<MessageInput>(
      (event,emit) {
        messages = event.text;
        emit(state);
      }
    );
  }
}