import 'dart:async';
import 'package:authphone_firebase/features/auth/presenter/views/auth_phone_view_model.dart';
import 'package:authphone_firebase/utils/status_checker_mixin.dart';
import 'package:authphone_firebase/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/auto_injector.dart';
import '../../../../interfaces/result_service.dart';
import '../../domain/usecase/verify_sms_code.dart';

class CodePinsViewModel extends BaseViewModel
    with ResultService, StatusCheckerMixin {
  final _navigationService = autoInjector<NavigationService>();
  final verifySmsCodeUsecase =
      autoInjector<VerifyPhoneNumberToSignUsecase>();
  final _dialogService = autoInjector<DialogService>();
  final _authPhoneViewModel = autoInjector<AuthPhoneViewModel>();
  bool isLoading = false;

  final verifyPhoneNumberToSign =
      autoInjector<VerifyPhoneNumberToSignUsecase>();

  CodePinsViewModel(this.verificationID);
  bool goBack() {
    return _navigationService.back();
  }
  final String? verificationID;

  verifySmsCode(String code) async {
    isLoading = true;
    catchLog(message: 'run sign method in viewmodel 🪱', name: "run-sign");
    notifyListeners();
    await verifySmsCodeUsecase(code, verificationID!).then((value) {
      notifyListeners();
      statusCheck(
          status: returnData(data: value).status,
          onComplete: () {
             _dialogService.showDialog(
                title: "Sucess ✔️", description: returnData(data: value).data.toString());
          },
          onError: () {
            _dialogService.showDialog(
                title: "Erro ❌", description: returnData(data: value).message);
          });
      

    });
    isLoading = false;
      notifyListeners();
  }

  late Timer timer;
  late int _start;
  int get start => _start;

  void startTimer() {
    _start = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          notifyListeners();
        } else {
          _start--;
          notifyListeners();
        }
      },
    );
  }

  Future resendCode() async {
    _authPhoneViewModel.sign(_authPhoneViewModel.phoneNumberEntity!.phoneNumber);
  }


}


