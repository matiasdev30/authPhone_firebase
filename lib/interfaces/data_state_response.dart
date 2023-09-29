import 'package:equatable/equatable.dart';

enum Status { loading, completed, error }
// ignore: must_be_immutable
class ApiResponse<T> extends Equatable {
  
  ApiResponse.loading(this.message) : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;

  final Status status;
  T? data;
  String? message;
  
 

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  @override
  
  List<Object?> get props => [];

 
}
