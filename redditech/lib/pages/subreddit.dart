import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reditech/api.dart';
import 'package:reditech/components/posting.dart';
import 'dart:convert';

import 'package:reditech/widgets/sortBar.dart';

class SubRedditPage extends StatefulWidget {
  SubRedditPage({Key? key,
    required this.name,
    required this.id,
    required this.nbSubString,
    required this.description,
    required this.image})
      : super(key: key);

  final String name;
  final String id;
  final String nbSubString;
  final String description;
  final NetworkImage image;

  @override
  State<SubRedditPage> createState() => SubRedditPageState();
}

class SubRedditPageState extends State<SubRedditPage> {
  List<Posting> posts = <Posting>[];
  bool joined = false;

  Widget build(BuildContext context) {
    Posting _fromJson(Map<String, dynamic> item) {
      return new Posting(
        title: item['title'],
        id: item['subreddit_id'],
        desc: item['selftext'] ?? "",
        profileName: item['author'],
        profilePicture: null,
        score: item['score'].toString(),
        url: item['url_overridden_by_dest'] ?? "",
      );
    }

    Future<String> _buildPosts() async {
      final _getPosts = await Api().posts(widget.name, "hot", 50, 0);

      var app = json.decode(_getPosts.toString());

      List arr = app['data']['children'];
      arr.forEach((child) => posts.add(_fromJson(child['data'])));

      return 'DONE';
    }

    void _subscribe() {
      setState(() {
        joined = !joined;
      });
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Row(
              children: [
                Transform.translate(
                  offset: Offset(-20, -4),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: widget.image,
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 1, 10, 0)),
                Text('r/' + widget.name),
              ],
            )
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5)),
              Card(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                      Text(widget.description, maxLines: 5,
                          overflow: TextOverflow.ellipsis),
                      Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.indigo),
                              onPressed: _subscribe,
                            child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.nbSubString),
                                  Icon(!joined ? Icons.add : Icons.remove)
                                ]
                              )
                          )
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                    ])
            ),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5)),
              SortBar(),
              FutureBuilder<String>(
                future: _buildPosts(), // async work
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Column(children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                        CircularProgressIndicator()]);
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return Column(children: [Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        ),
                          ...posts
                        ]);
                  }
                },
        )])));
  }
}
