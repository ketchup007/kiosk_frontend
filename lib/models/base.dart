abstract class Base<T> {
  const Base();

  String get id;
  DateTime get updatedAt;

  T copyWith({
    required DateTime? updatedAt,
  });

  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}
