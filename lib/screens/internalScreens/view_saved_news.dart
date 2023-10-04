import 'package:flutter/material.dart';

import '../../appWidgets/widget_class.dart';
import '../webViews/open_news_url.dart';

String? mPubDet, mTitle, mImgUrl, mDesc, mContent, mUrl, mPubAt;

class ViewSavedNews extends StatefulWidget {
  String cPubDet, cTitle, cImgUrl, cDesc, cContent, cUrl, cPubAt;

  ViewSavedNews(
      {required this.cPubDet,
      required this.cTitle,
      required this.cImgUrl,
      required this.cDesc,
      required this.cContent,
      required this.cUrl,
      required this.cPubAt}){

    mPubDet = cPubDet;
    mTitle = cTitle;
    mImgUrl = cImgUrl;
    mDesc = cDesc;
    mContent = cContent;
    mUrl = cUrl;
    mPubAt = cPubAt;

  }

  @override
  State<ViewSavedNews> createState() => _ViewSavedNewsState();
}

class _ViewSavedNewsState extends State<ViewSavedNews> {
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: circularButton(icn: Icons.arrow_back)),
        hSpace(w: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(
                title: "Indian News Express",
                titleSize: 21,
                weight: FontWeight.bold),
            descriptionText(desc: "Saved news", descSize: 15),
          ],
        ),

      ],
    );
  }

  Widget publisherDetails() {
    return descriptionText(desc: mPubDet.toString(), descSize: 15);
  }

  Widget newsBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(title: mTitle.toString(), titleSize: 21),
        vSpace(h: 10),
        Image.network(mImgUrl.toString()),
        vSpace(h: 10),
        descriptionText(desc: mDesc.toString(), descSize: 18, txtClr: Colors.grey.shade600),
        const Divider(
          color: Colors.grey,
        ),
        vSpace(h: 10),
        descriptionText(desc: mContent.toString(), descSize: 18, txtClr: Colors.grey.shade600),
        vSpace(h: 16),
        titleText(title: "Read more at", titleSize: 18, weight: FontWeight.bold),
        InkWell(
            onTap: (){
              String fetchedUrl = mUrl.toString();
              Navigator.push(context, MaterialPageRoute(builder: (builder) => OpenNews(cUrl: fetchedUrl)));
            },
            child: Text(mUrl.toString(), style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline,),)),
        vSpace(h: 10),
        descriptionText(desc: mPubAt.toString(), descSize: 14, txtClr: Colors.grey.shade600),
        vSpace(h: 10),
      ],
    );
  }

}
