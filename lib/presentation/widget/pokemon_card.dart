import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/data/models/pokemon/pokemon_listing.dart';

class PokemonCard extends StatelessWidget {
  final PokemonListing pokemonListing;

  const PokemonCard({super.key, required this.pokemonListing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 5,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: pokemonListing.url,
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 20,
            child: Image.asset(height: 75, 'assets/poke_ball_open.png'),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Text(pokemonListing.name),
          )
        ],
      ),
    );
  }
}
