import 'package:kiosk_flutter/models/base.dart';

class TranslationEntry extends Base<TranslationEntry> {
  @override
  final String id;
  final String contentId;
  final String translationLanguageId;
  final String translation;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const TranslationEntry({
    required this.id,
    required this.contentId,
    required this.translationLanguageId,
    required this.translation,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  TranslationEntry copyWith({
    String? id,
    String? contentId,
    String? translationLanguageId,
    String? translation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TranslationEntry(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      translationLanguageId: translationLanguageId ?? this.translationLanguageId,
      translation: translation ?? this.translation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TranslationEntry.fromJson(Map<String, dynamic> json) {
    return TranslationEntry(
      id: json['id'] as String,
      contentId: json['content_id'] as String,
      translationLanguageId: json['translation_language_id'] as String,
      translation: json['translation'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content_id': contentId,
      'translation_language_id': translationLanguageId,
      'translation': translation,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranslationEntry &&
        other.id == id &&
        other.contentId == contentId &&
        other.translationLanguageId == translationLanguageId &&
        other.translation == translation &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ contentId.hashCode ^ translationLanguageId.hashCode ^ translation.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
