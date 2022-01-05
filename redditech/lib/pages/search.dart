import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:reditech/components/subRedditPreview.dart';
import 'package:reditech/types.dart';
import 'package:reditech/api.dart' as API;

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
      child: AutocompleteSubReddit(),
    );
  }
}

class AutocompleteSubReddit extends StatefulWidget {
  @override
  State<AutocompleteSubReddit> createState() => AutocompleteSubRedditState();
}

// If no text, display old subreddit visits

class AutocompleteSubRedditState extends State<AutocompleteSubReddit> {
  static List<SubReddit> _userOptions = <SubReddit>[];

  setUserOptions(value) async {}

  fetchSubs(value) async {
    List<SubReddit> tmp = await API.fetchSubsFromApi(value);
    setState(() {
      _userOptions = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Column(children: [
              TextField(
                autofocus: true,
                onChanged: fetchSubs,
              ),
              for (SubReddit found in _userOptions)
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                    child: subRedditPreview(
                        name: found.name,
                        id: found.id,
                        nbSubString: found.nbSubToString(),
                        image: found.image,
                        description: found.description)),
        ])));
  }
}
