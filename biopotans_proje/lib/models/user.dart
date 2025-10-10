class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String birthDate; // ISO yyyy-MM-dd
  final String gender;
  final String? passwordHash; // client-side optional placeholder
  final bool verified;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    this.passwordHash,
    required this.verified,
    required this.createdAt,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? birthDate,
    String? gender,
    String? passwordHash,
    bool? verified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      passwordHash: passwordHash ?? this.passwordHash,
      verified: verified ?? this.verified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthDate: json['birth_date'] as String,
      gender: json['gender'] as String,
      passwordHash: json['password_hash'] as String?,
      verified: (json['verified'] as bool?) ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'birth_date': birthDate,
      'gender': gender,
      'password_hash': passwordHash,
      'verified': verified,
      'created_at': createdAt.toIso8601String(),
    };
  }
}



