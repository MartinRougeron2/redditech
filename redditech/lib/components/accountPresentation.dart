import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPresentation extends StatelessWidget {

  AccountPresentation({Key? key, required this.name, required this.profilePicture, required this.karma, required this.username, required this.desc, required this.backgroundImage}) : super(key: key);

  final NetworkImage profilePicture;
  final NetworkImage backgroundImage;
  final String username;
  final String name;
  final String desc;
  final int karma;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(5, 50, 5, 20),
        // color: Colors.white,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: backgroundImage,
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter
            )
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              foregroundImage: profilePicture,
            ),
            Text(
              "${username}  - ${karma} karma",
              style: TextStyle(fontWeight: FontWeight.w600, backgroundColor: Colors.black, color: Colors.white)
            ),
            Text (
              name,
              style: TextStyle(fontWeight: FontWeight.w600, backgroundColor: Colors.black, color: Colors.white)
            ),
            Text (
              desc,
              style: TextStyle(fontWeight: FontWeight.w600, backgroundColor: Colors.black, color: Colors.white)
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 20))
          ],
        ));
  }
}
