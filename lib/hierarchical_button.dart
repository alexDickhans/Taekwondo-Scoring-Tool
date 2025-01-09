import 'package:flutter/material.dart';

class HierarchicalButton extends StatefulWidget {
  final List<String> firstLevelButtonNames;
  final List<String> secondLevelButtonNames;
  final String showMenuText;
  final List<String> sharedSelections;
  final VoidCallback onSelectionChanged;

  const HierarchicalButton({
    Key? key,
    required this.firstLevelButtonNames,
    required this.secondLevelButtonNames,
    required this.showMenuText,
    required this.sharedSelections,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _HierarchicalButtonState createState() => _HierarchicalButtonState();
}

class _HierarchicalButtonState extends State<HierarchicalButton> {
  @override
  void initState() {
    super.initState();
  }

  void _incrementCount(String name1, String name2, bool success) {
    setState(() {
      widget.sharedSelections.add(
          widget.showMenuText[0] + name1[0] + name2[0] + (success ? '1' : ''));
      widget.onSelectionChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(6),
        child: Column(
          children: [
            Center(
                child: Text(
              widget.showMenuText,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )),
            Center(
              child: Row(
                children: widget.firstLevelButtonNames.map((name1) {
                  return Expanded(
                      child: Column(
                    children:
                        <Widget>[Text(name1, style: TextStyle(fontSize: 18))] +
                            widget.secondLevelButtonNames.map((name2) {
                              return ElevatedButton(
                                onPressed: () =>
                                    _incrementCount(name1, name2, false),
                                onLongPress: () =>
                                    _incrementCount(name1, name2, true),
                                child: Text('$name2'),
                              );
                            }).toList(),
                  ));
                }).toList(),
              ),
            ),
          ],
        ));
  }
}
