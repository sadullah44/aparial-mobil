enum GoalStatus { pending, completed }

class GoalModel {
  final String id;
  final String userId;
  final String title;
  final DateTime? deadline;
  final GoalStatus status;
  final DateTime createdAt;

  const GoalModel({
    required this.id,
    required this.userId,
    required this.title,
    this.deadline,
    this.status = GoalStatus.pending,
    required this.createdAt,
  });

  GoalModel copyWith({
    String? id,
    String? userId,
    String? title,
    DateTime? deadline,
    GoalStatus? status,
    DateTime? createdAt,
  }) {
    return GoalModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      status: (json['status'] as String) == 'completed'
          ? GoalStatus.completed
          : GoalStatus.pending,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'deadline': deadline?.toIso8601String(),
      'status': status == GoalStatus.completed ? 'completed' : 'pending',
      'created_at': createdAt.toIso8601String(),
    };
  }
}



