import 'dart:async';

import 'package:bloc_tutorial/data/data_sources/news_remote_data_source.dart';
import 'package:bloc_tutorial/data/models/article.dart';

enum NewsEvent { Fetch, Update }

class NewsBloc {
  StreamController<NewsEvent> _newsEventController =
      StreamController<NewsEvent>();
  Sink<NewsEvent> get newsEventSink => _newsEventController.sink;
  Stream<NewsEvent> get _newsEventStream => _newsEventController.stream;

  StreamController<List<Article>?> _newsStateController =
      StreamController<List<Article>?>();
  StreamSink<List<Article>?> get _newsStateSink => _newsStateController.sink;
  Stream<List<Article>?> get newsStateStream => _newsStateController.stream;

  NewsBloc() {
    _newsEventStream.listen(_mapEventToState);
  }

  _mapEventToState(NewsEvent event) async {
    if (event == NewsEvent.Fetch) {
      List<Article>? articles =
          await NewsRemoteDataSourceImpl().getEverything();
      _newsStateSink.add(articles);
    }
  }

  void dispose() {
    _newsEventController.close();
    _newsStateController.close();
  }
}
