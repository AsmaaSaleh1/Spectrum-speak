import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/user.dart';


class RadioButtonSearch extends StatefulWidget {
  final UserCategory selected;
  final ValueChanged<UserCategory> onTypeChanged;

  const RadioButtonSearch({
    required this.selected,
    required this.onTypeChanged,
    super.key,
  });

  @override
  State<RadioButtonSearch> createState() => _RadioButtonSearchState();
}

class _RadioButtonSearchState extends State<RadioButtonSearch> {
  UserCategory _character = UserCategory.Parent;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Parent'),
          leading: Radio<UserCategory>(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kDarkerColor,
            value: UserCategory.Parent,
            groupValue: _character,
            onChanged: (UserCategory? value) {
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
          leading: Radio<UserCategory>(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kDarkerColor,
            value: UserCategory.Specialist,
            groupValue: _character,
            onChanged: (UserCategory? value) {
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
          leading: Radio<UserCategory>(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kDarkerColor,
            value: UserCategory.ShadowTeacher,
            groupValue: _character,
            onChanged: (UserCategory? value) {
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