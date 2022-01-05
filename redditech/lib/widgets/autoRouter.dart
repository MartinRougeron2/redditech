import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import 'package:reditech/pages/login.dart';
import 'package:reditech/pages/home.dart';
import 'package:reditech/pages/profile.dart';
import 'package:reditech/pages/search.dart';
import 'package:reditech/pages/subreddit.dart';
import 'package:reditech/pages/success.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/',         name: 'HomeRoute',      page: HomePage, initial: true),
    AutoRoute(path: '/search',   name: 'SearchRouter',   page: EmptyRouterPage, children: [
      AutoRoute(path: '',            name: 'SearchRoute',    page: SearchPage),
        AutoRoute(path: 'subreddit', name: 'SubRedditRoute', page: SubRedditPage),
    ]),
    AutoRoute(path: '/profile',  name: 'ProfileRouter', page: EmptyRouterPage, children: [
        AutoRoute(path: '',          name: 'ProfileRoute', page: ProfilePage),
        AutoRoute(path: 'login',     name: 'LoginRoute',   page: LoginPage),
        AutoRoute(path: 'success',   name: 'SuccessRoute', page: SuccessPage),
    ]),
  ],
)
class $AppRouter {}
