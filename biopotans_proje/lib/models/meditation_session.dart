class MeditationSession {
  final String id;
  final String userId;
  final int duration; // minutes
  final DateTime completedAt;

  const MeditationSession({
    required this.id,
    required this.userId,
    required this.duration,
    required this.completedAt,
  });

  MeditationSession copyWith({
    String? id,
    String? userId,
    int? duration,
    DateTime? completedAt,
  }) {
    return MeditationSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      duration: duration ?? this.duration,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory MeditationSession.fromJson(Map<String, dynamic> json) {
    return MeditationSession(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      duration: json['duration'] as int,
      completedAt: DateTime.parse(json['completed_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'duration': duration,
      'completed_at': completedAt.toIso8601String(),
    };
  }
}



