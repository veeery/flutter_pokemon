import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/pokemon/pokemon_listing.dart';
import '../../../../domain/usecases/pokemon/get_pokemon_listing.dart';

part 'pokemon_listing_event.dart';

part 'pokemon_listing_state.dart';

class PokemonListingBloc extends Bloc<PokemonListingEvent, PokemonListingState> {
  // remote
  final GetPokemonListing getPokemonListing;

  List<PokemonListing> pokemonListing = [];
  int page = 1;

  PokemonListingBloc({
    required this.getPokemonListing,
  }) : super(PokemonListingInitial()) {
    on<FetchPokemonListingEvent>((event, emit) async {
      emit(PokemonListingLoading());

      page = 1;

      final result = await getPokemonListing.execute(page: page);

      result.fold((failure) {
        emit(PokemonListingError(message: failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(PokemonListingEmpty());
        } else {
          pokemonListing = [];
          pokemonListing = data;
          emit(PokemonListingLoaded(pokemonListing: pokemonListing, page: page));
        }
      });
    });

    on<NextPageEvent>((event, emit) async {
      page++;

      emit(PokemonListingLoaded(pokemonListing: pokemonListing, page: page, isLoadingMore: true));

      final result = await getPokemonListing.execute(page: page);

      result.fold((failure) {
        page--;
        emit(PokemonListingLoadMoreError(isFailed: true));
      }, (data) {
        if (data.isEmpty) {
          emit(PokemonListingLoaded(pokemonListing: pokemonListing, page: page, hasReachedMax: true));
        } else {
          pokemonListing.addAll(data);
          emit(PokemonListingLoaded(pokemonListing: pokemonListing, page: page, isLoadingMore: false));
        }
      });
    });
  }
}
