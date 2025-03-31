class User {
  final String username;
  final String name;
  final String email;
  final String userType; // estudante, professor, administrador, etc.
  final String? profileImage;
  
  User({
    required this.username,
    required this.name,
    required this.email,
    required this.userType,
    this.profileImage,
  });
  
  // Transformar objeto JSON em objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      userType: json['userType'],
      profileImage: json['profileImage'],
    );
  }
  
  // Transformar objeto User em JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'userType': userType,
      'profileImage': profileImage,
    };
  }
}