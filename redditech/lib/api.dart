import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reditech/types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'components/posting.dart';
import 'token.dart' as token;

void setData(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> getData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = (prefs.getString(key) ?? "EMPTY");
  print("${key} => ${value}");

  return (value);
}

Future<bool> clearData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (await prefs.clear());
}

class Api {
  String TOKEN = "";
  static const DEBUG_STATE = true;
  static Map<String, dynamic> payload = {
    "accept_pms": 'everyone',
    "activity_relevant_ads": true,
    "allow_clicktracking": true,
    "bad_comment_autocollapse": 'off',
    "beta": true,
    "clickgadget": true,
    "collapse_read_messages": true,
    "compress": true,
    "country_code": 'EN',
    "creddit_autorenew": true,
    "default_comment_sort": 'new',
    "domain_details": true,
    "email_chat_request": true,
    "email_comment_reply": true,
    "email_community_discovery": true,
    "email_digests": true,
    "email_messages": true,
    "email_new_user_welcome": true,
    "email_post_reply": true,
    "email_private_message": true,
    "email_unsubscribe_all": true,
    "email_upvote_comment": true,
    "email_upvote_post": true,
    "email_user_new_follower": true,
    "email_username_mention": true,
    "enable_default_themes": true,
    "enable_followers": true,
    "feed_recommendations_enabled": true,
    "g": 'US',
    "hide_ads": true,
    "hide_downs": true,
    "hide_from_robots": true,
    "hide_ups": true,
    "highlight_controversial": true,
    "highlight_new_comments": true,
    "ignore_suggested_sort": true,
    "in_redesign_beta": true,
    "label_nsfw": true,
    "lang": 'en-US',
    "legacy_search": true,
    "live_orangereds": true,
    "mark_messages_read": true,
    "media": 'off',
    "media_preview": 'off',
    "min_comment_score": -100,
    "min_link_score": -100,
    "monitor_mentions": true,
    "newwindow": true,
    "nightmode": true,
    "no_profanity": true,
    "num_comments": 1,
    "numsites": 1,
    "organic": true,
    "other_theme": 'unixporn',
    "over_18": true,
    "private_feeds": true,
    "profile_opt_out": true,
    "public_votes": true,
    "research": true,
    "search_include_over_18": true,
    "send_crosspost_messages": true,
    "send_welcome_messages": true,
    "show_flair": true,
    "show_gold_expiration": true,
    "show_link_flair": true,
    "show_location_based_recommendations": true,
    "show_presence": true,
    "show_promote": true,
    "show_stylesheets": true,
    "show_trending": true,
    "show_twitter": true,
    "store_visits": true,
    "survey_last_seen_time": 0,
    "theme_selector": "unixporn",
    "third_party_data_personalized_ads": true,
    "third_party_personalized_ads": true,
    "third_party_site_data_personalized_ads": true,
    "third_party_site_data_personalized_content": true,
    "threaded_messages": true,
    "threaded_modmail": true,
    "top_karma_subreddits": true,
    "use_global_defaults": true,
    "video_autoplay": true
  };
  static Map<String, String> convert = {
    "18+" : "over_18",
    "Allow click Tracking" : "allow_clicktracking",
    "Beta" : "beta",
    "Clickgadget" : "clickgadget",
    "Collapse read Messages" : "collapse_read_messages"
  };
  static const Map<String, String> scopes = {
    "IDENTITY": "identity",
    "EDIT": "edit",
    "FLAIR": "flair",
    "MODPOSTS": "modposts",
    "MODWIKI": "modwiki",
    "MODFLAIR": "modflair",
    "MODLOG": "modlog",
    "MYSUBREDDITS": "mysubreddits",
    "PRIVATEMESSAGES": "privatemessages",
    "READ": "read",
    "REPORT": "report",
    "SAVE": "save",
    "SUBMIT": "submit",
    "SUBSCRIBE": "subscribe",
    "VOTE": "vote",
    "WIKIEDIT": "wikiedit",
    "WIKIREAD": "wikiread"
  };
  static const Map<String, String> types = {
    "BEST": "best",
    "HOT": "hot",
    "NEW": "new",
    "RANDOM": "random",
    "RISING": "rising",
    "CONTROVERSIAL": "controversial"
  };
  static const Map<String, String> durations = {
    "TEMPORARY": "temporary",
    "PERMANENT": "permanent"
  };

  static const String clientId = "K8_N7ZiJEjVTZgw8FOltdQ";
  static const String redirect = "com.example.reditech://success";
  static const String baseUrl = "https://reddit.com/api/v1/authorize?";

  Future<bool> check() async {
    final headers = {"userAgent": "reditech", "Authorization": 'bearer ${await getData("TOKEN")}' };
    final response = await http.get(Uri.parse("https://www.reddit.com/.json"), headers: headers);
    
    DEBUG('HEADERS => ${headers}');

    if (response.statusCode != 200)
        return (false);
    return (true);
  }

  Future<String> get(String url, bool required) async {
    var response;
    var headers = {"userAgent": "reditech", "Authorization": 'bearer ${await getData("TOKEN")}' };
    if (required == false) {
      response = await http.get(Uri.parse(url));
    } else {
      response = await http.get(Uri.parse(url), headers: headers);
    }

    DEBUG('HEADERS => ${headers}');
    if (response.statusCode == 200) {
      DEBUG(response.body);
      return (response.body);
    } else {
      DEBUG(response.body);
      throw Exception("GET error: ${url}");
    }
  }

