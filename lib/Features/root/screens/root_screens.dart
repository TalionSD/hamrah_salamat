import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/bmi_calculator_screen.dart';
import 'package:hamrah_salamat/Features/home/screens/home_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/profile_screen.dart';
import 'package:hamrah_salamat/Features/targeting/screens/targets_screen.dart';

class RootScreens extends StatefulWidget {
  static const String routeName = '/root_screens';

  const RootScreens({
    super.key,
  });

  @override
  State<RootScreens> createState() => _RootScreensState();
}

class _RootScreensState extends State<RootScreens> {
  RootScreenItems? root;

  PageController _pageController = PageController();
  List<Map<String, dynamic>> navItems = <Map<String, dynamic>>[
    {
      "title": "خانه",
      "icon": Icons.home,
      "required_width": 100.0,
    },
    {
      "title": "اهداف",
      "icon": Icons.flag,
      "required_width": 105.0,
    },
    {
      "title": "رژیم غذایی",
      "icon": Icons.troubleshoot,
      "required_width": 130.0,
    },
    {
      "title": "پروفایل",
      "icon": Icons.account_circle_sharp,
      "required_width": 110.0,
    }
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        root = ModalRoute.of(context)!.settings.arguments as RootScreenItems;
      }

      if (root != null) {
        setState(() {
          if (root == RootScreenItems.home) {
            _selectedIndex = 0;
          } else if (root == RootScreenItems.targeting) {
            _selectedIndex = 1;
          } else if (root == RootScreenItems.dietPlaning) {
            _selectedIndex = 2;
          } else if (root == RootScreenItems.profile) {
            _selectedIndex = 3;
          }

          _changePage(page: _selectedIndex);
        });
      }
    });

    super.initState();
  }

  void _changePage({
    required int page,
  }) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(
      initialPage: _selectedIndex,
      keepPage: true,
    );

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (value) => setState(() {
              _selectedIndex = value;
            }),
            children: const [
              HomeScreen(),
              TargetsScreen(),
              BmiCalculatorScreen(),
              ProfileScreen(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _navBar(),
          ),
        ],
      ),
    );
  }

  Widget _navBar() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(right: width / 25, left: width / 25, bottom: height / 50),
      padding: EdgeInsets.symmetric(vertical: height / 100, horizontal: width / 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.surface.withAlpha(40),
            blurRadius: 20,
            spreadRadius: 10,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: navItems.map((item) {
          int index = navItems.indexOf(item);
          bool isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                _changePage(page: index);
              });
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedContainer(
                    constraints: BoxConstraints(maxWidth: isSelected ? item['required_width'] : 70),
                    duration: const Duration(seconds: 1),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            item['icon'],
                            color: isSelected ? Theme.of(context).colorScheme.tertiary : Theme.of(context).scaffoldBackgroundColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Visibility(
                          visible: isSelected,
                          child: Text(
                            item['title'],
                            style: TextStyle(
                              color: isSelected ? Theme.of(context).colorScheme.tertiary : Colors.transparent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
