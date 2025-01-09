import 'package:flutter/material.dart';

class HierarchicalButton extends StatefulWidget {
  final List<String> firstLevelButtonNames;
  final List<String> secondLevelButtonNames;
  final String showMenuText;

  const HierarchicalButton({
    Key? key,
    required this.firstLevelButtonNames,
    required this.secondLevelButtonNames,
    required this.showMenuText,
  }) : super(key: key);

  @override
  _HierarchicalButtonState createState() => _HierarchicalButtonState();
}

class _HierarchicalButtonState extends State<HierarchicalButton> {
  Map<String, Map<String, int>> _selectionCounts = {};
  List<String> selections = [];

  @override
  void initState() {
    super.initState();
    for (var name1 in widget.firstLevelButtonNames) {
      _selectionCounts[name1] = {};
      for (var name2 in widget.secondLevelButtonNames) {
        _selectionCounts[name1]![name2] = 0;
      }
    }
  }

  @override
  void didUpdateWidget(covariant HierarchicalButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.firstLevelButtonNames.length !=
        widget.firstLevelButtonNames.length) {}
  }

  void _incrementCount(String name1, String name2, bool success) {
    setState(() {
      _selectionCounts[name1]![name2] =
          (_selectionCounts[name1]![name2] ?? 0) + 1;
      selections.add(widget.showMenuText[0] + name1[0] + name2[0] + (success ? '1' : ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.showMenuText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Center(
          child: Row(
            children: widget.firstLevelButtonNames.map((name1) {
              return Column(
                children: <Widget>[
                      Text(name1, style: TextStyle(fontSize: 18))
                    ] +
                    widget.secondLevelButtonNames.map((name2) {
                      return ElevatedButton(
                        onPressed: () => _incrementCount(name1, name2, false),
                        onLongPress: () => _incrementCount(name1, name2, true),
                        child:
                            Text('$name2 (${_selectionCounts[name1]![name2]})'),
                      );
                    }).toList(),
              );
            }).toList(),
          ),
        ),
        Text(
          'Selections: ${selections.join(" ")}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
