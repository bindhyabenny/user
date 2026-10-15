class Geo {
  final String lat;
  final String lng;

  const Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat']?.toString() ?? '0.0',
      lng: json['lng']?.toString() ?? '0.0',
    );
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street']?.toString() ?? '',
      suite: json['suite']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      zipcode: json['zipcode']?.toString() ?? '',
      geo: json['geo'] is Map<String, dynamic>
          ? Geo.fromJson(json['geo'] as Map<String, dynamic>)
          : const Geo(lat: '0.0', lng: '0.0'),
    );
  }

  String get fullAddress => '$street, $suite, $city ($zipcode)';
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name']?.toString() ?? '',
      catchPhrase: json['catchPhrase']?.toString() ?? '',
      bs: json['bs']?.toString() ?? '',
    );
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? 'Unknown User',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      address: json['address'] is Map<String, dynamic>
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : const Address(
              street: '',
              suite: '',
              city: '',
              zipcode: '',
              geo: Geo(lat: '0.0', lng: '0.0'),
            ),
      phone: json['phone']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      company: json['company'] is Map<String, dynamic>
          ? Company.fromJson(json['company'] as Map<String, dynamic>)
          : const Company(name: '', catchPhrase: '', bs: ''),
    );
  }

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
