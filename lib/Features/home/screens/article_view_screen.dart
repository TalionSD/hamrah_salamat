import 'package:flutter/material.dart';

class ArticleViewScreen extends StatefulWidget {
  static const String routeName = '/article_view_screen';

  const ArticleViewScreen({
    super.key,
  });

  @override
  State<ArticleViewScreen> createState() => _ArticleViewScreenState();
}

class _ArticleViewScreenState extends State<ArticleViewScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    Map<String, dynamic>? article;

    article = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      body: Stack(
        children: [
          Image(
            height: height / 4,
            width: width,
            fit: BoxFit.fill,
            image: AssetImage(article?['article_image_url']),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: height / 4 - 40),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  right: width / 30,
                  left: width / 30,
                  bottom: height / 40,
                  top: height / 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Image(
                                height: 40,
                                image: AssetImage(article?['author_image_url']),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article?['author'],
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  article?['upload_date'],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_sharp,
                              size: 17,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'زمان تقریبی مطالعه ${article?['study_time']}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    SelectableText(
                      article?['title'],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    SelectableText(
                      article?['description'],
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
