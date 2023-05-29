import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon/presentation/bloc/pokemon/pokemon_listing/pokemon_listing_bloc.dart';
import 'package:flutter_pokemon/presentation/widget/grid_view_widget.dart';
import 'package:flutter_pokemon/presentation/widget/loadmore_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';

import '../../data/models/pokemon/pokemon_listing.dart';
import '../widget/pokemon_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PokemonListing> pokemonList = [];
  bool isFailed = false;
  bool hasReachedMax = false;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PokemonListingBloc>().add(const FetchPokemonListingEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonListingBloc, PokemonListingState>(
        builder: (context, state) {
          if (state is PokemonListingLoading) {
            return const Center(
              child: Text('Loading...'),
            );
          } else if (state is PokemonListingLoaded || state is PokemonListingLoadMoreError) {
            if (state is PokemonListingLoadMoreError) {
              isFailed = state.isFailed;
            }

            if (state is PokemonListingLoaded) {
              pokemonList = state.pokemonListing;
              hasReachedMax = state.hasReachedMax;
              isLoadingMore = state.isLoadingMore;
            }

            return GridViewWidget(
              hasReachedMax: hasReachedMax,
              isLoadingMore: isLoadingMore,
              isLoadMoreFailed: isFailed,
              itemCount: pokemonList.length,
              shrinkWrap: true,
              event: () {
                context.read<PokemonListingBloc>().add(const NextPageEvent());
              },
              itemBuilder: (context, index) {
                PokemonListing data = pokemonList[index];

                return PokemonCard(pokemonListing: data);
              },
            );
          } else if (state is PokemonListingError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is PokemonListingEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            return const Center(
              child: Text('Not Found'),
            );
          }
        },
      ),
    );
  }
}
