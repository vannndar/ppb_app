import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Quote {
  final String id;
  final String text;
  final String author;
  final DateTime createdAt;
  final DateTime editedAt;

  Quote({
    String? id,
    required this.text,
    required this.author,
    DateTime? createdAt,
    DateTime? editedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       editedAt = editedAt ?? DateTime.now() {
    if (text.isEmpty) throw ArgumentError('Quote text cannot be empty');
    if (author.isEmpty) throw ArgumentError('Author cannot be empty');
  }

  Quote copyWith({String? text, String? author, DateTime? editedAt}) {
    return Quote(
      id: id,
      text: text ?? this.text,
      author: author ?? this.author,
      createdAt: createdAt,
      editedAt: editedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
      'editedAt': editedAt.toIso8601String(),
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      text: map['text'],
      author: map['author'],
      createdAt: DateTime.parse(map['createdAt']),
      editedAt: DateTime.parse(map['editedAt']),
    );
  }

  String get formattedCreatedAt =>
      DateFormat('dd MMM yyyy - HH:mm').format(createdAt);
  String get formattedEditedAt =>
      DateFormat('dd MMM yyyy - HH:mm').format(editedAt);
}
