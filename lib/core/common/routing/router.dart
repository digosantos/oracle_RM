import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter buildRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: Routes.root,
          builder: (context, state) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
          redirect: (context, state) async {
            final routeName = await _redirectIfNeeded(context, state);
            return (routeName == Routes.auth) ? Routes.auth : Routes.home;
          },
        ),
        ..._unauthenticatedRoutesBuilder(),
        ..._authenticatedRoutesBuilder(),
      ],
      errorBuilder: (context, state) {
        /// Let's keep an eye on this [https://github.com/flutter/flutter/issues/108144] issue
        /// in order to properly redirect user in case it tries to access un-existent route
        /// instead of a generic error page.
        // TODO: replace with proper error page.
        return Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
          ),
        );
      },
    );
  }

  /// Register list of unauthenticated routes
  List<GoRoute> _unauthenticatedRoutesBuilder() {
    return [
      GoRoute(
        path: Routes.auth,
        builder: (context, state) => Scaffold(
          body: Center(
            child: Auth(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.notFound,
        builder: (context, state) => Scaffold(body: Center(child: Text('404, página não encontrada!'))),
      ),
    ];
  }

  /// Register list of authenticated routes
  List<GoRoute> _authenticatedRoutesBuilder() {
    return [
      GoRoute(
        path: Routes.home,
        builder: (context, state) => Scaffold(
          body: Center(
            child: Text('Olá ninja!\nBom trabalho :)', textAlign: TextAlign.center),
          ),
        ),
        redirect: _redirectIfNeeded,
      ),
    ];
  }

  /// This method should be used whenever we need to prevent a user to visit a specific page.
  /// Initially, we will use it for Authentication purposes. We can improve the logic below to also
  /// contemplate different levels of Authorization.
  ///
  /// NOTE: Sometimes, returning a null string is needed to avoid cyclic loops. [https://github.com/flutter/flutter/issues/113053]
  Future<String?> _redirectIfNeeded(BuildContext context, GoRouterState state) async {
    final bool loggingIn = state.subloc == Routes.auth;

    if (await _isUserAuth()) {
      if (loggingIn) return Routes.root;
      return null;
    } else {
      return loggingIn ? null : Routes.auth;
    }
  }

  Future<bool> _isUserAuth() async {
    var isAuth = false;
    final authCheckUseCase = sl<AuthCheckUseCase>();
    final authCheckInterface = sl<AuthCheckInterface>();
    final result = await authCheckUseCase(authCheckInterface);
    result.fold((l) => isAuth = false, (r) async => {isAuth = await r.isAuth});
    return isAuth;
  }
}
