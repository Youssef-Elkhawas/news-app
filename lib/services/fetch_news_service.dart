import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class FetchNewsService {
  final Dio dio = Dio();
  Future<List<dynamic>> newsList({required String category}) async {
    try {
      Response response = await dio.get(
        "https://newsapi.org/v2/everything",
        queryParameters: {
          "q": category,
          "apiKey": "f9c537df027742c1adf8fa88b449507d",
        },
      );
      debugPrint(response.data["articles"].toString());

      return response.data["articles"] ?? [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
