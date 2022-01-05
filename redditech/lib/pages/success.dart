import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushNamed(context, '/feed');
    });
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200],
                    child: Column(children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
                      Text('Redirection to App....', textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w200, fontSize: 30)),
                      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
                    ])
                )
            )
        )
    );
  }
}