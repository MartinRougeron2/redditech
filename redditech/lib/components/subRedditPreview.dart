import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reditech/pages/subredditBuilder.dart';
import 'package:reditech/widgets/autoRouter.gr.dart';

class subRedditPreview extends StatelessWidget {
  subRedditPreview(
      {Key? key,
      required this.name,
      required this.id,
      required this.nbSubString,
      required this.description,
      this.image = const NetworkImage('https://picsum.photos/250?image=9')})
      : super(key: key);

  final String name;
  final String id;
  final String nbSubString;
  final String description;
  final NetworkImage image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        context.pushRoute(SubRedditRoute(
            nbSubString: nbSubString,
            name0: name,
            id: id,
            description: description,
            image: image)),
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: image,
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'r/' + name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 3, 0)),
                Text('   ' + nbSubString + ' members')
              ])
            ],
          )),
    );
  }
}
