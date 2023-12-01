import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/home_screen_model.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Recent News'),
      actions: [
        IconButton(
          onPressed: context.read<HomeSearchModel>().toggleSearch,
          icon: const Icon(Icons.filter_alt),
        )
      ],
    );
  }
}
