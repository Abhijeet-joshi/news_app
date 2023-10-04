import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:india_news/models/us_model.dart';
import 'package:meta/meta.dart';

import '../api/us_news_api.dart';

part 'us_event.dart';
part 'us_state.dart';

class UsBloc extends Bloc<UsEvent, UsState> {
  USNewsAPI usNewsAPI;
  UsBloc({required this.usNewsAPI}) : super(UsInitialState()) {
    on<GetUsNews>((event, emit) async{
      emit(UsLoadingState());
      var res = await usNewsAPI.getUsNews();
      if(res!=null){
        emit(UsLoadedState(usModel: USModel.fromJson(res)));
      }else{
        emit(UsErrorState(errorMsg: "Internet Error"));
      }
    });
  }
}
