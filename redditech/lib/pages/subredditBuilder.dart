import 'package:flutter/material.dart';
import 'package:reditech/pages/subreddit.dart';


Route SubRedditPageBuilder(String id, String SubName, String SubNbr, NetworkImage PP, String description) {
  return PageRouteBuilder(pageBuilder: (BuildContext context,
      Animation<double> animation, //
      Animation<double> secondaryAnimation) {
    return Scaffold(body:SubRedditPage(id: id, name: SubName, nbSubString: SubNbr, image: PP, description: description));
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation, //
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    );
  });
}
