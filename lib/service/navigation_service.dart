import 'package:flutter/material.dart';

import 'navigation/slide_route.dart';

class NavigationService {
  replaceNewPage({final newPage, final context}) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, SlideRightRoute(page: newPage));
  }

  goToNewPage({final newPage, final context}) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => newPage));
  }
}
