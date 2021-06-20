import 'dart:async';

import 'package:bloc_tutorial/Model/models/articles.dart';
import 'package:bloc_tutorial/Model/models/news_api_response.dart';
import 'package:bloc_tutorial/api_client.dart';

enum NewsEvent { Fetch, Update }

class NewsBloc {
  StreamController<NewsEvent> _newsEventController =
      StreamController<NewsEvent>();
  Sink<NewsEvent> get newsEventSink => _newsEventController.sink;
  Stream<NewsEvent> get _newsEventStream => _newsEventController.stream;

  StreamController<List<Article>?> _newsStateController =
      StreamController<List<Article>?>();
  Sink<List<Article>?> get _newsStateSink => _newsStateController.sink;
  Stream<List<Article>?> get newsStateStream => _newsStateController.stream;

  NewsBloc() {
    _newsEventStream.listen(_mapEventToState);
  }

  _mapEventToState(NewsEvent event) async {
    if (event == NewsEvent.Fetch) {
      NewsApiResponse response = await APIManager().getNews();
      _newsStateSink.add(response.articles);
      print(response.articles);
    }
  }

  void dispose() {
    _newsEventController.close();
    _newsStateController.close();
  }
}
