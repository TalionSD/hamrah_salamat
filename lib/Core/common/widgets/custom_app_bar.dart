import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      shadowColor: Theme.of(context).colorScheme.surface,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect bounds) {
              return linearGradient(context: context).createShader(bounds);
            },
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
