import 'package:authphone_firebase/features/auth/domain/entities/phone_number_entity.dart';
import 'package:authphone_firebase/features/auth/domain/repository/auth_repository.dart';
import 'package:authphone_firebase/features/auth/erros/auth_errors.dart';
import 'package:authphone_firebase/utils/utils.dart';
import 'package:dartz/dartz.dart';
import '../../../../errors/faiure.dart';

abstract class ISignWithPhoneNumberUsecase{
  Future<Either<Failure, String>> call(PhoneNumberEntity phoneNumberEntity);
}

class SignWithPhoneNumberUsecase implements ISignWithPhoneNumberUsecase{

  IAuthRepository iAuthRepository;

  SignWithPhoneNumberUsecase(this.iAuthRepository);

  @override
  Future<Either<Failure, String>> call(PhoneNumberEntity phoneNumberEntity) async {

    catchLog(message: 'run sign method in usecase 🪱', name: "run-sign");

    if(phoneNumberEntity.phoneNumber.toString().length != 9){
      return const Left(VerificationFailedException("O numero deve conter 9 caracteres"));
    }
    
    return iAuthRepository.signWithPhoneNumber(phoneNumberEntity,);
  }

}