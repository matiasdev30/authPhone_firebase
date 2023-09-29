import 'package:authphone_firebase/errors/faiure.dart';
import 'package:authphone_firebase/features/auth/domain/entities/phone_number_entity.dart';
import 'package:authphone_firebase/features/auth/domain/entities/user_credential_entity.dart';
import 'package:authphone_firebase/features/auth/domain/repository/auth_repository.dart';
import 'package:authphone_firebase/features/auth/erros/auth_errors.dart';
import 'package:authphone_firebase/interfaces/data_state_response.dart';
import 'package:authphone_firebase/utils/utils.dart';
import 'package:dartz/dartz.dart';
import '../datasource/auth_service.dart';

class AuthRepositoryImpl implements IAuthRepository {
  IAuthService iAuthService;

  ApiResponse apiResponse = ApiResponse.loading("loading....");

  AuthRepositoryImpl(this.iAuthService);

  @override
  Future<Either<Failure, String>> signWithPhoneNumber(
      PhoneNumberEntity phoneNumberEntity) async {
    catchLog(message: 'run sign method in repository 🪱', name: "run-sign");

    try {
      final result = await iAuthService.signWithPhoneNumber(phoneNumberEntity);
      return Right(result);
    } catch (e) {
      return Left(VerificationFailedException("$e"));
    }
  }

  @override
  Future<Either<Failure, UserCredentialEntity>> verifyPhoneNumberToSign(
      String smsCode, String verificationId) async {
    try {
      final result =
          await iAuthService.verifyPhoneNumberToSign(smsCode, verificationId);
          UserCredentialEntity userCredentialEntity = result;
      return Right(userCredentialEntity);
    } catch (e) {
      return Left(VerificationFailedException("$e"));
    }
  }
}
