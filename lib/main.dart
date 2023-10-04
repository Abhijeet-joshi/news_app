import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_news/api/india_news_api.dart';
import 'package:india_news/api/us_news_api.dart';
import 'package:india_news/database/saved_news.dart';
import 'package:india_news/newsBloc/news_bloc.dart';
import 'package:india_news/savedNewsBloc/saved_news_bloc.dart';
import 'package:india_news/screens/dashboard.dart';
import 'package:india_news/usBloc/us_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NewsBloc(indiaNewsAPI: IndiaNewsAPI()),
    child: BlocProvider(
      create: (context) => UsBloc(usNewsAPI: USNewsAPI()),
      child: BlocProvider(
        create: (context) => SavedNewsBloc(savedNews: SavedNews()),
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }

}


