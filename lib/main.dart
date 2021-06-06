import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/src/bloc/counter_bloc.dart';
import 'package:hacker_news/src/bloc/counter_event.dart';
import 'package:hacker_news/src/bloc/counter_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) {
            return CounterBloc();
          },
          child: MyHomePage(title: 'Counter app with bloc')
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, CounterState state) {
              return Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${state.count}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                  ),
                ],
              );
            }
        ),
      ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: (){
                bloc.add(IncrementEvent());
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            SizedBox(width: 16),
            FloatingActionButton(
              onPressed: (){
                bloc.add(DecrementEvent());
              },
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ],
        ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
