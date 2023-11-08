import 'package:flutter/material.dart';

enum Search { center, specialist, shadowTeacher }

class RadioButtonSearch extends StatefulWidget {
  final Search selectedSearch;
  final ValueChanged<Search> onSearchTypeChanged;

  const RadioButtonSearch({
    required this.selectedSearch,
    required this.onSearchTypeChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<RadioButtonSearch> createState() => _RadioButtonSearchState();
}

class _RadioButtonSearchState extends State<RadioButtonSearch> {
  Search _character = Search.center;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: ListTile(
              title: const Text('Center'),
              leading: Radio<Search>(
                value: Search.center,
                groupValue: _character,
                onChanged: (Search? value) {
                  setState(() {
                    _character = value!;
                  });
                  widget.onSearchTypeChanged(_character); // Notify the parent about the change
                },
              ),
            )),
        Expanded(
            child: ListTile(
              title: const Text('Specialist'),
              leading: Radio<Search>(
                value: Search.specialist,
                groupValue: _character,
                onChanged: (Search? value) {
                  setState(() {
                    _character = value!;
                  });
                  widget.onSearchTypeChanged(_character); // Notify the parent about the change
                },
              ),
            )),
        Expanded(
            child: ListTile(
              title: const Text('Shadow Teacher'),
              leading: Radio<Search>(
                value: Search.shadowTeacher,
                groupValue: _character,
                onChanged: (Search? value) {
                  setState(() {
                    _character = value!;
                  });
                  widget.onSearchTypeChanged(_character); // Notify the parent about the change
                },
              ),
            )),
      ],
    );
  }
}