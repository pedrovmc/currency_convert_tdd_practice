import 'package:currency_convert_tdd_practice/app/features/convert/presenter/convert_page.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/select_currencies_page.dart';
import 'package:currency_convert_tdd_practice/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      routerConfig: goRouter,
    );
  }
}

var goRouter = GoRouter(
  routes: [
    GoRoute(
      path: Routes.selectCurrencies.path,
      name: Routes.selectCurrencies.name,
      builder: (context, state) => SelectCurrenciesPage(
        selectCurrenciesController: GetIt.I.get(),
      ),
    ),
    GoRoute(
      path: Routes.convert.path,
      name: Routes.convert.name,
      builder: (context, state) {
        return ConvertPage(
            convertController: GetIt.I.get(),
            to: (state.extra as Map)["to"],
            from: (state.extra as Map)["from"]);
      },
    )
  ],
);
