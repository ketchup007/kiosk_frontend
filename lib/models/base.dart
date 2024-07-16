abstract class Base<T> {
  const Base();

  String get id;
  DateTime get updatedAt;
  bool get synced;

  T copyWith({
    required bool? synced,
    required DateTime? updatedAt,
  });

  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}
