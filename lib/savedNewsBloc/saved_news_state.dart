part of 'saved_news_bloc.dart';

@immutable
abstract class SavedNewsState {}

class SavedNewsInitialState extends SavedNewsState {}

class SavedNewsLoadingState extends SavedNewsState{}

class SavedNewsLoadedState extends SavedNewsState{
  List<Map<String, dynamic>> arrData;
  SavedNewsLoadedState({required this.arrData});
}

class SavedNewsErrorState extends SavedNewsState{
  String errorMsg;
  SavedNewsErrorState({required this.errorMsg});
}

