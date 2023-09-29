import 'package:authphone_firebase/errors/faiure.dart';
import 'package:authphone_firebase/features/auth/domain/entities/phone_number_entity.dart';
import 'package:dartz/dartz.dart';
import '../entities/user_credential_entity.dart';

abstract class IAuthRepository{
  Future<Either<Failure, String>> signWithPhoneNumber(PhoneNumberEntity phoneNumberEntity);
  Future<Either<Failure, UserCredentialEntity>> verifyPhoneNumberToSign(String smsCode, String verificationId);
}