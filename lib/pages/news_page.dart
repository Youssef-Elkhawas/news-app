// import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_cubit.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_state.dart';
// import 'package:news_app/services/fetch_news_service.dart';
// import 'package:news_app/services/fetch_news_service.dart';
import 'package:news_app/widgets/category_card.dart';
import 'package:news_app/widgets/custom_loading_widget.dart';
import 'package:news_app/widgets/news_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<String> categories = [
    "General",
    "Technology",
    "Sports",
    "Business",
    "Football",
    "Cinema",
  ];
  String currentCategory = "General";

  // final List<Map<String, String>> articles = List.generate(
  //   10,
  //   (index) => {
  //     "breif": lorem(words: 50, paragraphs: 2),
  //     "title": lorem(words: 6, paragraphs: 1),
  //     "image": "https://picsum.photos/seed/${(index + 1) * 9}/400/250",
  //   },
  // );

  // var fetchNewsList = [];
  // bool isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchNews(category: currentCategory);
  // }

  // void fetchNews({required String category}) async {
  //   isLoading = true;
  //   setState(() {});
  //   FetchNewsService fetchNewsService = FetchNewsService();
  //   fetchNewsList = await fetchNewsService.newsList(category: currentCategory);
  //   setState(() {
  //     isLoading = false;
  //   });
  //   debugPrint(fetchNewsList.toString());
  // }

  //-----------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "News App",
          style: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              //----------------category card ---------------------
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentCategory = categories[index];
                        });
                        // fetchNews(category: currentCategory);
                        BlocProvider.of<FetchNewsCubit>(
                          context,
                        ).fetchNews(category: currentCategory);
                      },
                      child: CategoryCard(
                        categoryName: categories[index],
                        isSelected: currentCategory == categories[index],
                      ),
                    );
                  },
                ),
              ),
              Divider(thickness: 0.65, indent: 30, endIndent: 30),

              //-----------news card---------------
              Expanded(
                child: BlocBuilder<FetchNewsCubit, FetchNewsState>(
                  builder: (context, state) {
                    if (state is FetchNewsLoading) {
                      return CustomLoadingWidget();
                    }
                    if (state is FetchNewsSuccess) {
                      return ListView.builder(
                        itemCount: BlocProvider.of<FetchNewsCubit>(
                          context,
                        ).newsList.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            newsModel: BlocProvider.of<FetchNewsCubit>(
                              context,
                            ).newsList[index],
                          );
                        },
                      );
                    }
                    return Text("Failed load news");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
