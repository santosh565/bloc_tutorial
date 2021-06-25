import 'dart:io';

import 'package:bloc_tutorial/data/core/api_client.dart';
import 'package:bloc_tutorial/data/models/article.dart';
import 'package:bloc_tutorial/data/models/news_api_response.dart';
import 'package:dio/dio.dart';

import '../../strings.dart';

abstract class NewsRemoteDataSource {
  Future<List<Article>?> getEverything();
}

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  late final Dio _apiClient;

  NewsRemoteDataSourceImpl() {
    _apiClient = apiClient.dio;
  }

  @override
  Future<List<Article>?> getEverything() async {
    try {
      Response response = await _apiClient.get(Strings.news_url);
      return NewsApiResponse.fromJson(response.data).articles;
    } on SocketException catch (error, stacktrace) {
      print("$error and $stacktrace");
    }
  }
}
