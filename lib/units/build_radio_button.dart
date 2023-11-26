import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';

enum Category { parent, specialist, shadowTeacher }

class RadioButtonSearch extends StatefulWidget {
  final Category selected;
  final ValueChanged<Category> onTypeChanged;

  const RadioButtonSearch({
    required this.selected,
    required this.onTypeChanged,
    super.key,
  });

  @override
  State<RadioButtonSearch> createState() => _RadioButtonSearchState();
}

class _RadioButtonSearchState extends State<RadioButtonSearch> {
  Category _character = Category.parent;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Parent'),
          leading: Radio<Category>(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kDarkerColor,
            value: Category.parent,
            groupValue: _character,
            onChanged: (Category? value) {
              setState(() {
                _character = value!;
              });
              widget.onTypeChanged(_character); // Notify the parent about the change
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Specialist'),
          leading: Radio<Category>(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kDarkerColor,
            value: Category.specialist,
            groupValue: _character,
            onChanged: (Category? value) {
              setState(() {
                _character = value!;
              });
              widget.onTypeChanged(_character); // Notify the parent about the change
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Shadow Teacher'),
          leading: Radio<Category>(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kDarkerColor,
            value: Category.shadowTeacher,
            groupValue: _character,
            onChanged: (Category? value) {
              setState(() {
                _character = value!;
              });
              widget.onTypeChanged(_character); // Notify the parent about the change
            },
          ),
        ),
      ],
    );
  }
}