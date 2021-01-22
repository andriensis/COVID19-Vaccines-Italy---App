import 'package:covid19_vaccines_app/pages/home/home.dart';
import 'package:covid19_vaccines_app/pages/home/home_view_model.dart';
import 'package:covid19_vaccines_app/pages/region_details/region_details.dart';
import 'package:covid19_vaccines_app/pages/region_details/region_details_view_model.dart';
import 'package:covid19_vaccines_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  AppRouteParser _routeInformationParser = AppRouteParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Globals.PRIMARY_COLOR_MATERIAL),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Globals.PRIMARY_COLOR_MATERIAL),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'COVID19 Vaccines',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class AppRouteParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length >= 2) {
      var remaining = uri.pathSegments[1];
      return AppRoutePath.details(remaining);
    } else {
      return AppRoutePath.home();
    }
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/region/${path.id}');
    }
    return null;
  }
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  String _selectedRegionArea;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  AppRoutePath get currentConfiguration => _selectedRegionArea == null
      ? AppRoutePath.home()
      : AppRoutePath.details(_selectedRegionArea);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      transitionDelegate: NoAnimationTransitionDelegate(),
      pages: [
        MaterialPage(
            key: ValueKey('Home'),
            child: ChangeNotifierProvider(
              create: (context) => HomeViewModel(),
              child: LatestDataPage(
                  onRegionTap: (String regionArea) =>
                      _handleRegionTapped(regionArea)),
            )),
        if (_selectedRegionArea != null)
          MaterialPage(
              key: ValueKey('Details'),
              child: ChangeNotifierProvider(
                create: (context) => RegionDetailsViewModel(),
                child: RegionDetailsPage(regionArea: _selectedRegionArea),
              ))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _selectedRegionArea = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    if (path.isDetailsPage) {
      _selectedRegionArea = path.id;
    }
  }

  void _handleRegionTapped(String regionArea) {
    _selectedRegionArea = regionArea;
    notifyListeners();
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    List<RouteTransitionRecord> newPageRouteHistory,
    Map<RouteTransitionRecord, RouteTransitionRecord>
        locationToExitingPageRoute,
    Map<RouteTransitionRecord, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }

      results.add(exitingPageRoute);
    }
    return results;
  }
}

class AppRoutePath {
  final String id;

  AppRoutePath.home() : id = null;
  AppRoutePath.details(this.id);
  bool get isHomePage => id == null;
  bool get isDetailsPage => id != null;
}
