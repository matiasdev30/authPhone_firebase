
import 'package:authphone_firebase/errors/faiure.dart';
import 'package:authphone_firebase/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

abstract class VerifySmsCode{
  Future<Either<Failure, void>> call(String smsCode, String verificationId);
}


class VerifyPhoneNumberToSignUsecase implements VerifySmsCode{

  IAuthRepository iAuthRepository;

  VerifyPhoneNumberToSignUsecase(this.iAuthRepository);

  @override
  Future<Either<Failure, void>> call(String smsCode, String verificationId) async {
    return await iAuthRepository.verifyPhoneNumberToSign(smsCode, verificationId);
  }

}