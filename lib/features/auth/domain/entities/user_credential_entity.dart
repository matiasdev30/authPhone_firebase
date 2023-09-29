import 'package:equatable/equatable.dart';

class UserCredentialEntity extends Equatable {
  final String? name;
  final String? email;
  final String uuid;
  final String? phoneNumber;

  const UserCredentialEntity(
      {this.name,
      required this.email,
      required this.uuid,
      required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber, uuid];
}
