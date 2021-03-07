import 'package:flutter/material.dart';

import 'navigation/slide_route.dart';

class NavigationService {
  // ignore: always_declare_return_types
  replaceNewPage({final newPage, required final context}) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, SlideRightRoute(page: newPage));
  }

  // ignore: always_declare_return_types
  goToNewPage({final newPage, required final context}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => newPage));
  }
}
