import 'dart:convert';

import 'package:bloc_tutorial/Model/models/news_api_response.dart';
import 'package:bloc_tutorial/strings.dart';
import 'package:http/http.dart' as http;

class APIManager {
  http.Client _client = http.Client();
  late final NewsApiResponse newsApiResponse;

  Future<NewsApiResponse> getNews() async {
    try {
      http.Response response = await _client.get(Uri.parse(Strings.news_url));
      if (response.statusCode == 200) {
        String jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsApiResponse = NewsApiResponse.fromJson(jsonMap);
      }
    } catch (e) {
      print("e$e");
    }

    return newsApiResponse;
  }
}
