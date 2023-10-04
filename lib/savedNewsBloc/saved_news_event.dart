part of 'saved_news_bloc.dart';

@immutable
abstract class SavedNewsEvent {}

class AddNewsEvent extends SavedNewsEvent {

  String id;
  String details;
  String title;
  String description;
  String content;
  String imgUrl;
  String newsUrl;
  String pub;

  AddNewsEvent(
      {required this.id,
      required this.details,
      required this.title,
      required this.description,
      required this.content,
      required this.imgUrl,
      required this.newsUrl,
      required this.pub});
}

class GetNewsEvent extends SavedNewsEvent {}

class DeleteNewsEvent extends SavedNewsEvent {
  String id;
  DeleteNewsEvent({required this.id});
}
