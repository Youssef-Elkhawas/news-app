import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/models/news_model.dart';

class FetchNewsService {
  final Dio dio = Dio();

  Future<List<NewsModel>> newsList({required String category}) async {
    try {
      Response response = await dio.get(
        "https://newsapi.org/v2/everything",
        queryParameters: {
          "q": category,
          "sortBy": "publishedAt",
          "apiKey": dotenv.env['NEWS_API_KEY'],
        },
      );
      List<NewsModel> newsData = [];

      for (var item in response.data["articles"]) {
        newsData.add(
          NewsModel(
            title: item["title"] ?? "",
            discription: item["description"] ?? "",
            imgURL:
                item["urlToImage"] ??
                "https://ichef.bbci.co.uk/ace/standard/2048/cpsprodpb/3b89/live/60e7ae50-03dc-11f0-a387-437e2fb661fc.jpg",
            url: item["url"] ?? "https://www.google.com",
            publishedAt: item["publishedAt"] ?? "unkown date",
            author: item["author"] ?? "undefined author",
          ),
        );
      }
      debugPrint(response.data["articles"].toString());
      return newsData;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
