class PokemonListing {
  final String id;
  final String name;
  final String url;

  PokemonListing({
    required this.id,
    required this.name,
    required this.url,
  });

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    return PokemonListing(
        id: json['url'].toString().split('/')[6].toString(),
        name: json['name'],
        url:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['url'].toString().split('/')[6].toString()}.png');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }

}
