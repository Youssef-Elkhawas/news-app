import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/pages/webview.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewsWebView(url: newsModel.url, title: newsModel.title),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(7.0),
        elevation: 3,
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                newsModel.imgURL,
                headers: const {
                  'User-Agent':
                      'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
                },

                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    "https://ichef.bbci.co.uk/ace/standard/2048/cpsprodpb/3b89/live/60e7ae50-03dc-11f0-a387-437e2fb661fc.jpg",
                  );
                },
              ),
            ),
            SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  Text(
                    newsModel.discription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),

                  Divider(thickness: 0.7),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.create_rounded,
                        color: Color.fromARGB(166, 15, 23, 42),
                        size: 16,
                      ),
                      SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          newsModel.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(166, 15, 23, 42),
                          ),
                        ),
                      ),

                      SizedBox(width: 16),

                      Icon(
                        Icons.calendar_month_rounded,
                        color: Color.fromARGB(166, 15, 23, 42),
                        size: 16,
                      ),
                      SizedBox(width: 2),
                      Text(
                        newsModel.publishedAt != null
                            ? DateFormat(
                                "yyyy/MM/dd, hh:mm a",
                              ).format(DateTime.parse(newsModel.publishedAt!))
                            : "unknown date",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(166, 15, 23, 42),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
