import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../utils/utils.dart';
import '../../../features/auth/domain/entities/phone_number_entity.dart';
import '../../../features/auth/erros/auth_errors.dart';
import '../models/user_credential_model.dart';
import 'auth_service.dart';

class AuthServiceImpl implements IAuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  

  @override
  Future<String> signWithPhoneNumber(
      PhoneNumberEntity phoneNumberEntity) async {
    catchLog(message: 'run sign method in datasource🪱', name: "run-sign");

    Completer<String> verificationIdCompleter = Completer<String>();

    try {

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+244${phoneNumberEntity.phoneNumber}",
        verificationCompleted: (phoneAuthCredential) async {
          catchLog(message: 'login sucess', name: "auth-ok");
          _firebaseAuth.signInWithCredential(phoneAuthCredential);
          verificationIdCompleter.complete(phoneAuthCredential.smsCode);
        },
        verificationFailed: (error) {
          verificationIdCompleter.completeError(error);
        },
        codeSent: (verificationId, forceResendingToken) {
          verificationIdCompleter.complete(verificationId);
          catchLog(message: 'on code sent code :: $verificationId', name: "when-code-sent-in-auth");
        },
        codeAutoRetrievalTimeout: (verificationId) {
          catchLog(
              message: 'on code auto retiveal timeout code :: $verificationId',
              name: "when-aut-timeout");
        },
      );


    
    } on FirebaseAuthException catch (_) {
      rethrow;
    } on VerificationFailedException catch (_){
      rethrow;
    }catch (e) {
      rethrow;
    }

    return verificationIdCompleter.future;
  }
  
  @override
  Future<UserCredentialModel> verifyPhoneNumberToSign(String smsCode, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      final result = await _firebaseAuth.signInWithCredential(credential);
      return UserCredentialModel.userFirebaseToUserModel(result.user!);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyIfUserExist(String uuid) async {
    QuerySnapshot querySnapshot = await usersCollection.where('uuid', isEqualTo: uuid).get();
    return querySnapshot.docs.isNotEmpty;
  }
  
  
  
 
     
      
   
  
  
  
}
