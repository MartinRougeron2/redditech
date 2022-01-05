import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reditech/client.dart' as client;
import 'package:uni_links/uni_links.dart';
import 'package:reditech/api.dart' as API;

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  void gotToSuccess() async {
    API.Api api = API.Api();
    String? uri = await getInitialLink();
    if (uri != null && uri.split("code=").length > 0) if (uri
        .split("code=")[1]
        .isNotEmpty) {
      API.setData("TOKEN", uri.split("code=")[1]);
      print("API TOKEN: ${API.getData('TOKEN')}");
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/success');
      });
    }
  }

  client.RedditClient rclient = client.RedditClient();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      gotToSuccess();
    });
    return MaterialApp(
        title: 'Reditech Login',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: Scaffold(
            body: SafeArea(
                child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[200],
                        child: Column(children: [
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
                          Text('Welcome to Art\'no',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 30)),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
                          ElevatedButton(
                            onPressed: () => {rclient.launch()},
                            child: const Text('Login with Reddit'),
                          ),
                        ]))))));
  }
}
