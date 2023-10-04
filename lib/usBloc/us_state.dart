part of 'us_bloc.dart';

@immutable
abstract class UsState {}

class UsInitialState extends UsState {}

class UsLoadingState extends UsState{}

class UsLoadedState extends UsState{
  USModel usModel;
  UsLoadedState({required this.usModel});
}

class UsErrorState extends UsState{
  String errorMsg;
  UsErrorState({required this.errorMsg});
}

