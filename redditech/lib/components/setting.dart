import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:reditech/api.dart';

class Setting extends StatefulWidget {
  Setting(
      {Key? key,
      required this.icon,
      required this.name,
      this.desc = "",
      required this.statusGave})
      : super(key: key);

  final IconData icon;
  final String name;
  final String desc;
  final bool statusGave;

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {

  bool status = true;

  @override
  void initState() {
    super.initState();
    status = widget.statusGave;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
      child: Row(
        children: [
          Icon(widget.icon),
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              if (widget.desc.isNotEmpty) Text(widget.desc, style: TextStyle(color: Colors.grey)),
            ],
          ),
          Spacer(),
          Switch(
            value: status,
            onChanged: (value) {
              setState(() {
                status = value;
                Api().settings(widget.name, status);
              });
            },
            activeTrackColor: Colors.indigo.shade50,
            activeColor: Colors.indigo,
          ),
        ],
      ),
    );
  }
}
