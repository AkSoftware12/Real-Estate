import 'dart:convert';

class Property {
  final int id;
  final String propertyName;
  final int propertyPrice;
  final String propertyAddress;
  final String propertyDistrict;
  final String propertyState;
  final int propertyPin;
  final String propertyLandmark;
  final String propertyFacing;
  final String? ownerName;
  final int ownerContact;
  final int bulidupArea;
  final int floor;
  final int securityAmt;
  final String? society;
  final int noOfBeds;
  final int noOfKitchen;
  final int noOfBathroom;
  final int? carParking;
  final int water;
  final int invertor;
  final int security;
  final int availabilityStatus;
  final int furnitureStatus;
  final int status;
  final int rentBuyStatus;
  final String? reason;
  final List<String> images;
  final String entryDate;
  final String createdAt;
  final String updatedAt;
  final List<String> pictureUrls;
  final bool? likeFlag;
  final List<Review> reviews;

  Property({
    required this.id,
    required this.propertyName,
    required this.propertyPrice,
    required this.propertyAddress,
    required this.propertyDistrict,
    required this.propertyState,
    required this.propertyPin,
    required this.propertyLandmark,
    required this.propertyFacing,
    this.ownerName,
    required this.ownerContact,
    required this.bulidupArea,
    required this.floor,
    required this.securityAmt,
    this.society,
    required this.noOfBeds,
    required this.noOfKitchen,
    required this.noOfBathroom,
    this.carParking,
    required this.water,
    required this.invertor,
    required this.security,
    required this.availabilityStatus,
    required this.furnitureStatus,
    required this.status,
    required this.rentBuyStatus,
    this.reason,
    required this.images,
    required this.entryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.pictureUrls,
    this.likeFlag,
    required this.reviews,
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
      propertyLandmark: json['property_landmark'],
      propertyFacing: json['property_facing'],
      ownerName: json['owner_name'],
      ownerContact: json['owner_contact'],
      bulidupArea: json['bulidup_area'],
      floor: json['floor'],
      securityAmt: json['security_amt'],
      society: json['society'],
      noOfBeds: json['no_of_beds'],
      noOfKitchen: json['no_of_kitchen'],
      noOfBathroom: json['no_of_bathroom'],
      carParking: json['car_parking'],
      water: json['water'],
      invertor: json['invertor'],
      security: json['security'],
      availabilityStatus: json['availability_status'],
      furnitureStatus: json['furniture_status'],
      status: json['status'],
      rentBuyStatus: json['rent_buy_status'],
      reason: json['reason'],
      images: List<String>.from(jsonDecode(json['images'])),
      entryDate: json['entry_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pictureUrls: List<String>.from(json['picture_urls']),
      likeFlag: json['like_flag'],
      reviews: (json['review'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
    );
  }
}

class Review {
  final int id;
  final int userId;
  final int propertyId;
  final String review;
  final String rating;
  final String createdDate;
  final List<String> images;
  final String createdAt;
  final String updatedAt;
  final List<String> pictureUrls;

  Review({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.review,
    required this.rating,
    required this.createdDate,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.pictureUrls,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['user_id'],
      propertyId: json['property_id'],
      review: json['review'],
      rating: json['rating'],
      createdDate: json['created_date'],
      images: List<String>.from(jsonDecode(json['image'])),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pictureUrls: List<String>.from(json['picture_urls']),
    );
  }
}
