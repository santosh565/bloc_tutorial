import 'package:bloc_tutorial/data/core/api_client.dart';
import 'package:bloc_tutorial/data/models/article.dart';
import 'package:bloc_tutorial/data/models/news_api_response.dart';
import 'package:dio/dio.dart';

import '../../strings.dart';

abstract class NewsRemoteDataSource {
  Future<List<Article>?> getEverything();
}

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  late final Dio _dio;

  NewsRemoteDataSourceImpl() {
    _dio = dioClient.dio;
  }

  @override
  Future<List<Article>?> getEverything() async {
    try {
      Response response = await _dio.get(Strings.news_url);
      return NewsApiResponse.fromJson(response.data).articles;
    } on Exception catch (e) {
      print("Exception occured: $e");
    }
  }
}

final remoteDataSource = NewsRemoteDataSourceImpl();
