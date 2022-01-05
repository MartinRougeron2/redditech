import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:reditech/components/voteBar.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

// Component :
// Posting => image or text on a subreddit contains :
// - Id
// - (image) w/ text/description
// - Subreddit name attach to
// - Profile => username & picture
// Works w/
// State : Focus
// if Focus =>
//    Comments => List => Profile + text

class Posting extends StatefulWidget {
  const Posting({
    Key? key,
    this.image,
    this.id = "",
    required this.title,
    this.desc = "",
    this.subImage,
    this.comments,
    this.score = "0",
    this.url = "",
    required this.profileName,
    this.profilePicture,
  }) : super(key: key);

  final Image? image;
  final List<Widget>? comments;
  final String title;
  final String desc;
  final String profileName;
  final String id;
  final Image? profilePicture;
  final Image? subImage;
  final String score;
  final String url;

  @override
  State<Posting> createState() => PostingState();
}

class PostingState extends State<Posting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: widget.subImage,
              title: Text(widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(
                '   Posted by u/' + widget.profileName,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                child: widget.url.isEmpty
                    ? Text(
                        widget.desc,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)),
                        maxLines: 5, overflow: TextOverflow.ellipsis,
                      )
                    : FutureBuilder<dynamic>(
                        future: _buildPosts(widget.url), // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new CircularProgressIndicator();
                            default:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              else
                                return SimpleUrlPreview(
                                    url: widget.url,
                                    bgColor: Colors.white70,
                                    siteNameStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500));
                          }
                        },
                      )),
            VoteBar(id: widget.id,  score: int.parse(widget.score))
          ],
        ),
      ),
    );
  }
}

_buildPosts(String url) async {
  return await get(Uri.parse(url));
}
