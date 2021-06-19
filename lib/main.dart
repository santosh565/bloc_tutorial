import 'package:bloc_tutorial/counter_event.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    print("build called");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
                stream: _bloc.stateStream,
                builder: (context, snapshot) {
                  return Text(
                    '$snapshot',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
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
            onPressed: () => _bloc.eventSink.add(DecrementEvent()),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
