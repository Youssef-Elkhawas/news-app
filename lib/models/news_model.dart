class NewsModel {
  final String title;
  final String discription;
  final String imgURL;
  final String url;
  final String? publishedAt;
  final String author;

  NewsModel({
    required this.title,
    required this.discription,
    required this.imgURL,
    required this.url,
    required this.publishedAt,
    required this.author,
  });
}
