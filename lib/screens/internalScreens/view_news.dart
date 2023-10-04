import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_news/savedNewsBloc/saved_news_bloc.dart';
import 'package:india_news/screens/webViews/open_news_url.dart';

import '../../appWidgets/widget_class.dart';

//global variables
String? name;
String? author;
String? title;
String? desc;
String? content;
String? imgUrl;
String? newsUrl;
String? publishedAt;

class ViewNews extends StatefulWidget {
  //constructor variables
  String? c_name;
  String? c_author;
  String? c_title;
  String? c_desc;
  String? c_content;
  String? c_imgUrl;
  String? c_newsUrl;
  String? c_publishedAt;

  ViewNews(this.c_name, this.c_author, this.c_title, this.c_desc,
      this.c_content, this.c_imgUrl, this.c_newsUrl, this.c_publishedAt) {
    name = c_name;
    author = c_author;
    title = c_title;
    desc = c_desc;
    content = c_content;
    imgUrl = c_imgUrl;
    newsUrl = c_newsUrl;
    publishedAt = c_publishedAt;
  }

  @override
  State<ViewNews> createState() => _ViewNewsState();
}

class _ViewNewsState extends State<ViewNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: headerBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSpace(h: 15),
                publisherDetails(),
                vSpace(h: 10),
                newsBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: circularButton(icn: Icons.arrow_back)),
        titleText(
            title: "Indian News Express",
            titleSize: 21,
            weight: FontWeight.bold),
        InkWell(
            onTap: () {
              int id = generateId();
              String temp1 =
                  name == null ? "Unknown Publisher • " : "${name} • ";
              String temp2 = author == null ? "Unknown Author" : "${author}";
              String details = "$temp1$temp2";

              context.read<SavedNewsBloc>().add(AddNewsEvent(
                  id: id.toString(),
                  details: details,
                  title: title == null ? "No Title" : title.toString(),
                  description:
                      desc == null ? "No Description" : desc.toString(),
                  content: content == null ? "No Content" : content.toString(),
                  imgUrl: imgUrl == null
                      ? "https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png"
                      : imgUrl.toString(),
                  newsUrl: newsUrl.toString(),
                  pub: "Published at : ${publishedAt.toString()}"));
            },
            child: circularButton(icn: Icons.save_alt)),
      ],
    );
  }

  Widget publisherDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        descriptionText(
            desc: name == null ? "Unknown Publisher • " : "${name} • ",
            descSize: 15),
        descriptionText(
            desc: author == null ? "Unknown Author" : "${author}",
            descSize: 15),
      ],
    );
  }

  Widget newsBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(
            title: title == null ? "No Title" : title.toString(),
            titleSize: 21),
        vSpace(h: 10),
        Image.network(imgUrl == null
            ? "https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png"
            : imgUrl.toString()),
        vSpace(h: 10),
        descriptionText(
            desc: desc == null ? "No Description" : desc.toString(),
            descSize: 18,
            txtClr: Colors.grey.shade600),
        const Divider(
          color: Colors.grey,
        ),
        vSpace(h: 10),
        descriptionText(
            desc: content == null ? "No Content" : content.toString(),
            descSize: 18,
            txtClr: Colors.grey.shade600),
        vSpace(h: 16),
        titleText(
            title: "Read more at", titleSize: 18, weight: FontWeight.bold),
        InkWell(
          onTap: () {
            String fetchedUrl = newsUrl.toString();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => OpenNews(cUrl: fetchedUrl)));
          },
          child: Text(
            newsUrl.toString(),
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        vSpace(h: 10),
        descriptionText(
            desc: "Published at : ${publishedAt.toString()}",
            descSize: 14,
            txtClr: Colors.grey.shade600),
        vSpace(h: 10),
      ],
    );
  }
}
