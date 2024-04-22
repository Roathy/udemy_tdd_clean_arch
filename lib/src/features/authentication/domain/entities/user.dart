import 'package:equatable/equatable.dart';

// The entity holds the blueprint that will be passed on throu
// the different layers of the particular feature and from here
// we go to the repository

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
