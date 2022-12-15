import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'fullname')//para ajustar o nome
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? id;
  String? token;

  //Construtor
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
    this.id,
    this.token,
  });

  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  //transformando um map em um objeto
  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     cpf: map['cpf'],
  //     email: map['email'],
  //     id: map['id'],
  //     name: map['fullname'],
  //     password: map['password'],
  //     phone: map['phone'],
  //     token: map['token'],
  //   );
  // }

  //transformando um objeto em um map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'cpf': cpf,
  //     'email': email,
  //     'id': id,
  //     'fullname': name,
  //     'password': password,
  //     'phone': phone,
  //     'token': token,
  //   };
  // }

  @override
  String toString() {
    // TODO: implement toString
    return 'name: $name | cpf: $cpf';
  }
}
