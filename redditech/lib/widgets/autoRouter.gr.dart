// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i8;

import '../pages/home.dart' as _i1;
import '../pages/login.dart' as _i6;
import '../pages/profile.dart' as _i5;
import '../pages/search.dart' as _i3;
import '../pages/subreddit.dart' as _i4;
import '../pages/success.dart' as _i7;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.HomePage());
    },
    SearchRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ProfileRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    SearchRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.SearchPage());
    },
    SubRedditRoute.name: (routeData) {
      final args = routeData.argsAs<SubRedditRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.SubRedditPage(
              key: args.key,
              name: args.name,
              id: args.id,
              nbSubString: args.nbSubString,
              description: args.description,
              image: args.image));
    },
    ProfileRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.ProfilePage());
    },
    LoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.LoginPage());
    },
    SuccessRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.SuccessPage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/'),
        _i2.RouteConfig(SearchRouter.name, path: '/search', children: [
          _i2.RouteConfig(SearchRoute.name,
              path: '', parent: SearchRouter.name),
          _i2.RouteConfig(SubRedditRoute.name,
              path: 'subreddit', parent: SearchRouter.name)
        ]),
        _i2.RouteConfig(ProfileRouter.name, path: '/profile', children: [
          _i2.RouteConfig(ProfileRoute.name,
              path: '', parent: ProfileRouter.name),
          _i2.RouteConfig(LoginRoute.name,
              path: 'login', parent: ProfileRouter.name),
          _i2.RouteConfig(SuccessRoute.name,
              path: 'success', parent: ProfileRouter.name)
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.EmptyRouterPage]
class SearchRouter extends _i2.PageRouteInfo<void> {
  const SearchRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: '/search', initialChildren: children);

  static const String name = 'SearchRouter';
}

/// generated route for [_i2.EmptyRouterPage]
class ProfileRouter extends _i2.PageRouteInfo<void> {
  const ProfileRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: '/profile', initialChildren: children);

  static const String name = 'ProfileRouter';
}

/// generated route for [_i3.SearchPage]
class SearchRoute extends _i2.PageRouteInfo<void> {
  const SearchRoute() : super(name, path: '');

  static const String name = 'SearchRoute';
}

/// generated route for [_i4.SubRedditPage]
class SubRedditRoute extends _i2.PageRouteInfo<SubRedditRouteArgs> {
  SubRedditRoute(
      {_i8.Key? key,
      required String name0,
      required String id,
      required String nbSubString,
      required String description,
      required _i8.NetworkImage image})
      : super(name,
            path: 'subreddit',
            args: SubRedditRouteArgs(
                key: key,
                name: name0,
                id: id,
                nbSubString: nbSubString,
                description: description,
                image: image));

  static const String name = 'SubRedditRoute';
}

class SubRedditRouteArgs {
  const SubRedditRouteArgs(
      {this.key,
      required this.name,
      required this.id,
      required this.nbSubString,
      required this.description,
      required this.image});

  final _i8.Key? key;

  final String name;

  final String id;

  final String nbSubString;

  final String description;

  final _i8.NetworkImage image;
}

/// generated route for [_i5.ProfilePage]
class ProfileRoute extends _i2.PageRouteInfo<void> {
  const ProfileRoute() : super(name, path: '');

  static const String name = 'ProfileRoute';
}

/// generated route for [_i6.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for [_i7.SuccessPage]
class SuccessRoute extends _i2.PageRouteInfo<void> {
  const SuccessRoute() : super(name, path: 'success');

  static const String name = 'SuccessRoute';
}
