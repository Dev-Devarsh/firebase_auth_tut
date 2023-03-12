class PartsDetails {
    PartsDetails({
        required this.partsDetails,
    });

     PartsDetailsData partsDetails;

    factory PartsDetails.fromJson(Map<String, dynamic> json) => PartsDetails(
        partsDetails: PartsDetailsData.fromJson(json["partsDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "partsDetails": partsDetails.toJson(),
    };
}

class PartsDetailsData {
    PartsDetailsData({
        required this.uid,
        required this.partsList,
        required this.firstName,
        required this.lastName,
        required this.garageAddress,
        required this.garageName,
        required this.garageSubtitle,
        required this.phoenNumber,
        required this.rating,
    });

     String uid;
     List<dynamic> partsList;
     String firstName;
     String lastName;
     String garageAddress;
     String garageName;
     String garageSubtitle;
     String phoenNumber;
     int rating;

    factory PartsDetailsData.fromJson(Map<String, dynamic> json) => PartsDetailsData(
        uid: json["uid"],
        partsList: List<dynamic>.from(json["partsList"].map((x) => x)),
        firstName: json["firstName"],
        lastName: json["last_name"],
        garageAddress: json["garage_address"],
        garageName: json["garage_name"],
        garageSubtitle: json["garage_subtitle"],
        phoenNumber: json["phoen_number"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "partsList": List<dynamic>.from(partsList.map((x) => x)),
        "firstName": firstName,
        "last_name": lastName,
        "garage_address": garageAddress,
        "garage_name": garageName,
        "garage_subtitle": garageSubtitle,
        "phoen_number": phoenNumber,
        "rating": rating,
    };
}
