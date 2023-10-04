import 'package:flutter/material.dart';

Widget circularButton({required IconData icn}) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1)
        ]),
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: 25,
      child: Icon(
        icn,
        color: Colors.black,
      ),
    ),
  );
}

Widget vSpace({required double h}) {
  return SizedBox(
    height: h,
  );
}

Widget hSpace({required double w}) {
  return SizedBox(
    width: w,
  );
}

Widget titleText(
    {required String title,
    required double titleSize,
    FontWeight weight = FontWeight.normal}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'SF UI Text',
      fontWeight: weight,
      fontSize: titleSize,
      color: Colors.black,
    ),
  );
}

Widget descriptionText({
  required String desc,
  required double descSize,
  Color txtClr = Colors.grey,
  TextAlign align = TextAlign.start}) {
  return Text(
    desc,
    style: TextStyle(
      fontFamily: 'SF UI Text',
      fontSize: descSize,
      color: txtClr,
    ),
    textAlign: align,
  );
}

Widget headlineNewsCard({String? imgSrc, String? newsTitle}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: SizedBox(
      width: 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          imgSrc==null?
          Center(child: Image.network("https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png", height: 100, width: 300,)):
          Image.network(imgSrc, height: 180, width: 300,fit: BoxFit.fill,),
          Container(
            decoration: const BoxDecoration(
              color: Color(0x89000000),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7),
              child: Text(
                newsTitle!,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

int generateId(){
  int timeStamp = DateTime.now().millisecondsSinceEpoch;
  return timeStamp;
}

