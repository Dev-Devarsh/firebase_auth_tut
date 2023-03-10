// To parse this JSON data, do
//
//     final garageDetails = garageDetailsFromJson(jsonString);

import 'dart:convert';

List<GarageDetails> garageDetailsFromJson(String str) => List<GarageDetails>.from(json.decode(str).map((x) => GarageDetails.fromJson(x)));

String garageDetailsToJson(List<GarageDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GarageDetails {
    GarageDetails({
        required this.garageDetails,
    });

    final GarageDetailsData garageDetails;

    factory GarageDetails.fromJson(Map<String, dynamic> json) => GarageDetails(
        garageDetails: GarageDetailsData.fromJson(json["garageDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "garageDetails": garageDetails.toJson(),
    };
}

class GarageDetailsData {
    GarageDetailsData({
        required this.uid,
        required this.coordinates,
        required this.firstName,
        required this.garageAddress,
        required this.garageName,
        required this.garageSubtitle,
        required this.lastName,
        required this.phoenNumber,
        required this.rating,
    });

    final String uid;
    final Coordinates coordinates;
    final String firstName;
    final String garageAddress;
    final String garageName;
    final String garageSubtitle;
    final String lastName;
    final String phoenNumber;
    final int rating;

    factory GarageDetailsData.fromJson(Map<String, dynamic> json) => GarageDetailsData(
        uid: json["uid"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        firstName: json["firstName"],
        garageAddress: json["garage_address"],
        garageName: json["garage_name"],
        garageSubtitle: json["garage_subtitle"],
        lastName: json["last_name"],
        phoenNumber: json["phoen_number"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "coordinates": coordinates.toJson(),
        "firstName": firstName,
        "garage_address": garageAddress,
        "garage_name": garageName,
        "garage_subtitle": garageSubtitle,
        "last_name": lastName,
        "phoen_number": phoenNumber,
        "rating": rating,
    };
}

class Coordinates {
    Coordinates({
        required this.lat,
        required this.long,
    });

    final double lat;
    final double long;

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
    };
}
