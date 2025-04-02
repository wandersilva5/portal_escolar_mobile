class User {
  final String id;
  final String username;
  final String name;
  final String email;
  final String userType; // student, teacher, admin, director, etc.
  final String? profileImage;
  final String institutionId;
  
  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.userType,
    required this.institutionId,
    this.profileImage,
  });
  
  // Transformar objeto JSON em objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      userType: json['userType'],
      institutionId: json['institutionId'],
      profileImage: json['profileImage'],
    );
  }
  
  // Transformar objeto User em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'userType': userType,
      'institutionId': institutionId,
      'profileImage': profileImage,
    };
  }
  
  // Verificar se é administrador
  bool get isAdmin => userType == 'admin';
  
  // Verificar se é professor
  bool get isTeacher => userType == 'teacher';
  
  // Verificar se é aluno
  bool get isStudent => userType == 'student';
  
  // Verificar se é diretor
  bool get isDirector => userType == 'director';

  // Verificar se é responsável/guardião
  bool get isGuardian => userType == 'guardian';
}