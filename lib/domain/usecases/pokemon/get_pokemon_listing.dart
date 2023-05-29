import 'package:dartz/dartz.dart';
import 'package:flutter_pokemon/data/models/pokemon/pokemon_listing.dart';
import 'package:flutter_pokemon/domain/repositories/pokemon_repository.dart';

import '../../../common/failure.dart';

class GetPokemonListing {
  final PokemonRepository repository;

  GetPokemonListing(this.repository);

  Future<Either<Failure, List<PokemonListing>>> execute({required int page, int limit = 10}) {
    return repository.getPokemonListing(page: page, limit: limit);
  }

}