import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_pokemon/common/exception.dart';
import 'package:flutter_pokemon/common/failure.dart';
import 'package:flutter_pokemon/data/datasources/pokemon/pokemon_remote_data_source.dart';
import 'package:flutter_pokemon/data/models/pokemon/pokemon_listing.dart';
import 'package:flutter_pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<PokemonListing>>> getPokemonListing({required int page, int limit = 10})async {
    try {
      final result = await remoteDataSource.getPokemonListing(page: page, limit: limit);
      return Right(result.map((data) => data).toList());
    } on SocketException {
      return const Left(ConnectionFailure());
    } on ServerException {
      return const Left(ServerFailure());
    }
  }



}
