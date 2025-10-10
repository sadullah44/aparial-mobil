class TestResult {
  final String id;
  final String userId;
  final int score;
  final String recommendation;
  final DateTime createdAt;

  const TestResult({
    required this.id,
    required this.userId,
    required this.score,
    required this.recommendation,
    required this.createdAt,
  });

  TestResult copyWith({
    String? id,
    String? userId,
    int? score,
    String? recommendation,
    DateTime? createdAt,
  }) {
    return TestResult(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      score: score ?? this.score,
      recommendation: recommendation ?? this.recommendation,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      score: json['score'] as int,
      recommendation: json['recommendation'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'score': score,
      'recommendation': recommendation,
      'created_at': createdAt.toIso8601String(),
    };
  }
}



