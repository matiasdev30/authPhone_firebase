import '../../../features/auth/domain/entities/phone_number_entity.dart';
import '../models/user_credential_model.dart';

abstract class IAuthService{
  Future<String> signWithPhoneNumber(PhoneNumberEntity phoneNumberEntity);
  Future<UserCredentialModel> verifyPhoneNumberToSign(String smsCode,String verificationId);
  
}