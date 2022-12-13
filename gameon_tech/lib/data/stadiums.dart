class Stadiums {
  static final List<Stadium> _list = [
    Stadium(
      name: 'Wankhede International cricket Stadium',
      city: 'Mumbai, Maharashtra',
      image: 'assets/images/wankhede.png',
      distance: 'Navigate',
    ),
    Stadium(
      name: 'Narendra Modi Stadium',
      city: 'Gujrat, Ahmedabad',
      image: 'assets/images/narendra.png',
      distance: 'Only 4 Km far.',
    ),
    Stadium(
      name: 'Jawaharlal Nehru Stadium',
      city: 'Delhi NCR, Delhi',
      image: 'assets/images/jawaharlal.png',
      distance: 'Only 2 Km far.',
    ),
  ];

  static List<Stadium> get list => _list;
}

class Stadium {
  final String name;
  final String city;
  final String image;
  final String distance;

  Stadium({
    required this.name,
    required this.city,
    required this.image,
    required this.distance,
  });
}
