import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_news/screens/internalScreens/view_news.dart';

import '../../appWidgets/widget_class.dart';
import '../../usBloc/us_bloc.dart';

class ShowAllHeadlines extends StatefulWidget {
  const ShowAllHeadlines({super.key});

  @override
  State<ShowAllHeadlines> createState() => _ShowAllHeadlinesState();
}

class _ShowAllHeadlinesState extends State<ShowAllHeadlines> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UsBloc>().add(GetUsNews());
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(title: "All Headlines", titleSize: 21),
              Expanded(child: mainNewsPanel()),
            ],
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
            onTap: (){
              Navigator.pop(context);
            },
            child: circularButton(icn: Icons.arrow_back)),
        hSpace(w: 18),
        titleText(
            title: "Indian News Express", titleSize: 21, weight: FontWeight.bold),
      ],
    );
  }

  Widget mainNewsPanel() {
    return BlocBuilder<UsBloc, UsState>(
      builder: (_, state) {
        if (state is UsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        } else if (state is UsErrorState) {
          return Center(
            child: Text(state.errorMsg.toString()),
          );
        } else if (state is UsLoadedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.usModel.articles?.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            var name = state.usModel.articles![index].source!.name;
                            var author = state.usModel.articles![index].author;
                            var title = state.usModel.articles![index].title;
                            var desc = state.usModel.articles![index].description;
                            var content = state.usModel.articles![index].content;
                            var imgUrl = state.usModel.articles![index].urlToImage;
                            var newsUrl = state.usModel.articles![index].url;
                            var publishedAt = state.usModel.articles![index].publishedAt;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    ViewNews(
                                        name,
                                        author,
                                        title,
                                        desc,
                                        content,
                                        imgUrl,
                                        newsUrl,
                                        publishedAt)));
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
                                      image: state.usModel.articles![index]
                                          .urlToImage ==
                                          null
                                          ? const NetworkImage(
                                          "https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png")
                                          : NetworkImage(
                                          "${state.usModel.articles![index]
                                              .urlToImage}")),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              hSpace(w: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      state.usModel.articles![index].title
                                          .toString(),
                                      maxLines: 2,
                                    ),
                                    vSpace(h: 5),
                                    Text(
                                      state.usModel.articles![index]
                                          .description ==
                                          null
                                          ? "No Description"
                                          : state
                                          .usModel.articles![index].description
                                          .toString(),
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
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        } else {
          return const Center(child: Text("Unable to fetch news"));
        }
      },
    );
  }

}
