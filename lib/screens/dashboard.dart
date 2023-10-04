import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_news/appWidgets/widget_class.dart';
import 'package:india_news/newsBloc/news_bloc.dart';
import 'package:india_news/screens/news_channels.dart';
import 'package:india_news/screens/internalScreens/show_more.dart';

import 'package:india_news/usBloc/us_bloc.dart';
import 'package:india_news/utilities/category_map.dart';

import 'internalScreens/view_news.dart';
import 'news_favourites.dart';

int bottomIndex = 0;

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsBloc>().add(GetLatestNews());
    context.read<UsBloc>().add(GetUsNews());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screenList = [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerBar(),
              vSpace(h: 10),
              headlinePanel(),
              vSpace(h: 10),
              categoryBar(),
              vSpace(h: 10),
              titleText(title: "Recommended for you", titleSize: 21),
              vSpace(h: 7),
              Expanded(child: mainNewsPanel()),
            ],
          ),
        ),
      ),//0
      NewsChannel(),//1
      Favourites(),//2
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: screenList[bottomIndex],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.cyan,
        onTap: (pos){
          bottomIndex = pos;
          setState(() {

          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "News Channel"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
        ],
      ),
    );
  }

  Widget headerBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //circularButton(icn: Icons.menu),
        CircleAvatar(child: Image.asset("assets/images/lettern.png"), radius: 17, backgroundColor: Colors.grey.shade300,),
        titleText(
            title: "Indian News Express", titleSize: 21, weight: FontWeight.bold),
        circularButton(icn: Icons.search),
      ],
    );
  }

  Widget headlinePanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            titleText(title: "International Headlines", titleSize: 21),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder) => ShowAllHeadlines()));
              },
                child: descriptionText(desc: "Show More", descSize: 12)),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: BlocBuilder<UsBloc, UsState>(
            builder: (cx, state) {
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
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.usModel.articles!.length >= 6 ? 6 : state
                        .usModel.articles!.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: (){
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
                        child: headlineNewsCard(
                            imgSrc: state.usModel.articles![index].urlToImage,
                            newsTitle: state.usModel.articles![index].title),
                      );
                    });
              } else {
                return Center(child: Text("Unknown Error Occured"));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget categoryBar() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: NewsCategories().categories.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    String selectedCat =
                    NewsCategories().categories[index]["cat"]!;
                    context
                        .read<NewsBloc>()
                        .add(GetLatestNews(CAT: selectedCat));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              NewsCategories().categories[index]["imgRes"]!,
                              height: 20,
                              width: 20,
                            ),
                            hSpace(w: 6),
                            Text(NewsCategories().categories[index]["cat"]!),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Widget mainNewsPanel() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (_, state) {
        if (state is NewsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        } else if (state is NewsErrorState) {
          return Center(
            child: Text(state.errorMsg.toString()),
          );
        } else if (state is NewsLoadedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.mModel.articles?.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            var name = state.mModel.articles![index].source!.name;
                            var author = state.mModel.articles![index].author;
                            var title = state.mModel.articles![index].title;
                            var desc = state.mModel.articles![index].description;
                            var content = state.mModel.articles![index].content;
                            var imgUrl = state.mModel.articles![index].urlToImage;
                            var newsUrl = state.mModel.articles![index].url;
                            var publishedAt = state.mModel.articles![index].publishedAt;
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
                                      image: state.mModel.articles![index]
                                          .urlToImage ==
                                          null
                                          ? const NetworkImage(
                                          "https://cdn.pixabay.com/photo/2017/11/10/04/47/image-2935360_1280.png")
                                          : NetworkImage(
                                          "${state.mModel.articles![index]
                                              .urlToImage}")),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              hSpace(w: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      state.mModel.articles![index].title
                                          .toString(),
                                      maxLines: 2,
                                    ),
                                    vSpace(h: 5),
                                    Text(
                                      state.mModel.articles![index]
                                          .description ==
                                          null
                                          ? "No Description"
                                          : state
                                          .mModel.articles![index].description
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
