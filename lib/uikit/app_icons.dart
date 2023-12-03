import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIcons {
  AppIcons._();

  static IconData get nightlight {
    if (Platform.isIOS) {
      return CupertinoIcons.moon_fill;
    }
    return Icons.nightlight;
  }

  static IconData get nightlightOutlined {
    if (Platform.isIOS) {
      return CupertinoIcons.moon;
    }
    return Icons.nightlight_outlined;
  }

  static IconData get settings {
    if (Platform.isIOS) {
      return CupertinoIcons.settings_solid;
    }
    return Icons.tune;
  }

  static IconData get search {
    if (Platform.isIOS) {
      return CupertinoIcons.search;
    }
    return Icons.search;
  }

  static IconData get arrowUp {
    if (Platform.isIOS) {
      return CupertinoIcons.arrow_up;
    }
    return Icons.arrow_upward;
  }
}
