import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userName;
  final String email;
  final String? password;
  final String? phone;

  const AuthEntity(
      {this.userName, required this.email, this.password, this.phone});

  @override
  List<Object?> get props => [userName, email, password, phone];
}
