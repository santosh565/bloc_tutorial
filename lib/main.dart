import 'package:flutter/material.dart';

import 'data/models/article.dart';
import 'data/models/source.dart';
import 'bloc/news_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  final _newsBloc = NewsBloc();

  @override
  Widget build(BuildContext context) {
    _newsBloc.newsEventSink.add(NewsEvent.Fetch);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder<List<Article>?>(
          stream: _newsBloc.newsStateStream,
          builder: (context, AsyncSnapshot<List<Article>?> snapshot) {
            if (snapshot.hasData) {
              List<Article> articles = snapshot.data!;
              return ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Source source = articles[index].source!;
                  return Card(
                    child: ListTile(
                      title: Text(articles[index].title!),
                      subtitle: Text(source.name!),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(articles[index].urlToImage!),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _newsBloc.newsEventSink.add(NewsEvent.Fetch);
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
