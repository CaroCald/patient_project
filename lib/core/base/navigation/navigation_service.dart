abstract class NavigationService {
  Future<T?>? push<T>(String routeName, {Object? extra});
  Future<T?>? replace<T>(String routeName, {Object? extra});
  void pop<T extends Object?>([T? result]);
  void go(String routeName, {Object? extra});
  void goNamed(String routeName, {Object? extra});
  void pushNamed(String routeName, {Object? extra});
  void pushReplacementNamed(String routeName, {Object? extra});
}
