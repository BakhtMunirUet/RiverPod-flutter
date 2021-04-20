import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpod_test_first/ApiTESt/APITEST.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class IncreamentNotifier with ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }
}

//this is globaly accessible
final increamentProvider =
    ChangeNotifierProvider((ref) => IncreamentNotifier());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reverpod Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riverpod Tutorial'),
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: Consumer(
                  builder: (context, watch, child) {
                    final greeting = watch(increamentProvider);
                    return Text(greeting.value.toString());
                  },
                ),
              ),
              NextPage(),
              UpdateValueFromHere()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(increamentProvider).increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text("Next"),
      color: Colors.blue,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondPage()),
        );
      },
    );
  }
}

class UpdateValueFromHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        color: Colors.yellow,
        onPressed: () {
          context.read(increamentProvider).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update value"),
      ),
      body: Column(
        children: [
          Center(
            child: Consumer(
              builder: (context, watch, child) {
                final greeting = watch(increamentProvider);
                return Text(greeting.value.toString());
              },
            ),
          ),
          UpdateValueFromHere(),
          FlatButton(
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => APITEST()),
              );
            },
            child: Text("River Pod API test"),
          )
        ],
      ),
    );
  }
}
