import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon/common/responsive.dart';
import 'package:flutter_pokemon/presentation/bloc/pokemon/pokemon_listing/pokemon_listing_bloc.dart';
import 'package:flutter_pokemon/presentation/pages/home_page.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.locator<PokemonListingBloc>()),
        ],
        child: MaterialApp(
          builder: (context, child) {
            AppResponsive.init(context: context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
          home: const HomePage(),
          // onGenerateRoute: ,
        ));
  }
}
