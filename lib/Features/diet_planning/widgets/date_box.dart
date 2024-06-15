import 'package:flutter/material.dart';

class DateBox extends StatelessWidget {
  final String title;
  final String date;
  final Color color;
  const DateBox({
    super.key,
    required this.title,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: title == "شروع"
            ? const BorderRadius.only(
                bottomRight: Radius.circular(12),
              )
            : const BorderRadius.only(
                bottomLeft: Radius.circular(12),
              ),
        color: color,
        // border: Border.all(width: 2, color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$title برنامه : ',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
          ),
        ],
      ),
    );
  }
}
