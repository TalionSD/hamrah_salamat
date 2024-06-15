// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class ArticleWidget extends StatelessWidget {
  final String author;
  final String authorImageUrl;
  final String title;
  final String articleImageUrl;
  final String uploadDate;
  final String studyTime;
  final String description;
  final void Function()? onTap;

  const ArticleWidget({
    Key? key,
    required this.author,
    required this.authorImageUrl,
    required this.title,
    required this.articleImageUrl,
    required this.uploadDate,
    required this.studyTime,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: width - 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image(
              width: width,
              height: height / 7,
              fit: BoxFit.fill,
              image: AssetImage(
                articleImageUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: width / 30,
                left: width / 30,
                bottom: height / 40,
                top: height / 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: Image(
                              height: 30,
                              image: AssetImage(authorImageUrl),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            author,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 17,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            uploadDate,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                            'زمان تقریبی مطالعه $studyTime',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: linearGradient(context: context),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 13,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
