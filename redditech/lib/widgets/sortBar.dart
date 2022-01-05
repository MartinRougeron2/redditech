import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reditech/api.dart' as api;

import 'package:select_dialog/select_dialog.dart';

class SortBar extends StatefulWidget {
  @override
  State<SortBar> createState() => SortBarState();
}

class SortBarState extends State<SortBar> {
  String value = 'flutter';

  @override
  Widget build(BuildContext context) {
    List<SortTypeItem> SortTypeItemList = [
      SortTypeItem(
          label: "Best",
          value: "best",
          icon: Icon(Icons.arrow_upward),
          iconWhite: Icon(Icons.arrow_upward, color: Colors.white)),
      SortTypeItem(
          label: "Hot",
          value: "hot",
          icon: Icon(Icons.whatshot),
          iconWhite: Icon(Icons.whatshot, color: Colors.white)),
      SortTypeItem(
          label: "New",
          value: "new",
          icon: Icon(Icons.new_releases),
          iconWhite: Icon(Icons.new_releases, color: Colors.white)),
      SortTypeItem(
          label: "Random",
          value: "random",
          icon: Icon(Icons.casino_outlined),
          iconWhite: Icon(Icons.casino_outlined, color: Colors.white)),
    ];
    SortTypeItem value = SortTypeItemList[0];
    for (SortTypeItem item in SortTypeItemList)
      if (api.sortType == item.value) value = item;

    return Container(
      constraints: BoxConstraints.expand(
        height: 40,
      ),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      color: Colors.indigo,
      alignment: Alignment.center,
      child: Row(
        children: [
          Text('Sort by', style: TextStyle(color: Colors.white, fontSize: 20)),
          Spacer(),
          InkWell(
            child: Row(children: [
              Text(value.label,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
              value.iconWhite,
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0))
            ]),
            onTap: () {
              SelectDialog.showModal<SortTypeItem>(
                context,
                label: "Sort Type",
                items: SortTypeItemList,
                selectedValue: value,
                showSearchBox: false,
                itemBuilder:
                    (BuildContext context, SortTypeItem item, bool isSelected) {
                  return Container(
                    decoration: !isSelected
                        ? null
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                    child: ListTile(
                      leading: item.icon,
                      selected: isSelected,
                      title: Text(item.label),
                    ),
                  );
                },
                onChange: (selected) {
                  setState(() {
                    value = selected;
                    api.sortType = value.value;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SortTypeItem {
  String label = "";
  String value = "";
  Icon icon = Icon(Icons.star);
  Icon iconWhite = Icon(Icons.star);

  SortTypeItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.iconWhite});
}
