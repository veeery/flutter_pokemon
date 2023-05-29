part of 'pokemon_listing_bloc.dart';

abstract class PokemonListingState extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonListingInitial extends PokemonListingState {}

class PokemonListingEmpty extends PokemonListingState {}

class PokemonListingLoading extends PokemonListingState {}

class PokemonListingLoadMoreError extends PokemonListingState {
  final bool isFailed;

  PokemonListingLoadMoreError({this.isFailed = false});

  @override
  List<Object> get props => [isFailed];
}

class PokemonListingLoaded extends PokemonListingState {
  final List<PokemonListing> pokemonListing;
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;

  PokemonListingLoaded({
    required this.pokemonListing,
    required this.page,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [pokemonListing];
}

class PokemonListingError extends PokemonListingState {
  final String message;

  PokemonListingError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
