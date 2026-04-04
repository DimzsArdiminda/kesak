class ProfileModels {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profilePicture;


  ProfileModels({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePicture,
  });

  factory ProfileModels.fromJson(Map<String, dynamic> json  ){
    return ProfileModels(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePicture: json['profile_picture'],
    );
  }
}