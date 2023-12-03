import 'package:flutter/material.dart';
import 'package:news_app/features/home/domain/news_cubit.dart';
import 'package:news_app/uikit/app_icon_button.dart';
import 'package:news_app/uikit/app_icons.dart';
import 'package:provider/provider.dart';

class HomeSearchInput extends StatefulWidget {
  const HomeSearchInput({super.key});

  @override
  State<HomeSearchInput> createState() => _HomeSearchInputState();
}

class _HomeSearchInputState extends State<HomeSearchInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      maxLines: 1,
      onSubmitted: _search,
      decoration: InputDecoration(
        hintText: 'Search',
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        prefixIcon: _buildPrefixIcon(),
        suffixIcon: _buildSuffixIcon(),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    return AppIconButton(
      icon: Icon(AppIcons.search),
      onPressed: () {
        _search(_controller.value.text);
      },
    );
  }

  Widget _buildSuffixIcon() {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        if (value.text.isNotEmpty) {
          return AppIconButton(
            icon: const Icon(Icons.clear),
            onPressed: _onSuffixPressed,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _onSuffixPressed() {
    _controller.clear();
    if (!_focusNode.hasFocus) {
      _search();
    }
  }

  void _search([String? value]) {
    _focusNode.unfocus();
    context.read<NewsCubit>().fetchByKey(value: value ?? '');
  }
}
