import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hierarchical_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoring app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Scoring Home Page'),
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
  late List<Widget> _hierarchicalButtons;

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
        showMenuText: "Hook",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
      HierarchicalButton(
        firstLevelButtonNames: ['Offense', 'Defense'],
        secondLevelButtonNames: ['Head'],
        showMenuText: "Ax",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
      HierarchicalButton(
        firstLevelButtonNames: ['Offense', 'Defense'],
        secondLevelButtonNames: ['Body', 'Head'],
        showMenuText: "Clinch Kicks",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
      HierarchicalButton(
        firstLevelButtonNames: ['Offense', 'Defense'],
        secondLevelButtonNames: ['Body'],
        showMenuText: "Back",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
      HierarchicalButton(
        firstLevelButtonNames: ['Offense', 'Defense'],
        secondLevelButtonNames: ['Body', 'Head'],
        showMenuText: "Twist",
        sharedSelections: _sharedSelections,
        onSelectionChanged: _updateSelections,
      ),
      Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () => _addSelection("GAM"),
            child: Text("Add GAM"),
          ),
          ElevatedButton(
            onPressed: () => _addSelection("PTG"),
            child: Text("Add PTG"),
          ),
        ],
      )),
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Copied to clipboard'),
          content: Text('The text "$text" has been copied to the clipboard.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addSelection(String selection) {
    setState(() {
      _sharedSelections.add(selection);
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GridView.count(
                crossAxisCount: 2, // Adjust the number of columns as needed
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _hierarchicalButtons,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _copyToClipboard(_sharedSelections.join(" ")),
                  child: Text(
                    '${_sharedSelections.join(" ")}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 120), // Add space between GridView and text
            ],
          ),
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
