part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class GetLatestNews extends NewsEvent{
  String? CAT;
  GetLatestNews({this.CAT});
}
