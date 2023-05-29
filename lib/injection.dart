

import 'package:dio/dio.dart';
import 'package:flutter_pokemon/common/app_dio.dart';
import 'package:flutter_pokemon/data/datasources/pokemon/pokemon_remote_data_source.dart';
import 'package:flutter_pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_pokemon/domain/repositories/pokemon_repository.dart';
import 'package:flutter_pokemon/domain/usecases/pokemon/get_pokemon_listing.dart';
import 'package:flutter_pokemon/presentation/bloc/pokemon/pokemon_listing/pokemon_listing_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;


void init() {
  // BLoC
  locator.registerFactory(() => PokemonListingBloc(getPokemonListing: locator()));



  // Use Case
  locator.registerLazySingleton(() => GetPokemonListing(locator()));

  // Repository

  locator.registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl(remoteDataSource: locator()));


  // DataSources
  locator.registerLazySingleton<PokemonRemoteDataSource>(() => PokemonRemoteDataSourceImpl(dioClient: locator()));


  // Database Helper
  // locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // External
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<DioClient>(() => DioClient(locator<Dio>()));



}