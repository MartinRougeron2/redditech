import 'package:flutter/cupertino.dart';

@immutable
class SubReddit {
  SubReddit({
    required this.nbSub,
    required this.id,
    required this.name,
    required this.description,
    this.image = const NetworkImage('https://picsum.photos/250?image=9')
  });

  final NetworkImage image;
  final int nbSub;
  final String id;
  final String name;
  final String description;

  @override
  String toString() {
    return '$name';
  }

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  String nbSubToString() {
    return nbSub.toString().replaceAllMapped(reg, mathFunc);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SubReddit && other.name == name;
  }
}


class UserInformations {
    UserInformations(
      {
        required this.name,
        required this.username,
        required this.description,
        required this.icon,
        required this.banner,
        required this.karma,
        required this.subscribers
    });

        final String name;
        final String username;
        final String description;
        final NetworkImage icon;
        final NetworkImage banner;
        final int karma;
        final int subscribers;
    }
