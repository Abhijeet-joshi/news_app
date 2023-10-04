import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:india_news/models/news_model.dart';
import 'package:meta/meta.dart';

import '../api/india_news_api.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  IndiaNewsAPI indiaNewsAPI;
  NewsBloc({required this.indiaNewsAPI}) : super(NewsInitialState()) {
    on<GetLatestNews>((event, emit) async{

      emit(NewsLoadingState());
      var res = await indiaNewsAPI.getAPI(CAT: event.CAT==null? "general" : event.CAT!);
      if(res!=null){
        emit(NewsLoadedState(mModel: NewsModel.fromJson(res)));
      }else{
        emit(NewsErrorState(errorMsg: "Internet Error"));
      }
    });

  }
}
