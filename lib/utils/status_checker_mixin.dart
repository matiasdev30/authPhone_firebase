

import 'package:authphone_firebase/interfaces/data_state_response.dart';

mixin StatusCheckerMixin{

  statusCheck({required Status status, required Function onComplete, required Function onError}){
    switch (status) {
      case Status.completed:
        return onComplete();
      case Status.error:
        return onError();
      default:
    }
  }

}