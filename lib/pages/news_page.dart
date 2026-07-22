import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_cubit.dart';
import 'package:news_app/cubits/fetch_news_cubit/fetch_news_state.dart';
import 'package:news_app/widgets/category_card.dart';
import 'package:news_app/widgets/custom_loading_widget.dart';
import 'package:news_app/widgets/news_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  static const List<String> categories = [
    "All",
    "General",
    "Technology",
    "Sports",
    "Business",
    "Health",
    "Entertainment",
    "Science",
  ];
  String currentCategory = "all";

  //-----------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFF8FAFC),
        surfaceTintColor: Color(0xFF2563EB),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Globe",
              style: TextStyle(fontSize: 24, color: Color(0xFF1E3A8A)),
            ),
            Text(
              "Pulse",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF97316),
              ),
            ),
          ],
        ),
      ),

      backgroundColor: Color(0xFFF8FAFC),

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
                        BlocProvider.of<FetchNewsCubit>(
                          context,
                        ).fetchNews(category: currentCategory);
                      },
                      child: CategoryCard(
                        categoryName: categories[index],
                        isSelected:
                            currentCategory.toLowerCase() ==
                            categories[index].toLowerCase(),
                      ),
                    );
                  },
                ),
              ),
              Divider(thickness: 0.65, indent: 30, endIndent: 30),

              //-----------news card---------------//
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
