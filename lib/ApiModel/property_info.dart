import 'dart:convert';

class Property {
  final int id;
  final String propertyName;
  final String propertyPrice;
  final String propertyAddress;
  final String propertyDistrict;
  final String propertyState;
  final String propertyPin;
  final double propertyLong;
  final double propertyLat;
  final String propertyDescription;
  final String ownerName;
  final String ownerContact;
  final String ownerWhatsapp;
  final List<String> pictureUrls;
  final Agent agent;

  Property({
    required this.id,
    required this.propertyName,
    required this.propertyPrice,
    required this.propertyAddress,
    required this.propertyDistrict,
    required this.propertyState,
    required this.propertyPin,
    required this.propertyLong,
    required this.propertyLat,
    required this.propertyDescription,
    required this.ownerName,
    required this.ownerContact,
    required this.ownerWhatsapp,
    required this.pictureUrls,
    required this.agent,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      propertyName: json['property_name'],
      propertyPrice: json['property_price'],
      propertyAddress: json['property_address'],
      propertyDistrict: json['property_district'],
      propertyState: json['property_state'],
      propertyPin: json['property_pin'],
      propertyLong: double.parse(json['property_long']),
      propertyLat: double.parse(json['property_lat']),
      propertyDescription: json['property_description'],
      ownerName: json['owner_name'],
      ownerContact: json['owner_contact'],
      ownerWhatsapp: json['owner_whatsapp'],
      pictureUrls: List<String>.from(json['picture_urls']),
      agent: Agent.fromJson(json['agent']),
    );
  }
}

class Agent {
  final int id;
  final String name;
  final String email;
  final String contact;
  final String pictureUrl;

  Agent({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.pictureUrl,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      contact: json['contact'].toString(),
      pictureUrl: json['picture_data'],
    );
  }
}
