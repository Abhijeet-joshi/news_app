part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState{}

class NewsLoadedState extends NewsState{
  NewsModel mModel;
  NewsLoadedState({required this.mModel});
}

class NewsErrorState extends NewsState{
  String errorMsg;
  NewsErrorState({required this.errorMsg});
}
