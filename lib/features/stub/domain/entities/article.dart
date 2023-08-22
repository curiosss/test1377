// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Article {
  final int id;
  final String name;
  final String updateAt;
  final String title;
  final String description;
  Article({
    required this.id,
    required this.name,
    required this.updateAt,
    required this.title,
    required this.description,
  });

  Article copyWith({
    int? id,
    String? name,
    String? updateAt,
    String? title,
    String? description,
  }) {
    return Article(
      id: id ?? this.id,
      name: name ?? this.name,
      updateAt: updateAt ?? this.updateAt,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'updateAt': updateAt,
      'title': title,
      'description': description,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as int,
      name: map['name'] as String,
      updateAt: map['updateAt'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Article(id: $id, name: $name, updateAt: $updateAt, title: $title, description: $description)';
  }

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.updateAt == updateAt &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        updateAt.hashCode ^
        title.hashCode ^
        description.hashCode;
  }
}
