import 'package:flutter/material.dart';

import 'package:reditech/components/posting.dart';
import 'package:reditech/widgets/sortBar.dart';
import 'package:reditech/api.dart' as api;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posting> allPosts = <Posting>[];

  @override
  Widget build(BuildContext context) {
    // Create posts from api return
    _buildPosts() async {
      allPosts = await api.getPostsFromAPI(10, 0);
    }
    return Scaffold(body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           Container(
              child: SortBar(),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
           ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical, child: FutureBuilder<dynamic>(
                  future: _buildPosts(), // async work
                  // show Progress circle if async not finished
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting: return new CircularProgressIndicator();
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          return Column(children: allPosts);
                    }
                  },
                ))
    ])));
  }
}
