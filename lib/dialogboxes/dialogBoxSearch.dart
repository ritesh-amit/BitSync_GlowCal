import 'package:flutter/material.dart';
import 'package:gur/searchNgo.dart';
import '../Utils/SizeConfig.dart';

class DialogBoxSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 896;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(top: h * 10, bottom: h * 0),
      child: SearchScreen(),
    );
  }
}

void dialogBoxSearch(BuildContext context) {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.7),
    transitionDuration: Duration(milliseconds: 350),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return DialogBoxSearch();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}
