import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String erroMsg;

  const Failure(this.erroMsg);

  @override
  String toString() {
    return erroMsg;
  }
}

class FetchDataException extends Failure{
  const FetchDataException(super.erroMsg);

  @override
  List<Object?> get props => [
    erroMsg,
  ];
  
}