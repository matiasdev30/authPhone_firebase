import 'package:authphone_firebase/features/auth/domain/entities/user_credential_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCredentialModel extends UserCredentialEntity {
  final String? displayName;
  final String? emailInModel;
  final bool emailVerified;
  final bool isAnonymous;
  final String? phoneNumberInModel;
  final String? photoURL;
  final String? refreshToken;
  final String? tenantId;
  final String uid;

  const UserCredentialModel(
      this.displayName,
      this.emailInModel,
      this.emailVerified,
      this.isAnonymous,
      this.phoneNumberInModel,
      this.photoURL,
      this.refreshToken,
      this.tenantId,
      this.uid)
      : super(
            email: emailInModel,
            name: displayName,
            phoneNumber: phoneNumberInModel,
            uuid: uid);

  static userFirebaseToUserModel(User user) {
    return UserCredentialModel(
        user.displayName,
        user.email,
        user.emailVerified,
        user.isAnonymous,
        user.phoneNumber,
        user.photoURL,
        user.refreshToken,
        user.tenantId,
        user.uid);
  }
}
