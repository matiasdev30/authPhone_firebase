import 'package:equatable/equatable.dart';

class PhoneNumberEntity extends Equatable{
  final int phoneNumber;

  const PhoneNumberEntity({required this.phoneNumber});
  
  @override
  List<Object?> get props => [
    phoneNumber,
  ];
}