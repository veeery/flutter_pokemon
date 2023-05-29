part of 'pokemon_listing_bloc.dart';

abstract class PokemonListingEvent extends Equatable {
  const PokemonListingEvent();
}

class FetchPokemonListingEvent extends PokemonListingEvent {
  const FetchPokemonListingEvent();

  @override
  List<Object> get props => [];
}

class NextPageEvent extends PokemonListingEvent {
  const NextPageEvent();
  @override
  List<Object> get props => [];
}