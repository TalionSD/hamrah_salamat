import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final double? imageWidth;
  final double? imageHeight;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  const Introduction({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.titleTextStyle = const TextStyle(fontSize: 30),
    this.subTitleTextStyle = const TextStyle(fontSize: 20),
    this.imageWidth = 300,
    this.imageHeight = 300,
  });

  @override
  State<StatefulWidget> createState() {
    return IntroductionState();
  }
}

class IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: height / 40, right: width / 30, left: width / 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Transform.scale(
              scale: 1.3,
              child: Image(
                image: AssetImage(widget.imageUrl),
                height: widget.imageHeight,
                width: widget.imageWidth,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

