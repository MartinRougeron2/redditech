import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:reditech/components/accountPresentation.dart';
import 'package:reditech/components/setting.dart';

import 'dart:convert';

import 'package:reditech/api.dart' as api;
import 'package:reditech/types.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> { 
  UserInformations profile = UserInformations(
    name: 'Art Nö',
    username: 'u/artnö',
    description: 'probably the best reddit client: Telerama',
    icon: NetworkImage(
      "https://pbs.twimg.com/profile_images/1315625686401519616/-WIT7LEg_400x400.jpg"
    ),
    banner: NetworkImage(
      "https://media.wired.com/photos/5abece0a9ccf76090d775185/master/pass/hangoutsscreen_2.jpg"
    ),
    karma: 99999999,
    subscribers: 99999999
  );

  Future<String> _buildProfile() async {
    String token = await api.getData("TOKEN");
    bool status = false;
    String userNameSearch = "neoistoxic";
    if (token != "EMPTY") {
        status = await api.Api().check();
        if (status == false) {
            print("REFRESHING TOKEN => ${token}");
            String refreshed = await api.Api().refresh();
            print('REFRESHED => ${refreshed}');
        } else {
            print('token valid => ${token}');
        }
    } else {
        print("USER NOT LOGGED");
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/profile/login');
        });
    }
    
    String data = await api.Api().user(userNameSearch);
    print('ALL DATA: ${data}');
    NetworkImage banner =  NetworkImage("https://media.wired.com/photos/5abece0a9ccf76090d775185/master/pass/hangoutsscreen_2.jpg");
    NetworkImage icon =  NetworkImage("https://pbs.twimg.com/profile_images/1315625686401519616/-WIT7LEg_400x400.jpg");
    var app = json.decode(data);
    try {
        icon = NetworkImage(app['data']['icon_img'].split('?')[0]);
    } catch (e) {
        print('ERROR => ${e}');
    }
    String name = app['data']['subreddit']['title'] ?? "Art Nö";
    String username = app['data']['subreddit']['display_name_prefixed'] ?? "u/artnö";
    String description = app['data']['subreddit']['public_description'] ?? "The best reddit client: Telerama";
    int karma = app['data']['total_karma'] ?? 0;
    int subscribers = app['data']['subscribers'] ?? 0;
    profile = UserInformations(
      name: name,
      username: username,
      description: description,
      icon: icon,
      banner: banner,
      karma: karma,
      subscribers: subscribers
    );
    return ("success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        SingleChildScrollView(
          child: Column(
          children: [
            FutureBuilder<String>(
              future: _buildProfile(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return (AccountPresentation(
                  profilePicture: profile.icon,
                  backgroundImage: profile.banner,
                  name: profile.name,
                  karma: profile.karma,
                  username: profile.username,
                  desc: profile.description));
                }
              }
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Divider(
                  height: 4,
                ),
                Setting(icon: Icons.accessibility_new, name: '18+', statusGave: false),
                Divider(
                  height: 4,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Setting(icon: Icons.mouse, name: 'Allow click Tracking', statusGave: true),
                Divider(
                  height: 4,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Setting(icon: Icons.build_rounded, name: 'Beta', statusGave: true),
                Divider(
                  height: 4,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Setting(icon: Icons.mouse_outlined, name: 'Clickgadget', statusGave: true),
                Divider(
                  height: 4,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Setting(icon: Icons.message, name: 'Collapse read Messages', statusGave: true),
                Divider(
                  height: 4,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Setting(icon: Icons.compress, name: 'Compress', statusGave: true),
              ]
            )
        ]
    )));
  }
}
