import 'dart:convert';

import '../../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';

// Ya que esta clase extiende de la entidad User no es necesario declarar las propiedades en la clase
// basta con invocar el constructor con super
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar,
  });

  const UserModel.empty()
      : this(
          id: '1',
          name: '_empty.name',
          avatar: '_empty.avatar',
          createdAt: '_empty.createdAt',
        );

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
        );

  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'createdAt': createdAt
      };

  String toJson() => jsonEncode(toMap());
}
