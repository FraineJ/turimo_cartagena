class LoginResponse {
  final String tokenType;
  final String tokenAcces;
  final String name;
  final bool ok;

  LoginResponse({
    required this.tokenType,
    required this.tokenAcces,
    required this.name,
    required this.ok,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      tokenType: json['tokenType'],
      tokenAcces: json['tokenAcces'],
      name: json['name'],
      ok: json['ok'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenType': tokenType,
      'tokenAcces': tokenAcces,
      'name': name,
      'ok': ok,
    };
  }
}

class UserDTO {
  final int id;
  final String name;
  final String email;
  final String username;
  final String? pictureUser;
  final List<String> roles;
  final List<String> favoritos;

  UserDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.pictureUser,
    required this.roles,
    required this.favoritos,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      pictureUser: json['pictureUser'],
      roles: List<String>.from(json['roles'] ?? []),
      favoritos: List<String>.from(json['favoritos'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'pictureUser': pictureUser,
      'roles': roles,
      'favoritos': favoritos,
    };
  }
}
