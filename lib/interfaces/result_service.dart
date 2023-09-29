


import 'package:authphone_firebase/errors/faiure.dart';
import 'package:dartz/dartz.dart';

import 'data_state_response.dart';

mixin ResultService<T>{
  late Either<Failure, T> result;

  ApiResponse<T> returnData({required Either<Failure, T> data}){    
    result = data;
    return result.fold((l) => ApiResponse.error("$l"), (r) => ApiResponse.completed(r));
  }
}