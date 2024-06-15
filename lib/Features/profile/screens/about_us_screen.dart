import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Features/profile/data/developers.dart';
import 'package:hamrah_salamat/Features/profile/widgets/about_us_card.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = '/about_us_screen';

  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: 'درباره ما'),
      body: SingleChildScrollView(
        child: Padding(
          padding: edgeInsetsGeometryOfScreens(context: context),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.2)),
                      child: const Image(
                        image: AssetImage('assets/images/icon/hamrah_salamat.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'اپلیکیشن همراه سلامت با هدف مدیریت و بهبود سبک زندگی سالم طراحی شده است که با ارائه سیستم برنامه‌ریزی غذایی هفتگی و سیستم هدف‌گذاری و یادآور هوشمند، شما را در دستیابی به اهداف سلامتی یاری می‌دهد. همچنین، با دسترسی به مجموعه مقالات علمی در حوزه‌های ورزش، یوگا و پزشکی، امکان ارتقاء دانش و بهبود سبک زندگی سالم‌تر را فراهم می‌کند.',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(height: 2),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              ...List.generate(
                developers.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: height / 50),
                  child: AboutUsCard(
                    name: developers[index]['name'],
                    imageUrl: developers[index]['image_url'],
                    expertise: developers[index]['expertise'],
                    skills: developers[index]['skills'],
                    communicationTools: developers[index]['communication_tools'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
