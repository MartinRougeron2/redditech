import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:reditech/api.dart';

class VoteBar extends StatefulWidget {
  VoteBar({Key? key, required this.id, required this.score}) : super(key: key);

  final int score;
  final String id;
  @override
  State<VoteBar> createState() => _VoteBarState();

}

class _VoteBarState extends State<VoteBar> {
  int score = 0;
  int status = 0;

  @override
  void initState() {
    super.initState();
    score = widget.score;
    status = 0;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Api().upvote(widget.id);
            setState(() {
              if (score == 0 || score == -1) {
                status = 1;
                score = widget.score + 1;
              }
            });
          },
          icon: Icon(Icons.arrow_upward, color: status == 1 ? Colors.red : Colors.black),
        ),
        Text(score.toString()),
        IconButton(
          onPressed: () {
            setState(() {
              if (score == 0 || score == 1) {
                status = -1;
                score = widget.score - 1;
              }
            });
          },
          icon: Icon(Icons.arrow_downward, color: status == -1 ? Colors.pinkAccent : Colors.black),
        ),
      ],
    );
  }
}
