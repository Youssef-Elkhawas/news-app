// import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/fetch_news_service.dart';
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

  var fetchNewsList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchNews(category: currentCategory);
  }

  void fetchNews({required String category}) async {
    isLoading = true;
    setState(() {});
    FetchNewsService fetchNewsService = FetchNewsService();
    fetchNewsList = await fetchNewsService.newsList(category: currentCategory);
    setState(() {
      isLoading = false;
    });

    debugPrint(fetchNewsList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "News App",
          style: TextStyle(
            color: Colors.amberAccent,
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
                        fetchNews(category: currentCategory);
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
                child: isLoading
                    ? CustomLoadingWidget()
                    : ListView.builder(
                        itemCount: fetchNewsList.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            // imageUrl: articles[index]["image"] ?? "",
                            // title: articles[index]["title"] ?? "",
                            // description: articles[index]["breif"] ?? "",
                            title: fetchNewsList[index]["title"] ?? "",
                            description:
                                fetchNewsList[index]["description"] ?? "",
                            imageUrl:
                                fetchNewsList[index]["urlToImage"] ??
                                "https://ichef.bbci.co.uk/ace/standard/2048/cpsprodpb/3b89/live/60e7ae50-03dc-11f0-a387-437e2fb661fc.jpg",
                            url:
                                fetchNewsList[index]["url"] ??
                                "https://www.google.com",
                          );
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
