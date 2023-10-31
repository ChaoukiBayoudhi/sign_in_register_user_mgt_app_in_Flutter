import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sign_in_register_user_mgt_app/screens/not_found_screen.dart';
import 'package:sign_in_register_user_mgt_app/screens/register_screen.dart';
import 'package:sign_in_register_user_mgt_app/screens/sign_in_screen.dart';
import 'package:sign_in_register_user_mgt_app/screens/user_mgt_screen.dart';

class AppRouterDelegate extends RouterDelegate<RouteSettings>{
  final GlobalKey<NavigatorState> navigatorKey;
  final  List<Page> pages;

  AppRouterDelegate(this.navigatorKey, this.pages);
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (page, dynamic _) {
        if (pages.length > 1) {
          pages.removeLast();
          return true;
        } else {
          return false;
        }
      },
      
    );
  }

  @override
  Future<bool> popRoute() async{
    if (pages.length > 1) {
      pages.removeLast();
      return true;
    } else {
      return false;
    }
  }
  
  @override
  void addListener(VoidCallback listener) {
  }
  
  @override
  void removeListener(VoidCallback listener) {
  }
  
  @override
Future<void> setNewRoutePath(RouteSettings configuration) async {
  final String? routeName = configuration.name;
  final BuildContext? context = navigatorKey.currentContext;

  // Define a map of route names to page builder functions.
  final Map<String, Widget Function(BuildContext)> pageBuilders = {
    '/login': (context) => const SignInScreen(),
    '/register': (context) => const RegisterScreen(),
    '/user-dashboard': (context) => const UserDashBoard(),
    // Add more routes as needed.
  };

  if (pageBuilders.containsKey(routeName)) {
    // If the route name is recognized, create a corresponding page.
    final page = MaterialPage(
      key: ValueKey(routeName),
      child: pageBuilders[routeName]!(context!),
    );

    // Update the list of pages.
    pages.add(page);
  } else {
    // Handle unknown routes, e.g., show a not-found page.
    const notFoundPage = MaterialPage(
      key: ValueKey('not-found'),
      child: NotFoundScreen(),
    );

    // Update the list of pages.
    pages.add(notFoundPage);
  }

}

  @override
  RouteSettings get currentConfiguration => RouteSettings(name: pages.last.name);
}

