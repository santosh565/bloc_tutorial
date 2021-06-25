import 'article.dart';

class NewsApiResponse {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsApiResponse({this.status, this.totalResults, this.articles });

  @override
  String toString() {
    return 'NewsApiResponse($articles)';
  }

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      NewsApiResponse(
        status: json['status'] as String?,
        totalResults: json['totalResults'] as int?,
        articles: (json['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles?.map((e) => e.toJson()).toList(),
      };
}
