import 'package:dio/dio.dart';
import 'package:flutter_pokemon/common/app_dio.dart';
import 'package:flutter_pokemon/common/constants.dart';
import 'package:flutter_pokemon/common/exception.dart';
import 'package:flutter_pokemon/data/models/pokemon/pokemon_listing.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonListing>> getPokemonListing({required int page, int limit = 5});
}

class PokemonRemoteDataSourceImpl extends PokemonRemoteDataSource {
  final DioClient dioClient;

  PokemonRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<PokemonListing>> getPokemonListing({required int page, int limit = 5}) async {
    List<PokemonListing> pokemonListing = [];

    try {
      Response response = await dioClient.dio.get("$baseUrl/pokemon?offset=$page&limit=$limit");

      List<dynamic> result = response.data['results'];

      for (var json in result) {
        pokemonListing.add(PokemonListing.fromJson(json));
      }

      return pokemonListing;
    } catch (e) {
      throw ServerException();
    }
  }
}
