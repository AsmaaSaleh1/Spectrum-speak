import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }
  Color determineActiveColor(double value) {
    // Customize activeColor based on the slider's value
    if (value == 1) {
      return kBlue; // For values less than 3, set the color to blue
    }
    else if(value==2) {
      return kRed;
    }
    else if(value==3){
      return kYellow;
    }
    else if( value==4){
      return kGreen;
    }
    else if(value==5)
    {
      return kDarkBlue;
    }
    return kDarkBlue;// For values greater than or equal to 3, set the color to green
  }
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      activeColor: determineActiveColor(_value),
      inactiveColor: kDarkBlue,
      onChanged: (newValue) {
        setState(() {
          _value = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_value.roundToDouble());
        }
      },
      divisions: 4, // Set divisions according to step size
      label: _value.toInt().toString(),
      min: widget.min,
      max: widget.max,
    );
  }
}
