import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HeightGauge extends StatelessWidget {
  final BuildContext context;
  final double value;
  final Function(double)? onChanged;
  const HeightGauge({
    super.key,
    required this.context,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      minimum: 30.0,
      maximum: 220.0,
      orientation: LinearGaugeOrientation.vertical,
      axisTrackStyle: LinearAxisTrackStyle(
        color: Theme.of(context).colorScheme.surface,
        edgeStyle: LinearEdgeStyle.bothCurve,
        thickness: 20.0,
      ),
      barPointers: [
        LinearBarPointer(
          value: value,
          color: Theme.of(context).primaryColor,
        ),
      ],
      maximumLabels: 6,
      markerPointers: [
        LinearWidgetPointer(
          value: value,
          onChanged: onChanged,
          position: LinearElementPosition.outside,
          child: Container(
            width: 25,
            height: 20,
            decoration: BoxDecoration(
              gradient: linearGradient(context: context),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
          ),
        ),
      ],
      animateAxis: true,
      animateRange: true,
    );
  }
}
