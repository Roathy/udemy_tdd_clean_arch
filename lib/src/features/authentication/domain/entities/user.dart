import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String avatarUrl;
  final String createdAt;
  final int id;

  // final DateTime createdAt;

  const User({
    required this.name,
    required this.avatarUrl,
    required this.id,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id
      ];
}
