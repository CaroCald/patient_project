import 'package:go_router/go_router.dart';
import 'package:patient_project/core/base/navigation/navigation_service.dart';

class GoRouterNavigationService implements NavigationService {
  final GoRouter _router;

  GoRouterNavigationService(this._router);

  @override
  Future<T?>? push<T>(String routeName, {Object? extra}) {
    return _router.push<T>(routeName, extra: extra);
  }

  @override
  Future<T?>? replace<T>(String routeName, {Object? extra}) {
    return _router.pushReplacement<T>(routeName, extra: extra);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    _router.pop(result);
  }

  @override
  void go(String routeName, {Object? extra}) {
    _router.go(routeName, extra: extra);
  }

  @override
  void goNamed(String routeName, {Object? extra}) {
    _router.goNamed(routeName, extra: extra);
  }

  @override
  void pushNamed(String routeName, {Object? extra}) {
    _router.pushNamed(routeName, extra: extra);
  }

  @override
  void pushReplacementNamed(String routeName, {Object? extra}) {
    _router.pushReplacementNamed(routeName, extra: extra);
  }
}
