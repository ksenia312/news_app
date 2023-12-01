import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/home_screen_model.dart';
import 'package:provider/provider.dart';

class HomeSearchPanel extends StatelessWidget {
  const HomeSearchPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSearchModel>(
      builder: (context, model, _) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: Visibility(
            visible: model.showSearchPanel,
            replacement: Container(
              width: double.infinity,
              color: Colors.blue,
            ),
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
