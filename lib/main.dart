import 'package:flutter/material.dart';
import 'hierarchical_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _sharedSelections = [];
  late List<HierarchicalButton> _hierarchicalButtons;

  @override
  void initState() {
    super.initState();
    _hierarchicalButtons = [
      HierarchicalButton(
        firstLevelButtonNames: ['Offense', 'Defense'],
        secondLevelButtonNames: ['Body', 'Head'],
        showMenuText: "Side",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
      HierarchicalButton(
        firstLevelButtonNames: ['Offense', 'Defense'],
        secondLevelButtonNames: ['Body', 'Head'],
        showMenuText: "Round",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
      HierarchicalButton(
        firstLevelButtonNames: ['Offense', 'Defense'],
        secondLevelButtonNames: ['Body', 'Head'],
        showMenuText: "Position",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
    ];
  }

  void _updateSelections() {
    setState(() {});
  }

  void _reset() {
    setState(() {
      _sharedSelections.clear();
    });
  }

  void _undo() {
    setState(() {
      if (_sharedSelections.isNotEmpty) {
        _sharedSelections.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Adjust the number of columns as needed
                children: _hierarchicalButtons,
              ),
            ),
            Text(
              'Selections: ${_sharedSelections.join(" ")}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton.icon(
              onPressed: () {},
              onLongPress: _reset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset')),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _undo,
            tooltip: 'Undo',
            child: const Icon(Icons.undo),
          ),
        ],
      ),
    );
  }
}
