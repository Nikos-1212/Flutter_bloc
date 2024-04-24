import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management/src/presentation/blocs/productList/product_list_bloc.dart';
import 'package:inventory_management/src/presentation/views/landing_page.dart';
import 'package:inventory_management/src/presentation/widgets/page_under_construction.dart';
import 'package:inventory_management/src/utils/utils.dart';
import '../presentation/views/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider<ProductListBloc>(
          create: (context) => ProductListBloc(),
          child: const SplashScreen(
              nextScreen: HomeScreen(title: AppConst.enventory)),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings? settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
