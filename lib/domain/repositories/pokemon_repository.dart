import 'package:dartz/dartz.dart';
import 'package:flutter_pokemon/data/models/pokemon/pokemon_listing.dart';

import '../../common/failure.dart';

abstract class PokemonRepository {
  // Remote
  Future<Either<Failure, List<PokemonListing>>> getPokemonListing({required int page, int limit = 10});
}