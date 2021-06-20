import 'package:bloc_tutorial/counter_event.dart';
import 'package:flutter/material.dart';

import 'Model/models/articles.dart';
import 'Model/models/source.dart';
import 'bloc/news_bloc.dart';
import 'counter_bloc.dart';

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

  final _bloc = CounterBloc();
  final _newsBloc = NewsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder(
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
                    child: ExpansionTile(
                        title: Text(articles[index].title!),
                        subtitle: Text(source.name!),
                        children: [
                          Text(articles[index].content!),
                        ],
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(articles[index].urlToImage!))),

                    // ListTile(
                    //   subtitle: Text(articles[index].author),
                    //   title: Text(articles[index].title!),
                    //   leading: CircleAvatar(
                    //     backgroundImage:
                    //         NetworkImage(articles[index].urlToImage!),
                    //   ),
                    // ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _bloc.eventSink.add(IncrementEvent()),
            tooltip: '',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
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
