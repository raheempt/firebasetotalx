// TODO Implement this library.
class UserModel {
  final String uid;
  final String username;
  final String age;

  UserModel({
    required this.uid,
    required this.username,
    required this.age,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
      age: data['age'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
       'age':age

    };
  }
}
