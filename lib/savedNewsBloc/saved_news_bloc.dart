import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:india_news/database/saved_news.dart';
import 'package:meta/meta.dart';

part 'saved_news_event.dart';

part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNews savedNews;
  SavedNewsBloc({required this.savedNews}) : super(SavedNewsInitialState()) {
    on<AddNewsEvent>((event, emit) async {
      emit(SavedNewsLoadingState());
      var res = await savedNews.addNews(
          id: event.id,
          details: event.details,
          title: event.title,
          description: event.description,
          content: event.content,
          imgUrl: event.imgUrl,
          newsUrl: event.newsUrl,
          pub: event.pub);
      if(res==true){
        var newData = await savedNews.fetchSavedNews();
        emit(SavedNewsLoadedState(arrData: newData));
      }else{
        emit(SavedNewsErrorState(errorMsg: "Unable to save news"));
      }
    });

    on<GetNewsEvent>((event, emit) async{
      emit(SavedNewsLoadingState());
      var res = await savedNews.fetchSavedNews();
      if(res.isNotEmpty){
        emit(SavedNewsLoadedState(arrData: res));
      }else{
        emit(SavedNewsErrorState(errorMsg: "No Saved News"));
      }
    });

    on<DeleteNewsEvent>((event, emit) async{
      emit(SavedNewsLoadingState());
      var res = await savedNews.deleteNews(event.id);
      if(res==true){
        var refreshedData = await SavedNews().fetchSavedNews();
        emit(SavedNewsLoadedState(arrData: refreshedData));
      }else{
        emit(SavedNewsErrorState(errorMsg: "Unable to delete news"));
      }
    });
  }
}
