import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../appWidgets/widget_class.dart';
import '../savedNewsBloc/saved_news_bloc.dart';
import 'internalScreens/view_saved_news.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SavedNewsBloc>().add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              vSpace(h: 10),
              headerBar(),
              vSpace(h: 10),
              Expanded(child: mainNewsPanel()),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          child: Image.asset("assets/images/lettern.png"),
          radius: 17,
          backgroundColor: Colors.grey.shade300,
        ),
        titleText(
            title: "Indian News Express",
            titleSize: 21,
            weight: FontWeight.bold),
        descriptionText(desc: "View all your saved news", descSize: 15),
      ],
    );
  }

  Widget mainNewsPanel() {
    return BlocBuilder<SavedNewsBloc, SavedNewsState>(
      builder: (_, state) {
        if (state is SavedNewsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        } else if (state is SavedNewsErrorState) {
          return Center(
            child: Text(state.errorMsg.toString()),
          );
        } else if (state is SavedNewsLoadedState) {
          var savedNewsData = state.arrData;
          savedNewsData = savedNewsData.reversed.toList();
          if (savedNewsData.isEmpty) {
            return const Center(
              child: Text("No Saved News Found"),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.arrData.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ViewSavedNews(
                                          cPubDet: savedNewsData[index]["pub_det"],
                                          cTitle: savedNewsData[index]["news_title"],
                                          cImgUrl: savedNewsData[index]["news_imgurl"],
                                          cDesc: savedNewsData[index]["news_desc"],
                                          cContent: savedNewsData[index]["news_content"],
                                          cUrl: savedNewsData[index]["news_url"],
                                          cPubAt: savedNewsData[index]["news_pubat"])));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(savedNewsData[index]
                                            ["news_imgurl"])),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                hSpace(w: 10),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        savedNewsData[index]["news_title"],
                                        maxLines: 2,
                                      ),
                                      vSpace(h: 5),
                                      Text(
                                        savedNewsData[index]["news_desc"],
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontFamily: 'SF UI Text',
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      context.read<SavedNewsBloc>().add(
                                          DeleteNewsEvent(
                                              id: savedNewsData[index]
                                                      ["news_id"]
                                                  .toString()));
                                      context
                                          .read<SavedNewsBloc>()
                                          .add(GetNewsEvent());
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        } else {
          return const Center(child: Text("Unable to fetch news"));
        }
      },
    );
  }
}
