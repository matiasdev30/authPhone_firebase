import 'package:authphone_firebase/errors/faiure.dart';

class InvalidNumberLegthException extends Failure{
  const InvalidNumberLegthException(super.erroMsg);
  
  @override
  List<Object?> get props => [
    erroMsg,
  ];
}

class VerificationFailedException extends Failure{
  const VerificationFailedException(super.erroMsg);
  
  @override
  List<Object?> get props => [
    erroMsg,
  ];
}