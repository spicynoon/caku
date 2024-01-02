final String tableUser = 'users';

class ModelUser {
  int userID;
  String userName;
  String email;
  String uuid;

  ModelUser(
      {required this.userID,
      required this.userName,
      required this.email,
      required this.uuid});

  ModelUser copy(
          {int? userID, String? userName, String? email, String? uuid}) =>
      ModelUser(
          userID: userID ?? this.userID,
          userName: userName ?? this.userName,
          email: email ?? this.email,
          uuid: uuid ?? this.uuid);

  static ModelUser fromJson(Map<String, Object?> json) => ModelUser(
      userID: json['_id'] as int,
      userName: json['userName'] as String,
      email: json['email'] as String,
      uuid: json['uuid'] as String);

  Map<String, Object?> toJson() => {
        UserFields.userID: userID,
        UserFields.userName: userName,
        UserFields.email: email,
        UserFields.uuid: uuid
      };
}

class UserFields {
  static final List<String> values = [userID, userName, email];

  static const String userID = '_id';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String uuid = 'uuid';
}