  Future<String> post(String url, bool required) async {
    var response;
    var headers = {"userAgent": "reditech", "Authorization": 'bearer ${await getData("TOKEN")}'};

    if (required == false) {
      response = await http.post(Uri.parse(url));
    } else {
      response = await http.post(Uri.parse(url), headers: headers);
    }

    if (response.statusCode == 200) {
      DEBUG(response.body);
      return (response.body);
    } else {
      DEBUG(response.body);
      throw Exception("POST error: ${url}");
    }
  }

  Future<String> patch(String url, bool required) async {
    var response;
    var defaultHeaders = {'Content-type': 'application/json', 'Accept': 'application/json'};
    var headers = {"userAgent": "reditech", "Authorization": 'bearer ${await getData("TOKEN")}'};

    if (required == false) {
      response = await http.patch(Uri.parse(url), body: payload);
    } else { 
      response = await http.patch(Uri.parse(url), body: payload, headers: headers);
    }

    if (response.statusCode == 200) {
      DEBUG(response.body);
      return (response.body);
    } else {
      DEBUG(response.body);
      throw Exception("PATCH error: ${url}");
    }
  }

  Future<String> getUser(String username) async {
    String url = "https://www.reddit.com/user/${username}/about.json";
    final response = await get(url, false);

    DEBUG(response);

    return (response);
  }

  void DEBUG(String value) {
    if (DEBUG_STATE == true) {
      print(value);
    }
  }

  Future<String> login(String scope) async {
    String userToken = token.generate();
    String url = '${baseUrl}client_id=${clientId}&response_type=code&state=${userToken}&redirect_uri=${redirect}&duration=${durations["PERMANENT"]}&scope=${scopes["${scope}"]}';
    final response = await get(url, false);

    return (response);
  }

  Future<String> refresh() async {
    String url = 'https://www.reddit.com/api/v1/access_token?grant_type=refresh_token&refresh_token=${getData("TOKEN")}';
    String auth = await getData("AUTHURL");
    String callback = await getData("CALLBACK");
    final result = await FlutterWebAuth.authenticate(
        url: auth,
        callbackUrlScheme: callback
    );
    final response = await post(url, true);
    
    return (response);
  }

  Future<String> me() async {
    String url = 'https://www.reddit.com/api/v1/me/prefs.json';
    final response = await get(url, true);

    return (response);
  }

  Future<String> search(String sub) async {
    String url = 'https://www.reddit.com/subreddits/search.json?q=${sub}';
    final response = await get(url, false);

    return (response);
  }

  Future<String> user(String username) async {
    String url = 'https://www.reddit.com/user/${username}/about.json';
    final response = await get(url, false);

    return (response);
  }

  Future<String> posts(String subreddit, String sort, int limit, int after) async {
    String url;
    String response;

    if (subreddit.isNotEmpty) {
      url = 'https://www.reddit.com/r/${subreddit}new.json?sort=${sort}&limit=${limit}&after=${after}';
      response = await get(url, false);
    } else {
      url = 'https://www.reddit.com/${sort}.json';
      response = await get(url, false);
    }

    return (response);
  }

  Future<String> upvote(String id) async {
    String url = 'https://www.reddit.com/api/vote/id=${id}&dir=1&api_type=json';
    var response = "";
    String token = await getData("TOKEN");

    if (token != "EMPTY")
        response = await post(url, true);
    else
        throw Exception("USER NOT LOGGED FOR UPVOTE");

    return (response);
  }

  Future<String> settings(String item, bool value) async {
    String url = 'https://www.reddit.com/api/v1/me/prefs';
    payload[convert[item].toString()] = value;
    var response = await patch(url, true);

    return (response);
  }
}

String sortType = "hot";

Future<List<Posting>> getPostsFromAPI(int numberPosts, int after) async {
  List<Posting> posts = [];

  String author = "";
  String name = "";
  String description = "";
  String id = "";
  String data = await Api().posts('', sortType, numberPosts, after);
  print(sortType);
  Map<String, dynamic> converted = json.decode(data);

  for (int i = 0; i < converted["data"]["children"].length; i++) {
    name = converted["data"]["children"][i]["data"]["title"];
    author = converted["data"]["children"][i]["data"]["author"];
    description = converted["data"]["children"][i]["data"]["selftext"] ?? "";
    id = converted["data"]["children"][i]["data"]["subreddit_id"];
    posts.add(Posting(title: name, id: id, desc: description, profileName: author));
  }
  return posts;
}

Future<List<SubReddit>> fetchSubsFromApi(String value) async {
  List<SubReddit> subsReddit = <SubReddit>[];
  int number = 0;
  String name = "";
  String description = "";
  String id = "";
  NetworkImage imageData =
      const NetworkImage('https://picsum.photos/250?image=9');
  String data = await Api().search(value);
  Map<String, dynamic> converted = json.decode(data);

  for (int i = 0; i < 5 && i < converted["data"]["children"].length; i++) {
    name = converted["data"]["children"][i]["data"]["url"].split("/r/")[1];
    description = converted["data"]["children"][i]["data"]["public_description"];
    id = converted["data"]["children"][i]!["subreddit_id"] ?? "";
    if (converted["data"]["children"][i]["data"]["header_img"] != null)
      imageData =
          NetworkImage(converted["data"]["children"][i]["data"]["header_img"]);
    try {
      number = int.parse(
          '${converted["data"]["children"][i]["data"]["subscribers"]}');
      print('SUBSCRIBERS = ${number}');
    } catch (e) {
      print('ERROR => ${e}');
      number = 0;
    }
    subsReddit.add(SubReddit(id: id,name: name, nbSub: number, image: imageData, description: description));
  }
  return subsReddit;
}
