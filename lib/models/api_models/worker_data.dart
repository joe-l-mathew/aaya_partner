class WorkerData {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int phoneNumber;
  final String name;
  final String profileURL;
  final String fcmToken;
  final String email;
  final dynamic jobs; // You may need to replace 'dynamic' with the actual data type.
  final WorkerCurrentLocation workerCurrentLocation;
  final WorkerDetails workerDetails;
  final WorkerVerificationStatus workerVerificationStatus;
  final String token;

  WorkerData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.name,
    required this.profileURL,
    required this.fcmToken,
    required this.email,
    required this.jobs, // Replace 'dynamic' with the actual data type.
    required this.workerCurrentLocation,
    required this.workerDetails,
    required this.workerVerificationStatus,
    required this.token,
  });

  factory WorkerData.fromJson(Map<String, dynamic> json) {
    return WorkerData(
      id: json['data']['ID'],
      createdAt: DateTime.parse(json['data']['CreatedAt']),
      updatedAt: DateTime.parse(json['data']['UpdatedAt']),
      phoneNumber: json['data']['PhoneNumber'],
      name: json['data']['Name'],
      profileURL: json['data']['ProfileURL'],
      fcmToken: json['data']['FCMTocken'],
      email: json['data']['Email'],
      jobs: json['data']['Jobs'], // Replace 'dynamic' with the actual data type.
      workerCurrentLocation: WorkerCurrentLocation.fromJson(json['data']['WorkerCurrentLocation']),
      workerDetails: WorkerDetails.fromJson(json['data']['WorkerDetails']),
      workerVerificationStatus: WorkerVerificationStatus.fromJson(json['data']['WorkerVerificationStatus']),
      token: json['token'],
    );
  }
}

class WorkerCurrentLocation {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int workerID;
  final double latitude;
  final double longitude;
  final String locationName;

  WorkerCurrentLocation({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.workerID,
    required this.latitude,
    required this.longitude,
    required this.locationName,
  });

  factory WorkerCurrentLocation.fromJson(Map<String, dynamic> json) {
    return WorkerCurrentLocation(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      workerID: json['WorkerID'],
      latitude: json['Latitude'].toDouble(),
      longitude: json['Longitude'].toDouble(),
      locationName: json['LocationName'],
    );
  }
}

class WorkerDetails {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int workerID;
  final String aadharNumber;
  final String aadharFront;
  final String aadharBack;
  final String panNumber;
  final String panFront;
  final String panBack;
  final String gender;
  final String verificationImage;

  WorkerDetails({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.workerID,
    required this.aadharNumber,
    required this.aadharFront,
    required this.aadharBack,
    required this.panNumber,
    required this.panFront,
    required this.panBack,
    required this.gender,
    required this.verificationImage,
  });

  factory WorkerDetails.fromJson(Map<String, dynamic> json) {
    return WorkerDetails(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      workerID: json['WorkerID'],
      aadharNumber: json['AadharNumber'],
      aadharFront: json['AadharFront'],
      aadharBack: json['AadharBack'],
      panNumber: json['PanNumber'],
      panFront: json['PanFront'],
      panBack: json['PanBack'],
      gender: json['Gender'],
      verificationImage: json['VerificationImage'],
    );
  }
}

class WorkerVerificationStatus {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int workerID;
  final bool isAadharVerified;
  final bool isEmailIdVerified;
  final bool isImageVerified;
  final bool isPanVerified;
  final bool isVerified;

  WorkerVerificationStatus({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.workerID,
    required this.isAadharVerified,
    required this.isEmailIdVerified,
    required this.isImageVerified,
    required this.isPanVerified,
    required this.isVerified,
  });

  factory WorkerVerificationStatus.fromJson(Map<String, dynamic> json) {
    return WorkerVerificationStatus(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      workerID: json['WorkerID'],
      isAadharVerified: json['IsAadharVerified'],
      isEmailIdVerified: json['IsEmailIdVerified'],
      isImageVerified: json['IsImageVerified'],
      isPanVerified: json['IsPanVerified'],
      isVerified: json['IsVerified'],
    );
  }
}
