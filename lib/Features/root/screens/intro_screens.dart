import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/providers/introduction_provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';

import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/root/screens/login_screen.dart';
import 'package:hamrah_salamat/Features/root/widgets/circle_progress_bar.dart';
import 'package:hamrah_salamat/Features/root/widgets/introduction.dart';

class IntroScreens extends StatelessWidget {
  static const String routeName = '/intro_screens';

  const IntroScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Introduction> list = [
      const Introduction(
        title: 'برنامه غذایی',
        subTitle: 'برنامه غذایی مناسب با نیاز بدنی خود را به آسانی در همراه سلامت تهیه و مدیریت کنید ',
        imageUrl: 'assets/images/intro/diet_planning_intro.png',
      ),
      const Introduction(
        title: 'هدف گذاری',
        subTitle: 'اهداف خود را تعیین کنید و با سیستم مدیریت هوشمند همراه سلامت آنها را دنبال کنید',
        imageUrl: 'assets/images/intro/targeting_intro.png',
      ),
      const Introduction(
        title: 'ورزش و یوگا',
        subTitle: 'جدیدترین و مفیدترین آموزش های ورزش، یوگا و مقالات حوزه سلامت را در همراه سلامت دنبال کنید',
        imageUrl: 'assets/images/intro/article_and_sport_intro.png',
      ),
    ];
    return Scaffold(
      body: IntroScreenOnboarding(
        introductionList: list,
      ),
    );
  }
}

class IntroScreenOnboarding extends StatefulWidget {
  final List<Introduction>? introductionList;
  final Color? backgroudColor;
  final Color? foregroundColor;
  final TextStyle? skipTextStyle;
  const IntroScreenOnboarding({
    super.key,
    this.introductionList,
    this.backgroudColor,
    this.foregroundColor,
    this.skipTextStyle = const TextStyle(fontSize: 20),
  });

  @override
  State<IntroScreenOnboarding> createState() => _IntroScreenOnboardingState();
}

class _IntroScreenOnboardingState extends State<IntroScreenOnboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  late IntroductionProvider _introductionProvider;
  int _currentPage = 0;
  double progressPercent = 0;

  @override
  void initState() {
    _introductionProvider = Provider.of<IntroductionProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height / 40),
        child: Column(
          children: [
            Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: widget.introductionList!,
              ),
            ),
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: _customProgress(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customProgress() {
    return Container(
      padding: edgeInsetsGeometryOfScreens(context: context),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.elliptical(200, 70),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.introductionList![_currentPage].title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.introductionList![_currentPage].subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(
            height: 70,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircleProgressBar(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  foregroundColor: widget.foregroundColor ?? Theme.of(context).primaryColor,
                  value: ((_currentPage + 1) * 1.0 / widget.introductionList!.length),
                ),
              ),
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: linearGradient(context: context),
                ),
                child: IconButton(
                  onPressed: () {
                    _currentPage != widget.introductionList!.length - 1
                        ? _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          )
                        : {
                            if (_introductionProvider.status != AppState.loading)
                              {
                                _introductionProvider
                                    .setViewForIntroductionScreens(
                                  context: context,
                                  introductionScreen: IntroductionScreens.intro,
                                  viewed: 1,
                                )
                                    .then((value) {
                                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                                }),
                              }
                          };
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  iconSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
