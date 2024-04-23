import 'package:equatable/equatable.dart';

// The entity holds the blueprint that will be passed on throu
// the different layers of the particular feature and from here
// we go to the repository

/// Represents a user entity in the authentication domain.
///
/// The `User` class holds the essential information about a user, including their name,
/// avatar URL, creation timestamp, and a unique identifier. This entity is used
/// throughout the different layers of the authentication feature, serving as the
/// blueprint for user data.
class User extends Equatable {
  /// Creates a new instance of the `User` class with the provided properties.
  const User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  const User.empty()
      : this(
          id: '1',
          name: '_empty.name',
          avatar: '_empty.avatar',
          createdAt: '_empty.createdAt',
        );

  final String id;
  final String name;
  final String avatar;
  final String createdAt;

  @override
  List<Object?> get props => [
        id,
        name,
        avatar,
        // createdAt,
      ];
}
