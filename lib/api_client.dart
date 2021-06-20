import 'dart:convert';

import 'package:bloc_tutorial/Model/models/news_api_response.dart';
import 'package:bloc_tutorial/strings.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class API_Manager {
  Future<NewsApiResponse> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(Strings.news_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsApiResponse.fromJson(jsonMap);
        print(newsModel);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
