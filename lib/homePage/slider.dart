import 'package:flutter/material.dart';

class TempoSlider extends StatefulWidget {
  final RangeValues currentTempoRange;
  final Function(RangeValues) onRangeChnage;

  const TempoSlider({
    super.key,
    required this.currentTempoRange,
    required this.onRangeChnage,
  });

  @override
  State<TempoSlider> createState() => _TempoSliderState();
}

class _TempoSliderState extends State<TempoSlider> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Make the Material background transparent
      child: SliderTheme(
        // Add SliderTheme for labels to always show
        data: SliderTheme.of(context).copyWith(
          showValueIndicator: ShowValueIndicator.always,
        ),
        child: RangeSlider(
          activeColor: const Color.fromARGB(223, 216, 40, 140),
          // Use widget.currentTempoRange directly for the slider's values
          values: widget.currentTempoRange,
          min: 20,
          max: 200,
          divisions: 180, // (max - min) if you want divisions for each unit
          labels: RangeLabels(
            // Use widget.currentTempoRange for labels
            widget.currentTempoRange.start.round().toString(),
            widget.currentTempoRange.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            // Call the parent's onRangeChnage callback
            widget.onRangeChnage(values);
            // No need for setState here in TempoSlider, as the parent will rebuild
            // with the new currentTempoRange, and this widget will reflect it.
          },
        ),
      ),
    );
  }
}
