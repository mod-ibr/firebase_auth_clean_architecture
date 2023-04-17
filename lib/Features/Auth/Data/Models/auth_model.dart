import '../../../../core/Utils/Constants/auth_constants.dart';
import '../../Domain/Entites/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel(
      {required String userName,
      required String email,
      String? password,
      String? phone})
      : super(
            email: email, userName: userName, password: password, phone: phone);

  factory AuthModel.fromJson(Map<String, dynamic> map) {
    return AuthModel(
      email: map[AuthConstants.kEmail],
      password: map[AuthConstants.kPassword],
      userName: map[AuthConstants.kUserName],
      phone: map[AuthConstants.kPhone],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AuthConstants.kEmail: email,
      AuthConstants.kUserName: userName,
      AuthConstants.kPassword: password,
      AuthConstants.kPhone: phone
    };
  }
}
