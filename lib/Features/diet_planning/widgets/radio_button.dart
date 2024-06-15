import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class RadioButton extends StatelessWidget {
  final BuildContext context;
  final String title;
  final int index;
  final bool? isSelected;
  final Function(int)? onTap;
  const RadioButton({super.key, required this.context, required this.title, required this.index, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!(index);
      },
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isSelected == true ? Theme.of(context).colorScheme.primary : Theme.of(context).primaryColor),
              gradient: isSelected == true ? linearGradient(context: context) : null,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(title),
        ],
      ),
    );
  }
}
