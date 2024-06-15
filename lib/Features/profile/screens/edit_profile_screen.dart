import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';
import 'package:hamrah_salamat/Features/profile/data/avatars.dart';
import 'package:hamrah_salamat/Features/profile/providers/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit_profle_screen';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileProvider _profileProvider;
  int _selectedIndex = 0;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height / 4,
            width: width,
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(200),
              ),
            ),
            child: Image(
              image: AssetImage(avatars[_selectedIndex]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: edgeInsetsGeometryOfScreens(context: context),
              child: GridView.builder(
                itemCount: avatars.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedIndex == index ? Theme.of(context).primaryColor.withOpacity(0.2) : Theme.of(context).colorScheme.tertiary,
                      border: Border.all(
                        color: _selectedIndex == index ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),
                      boxShadow: _selectedIndex == index
                          ? [
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withOpacity(0.4),
                                spreadRadius: 6,
                                blurRadius: 30,
                                offset: const Offset(0, 5),
                              ),
                            ]
                          : null,
                    ),
                    child: Image(
                      color: _selectedIndex != index ? Theme.of(context).colorScheme.onSurface : null,
                      image: AssetImage(
                        avatars[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: edgeInsetsGeometryOfScreens(context: context),
            child: Button(
              width: width,
              onPressed: () {
                if (_profileProvider.status != AppState.loading) {
                  _profileProvider.updateProfile(
                    context: context,
                    user: User(
                      imageUrl: avatars[_selectedIndex],
                    ),
                  );
                }
              },
              child: Text(
                'ذخیره',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
