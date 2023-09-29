import 'dart:async';
import 'package:authphone_firebase/features/auth/domain/usecase/sign_with_phone_number_usecase.dart';
import 'package:authphone_firebase/utils/status_checker_mixin.dart';
import 'package:authphone_firebase/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../interfaces/result_service.dart';
import '../../../app/auto_injector.dart';
import '../../../features/auth/domain/entities/phone_number_entity.dart';
import '../../domain/usecase/verify_sms_code.dart';

class AuthPhoneViewModel extends BaseViewModel
    with StatusCheckerMixin, ResultService {
  late AnimationController animationController;
  late Animation textanimation;
  bool isSecondText = false;
  bool isRegister = false;
  bool isLogin = true;
  bool isLoading = false;
  final _navigationService = autoInjector<NavigationService>();
  final _dialogService = autoInjector<DialogService>();
  final signWithPhoneNumberUsecase =
      autoInjector.get<SignWithPhoneNumberUsecase>();
  final verifySmsCodeUsecase =
      autoInjector.get<VerifyPhoneNumberToSignUsecase>();
  String? verificationID;
  PhoneNumberEntity? phoneNumberEntity;
  final verifyPhoneNumberToSign =
      autoInjector<VerifyPhoneNumberToSignUsecase>();
  int currentIndex = 0;

  final PageController pageController = PageController(initialPage: 0);

  bool goBack() {
    return _navigationService.back();
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

  changeLoginButton() {
    if (pageController.hasClients) {
      pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      isSecondText = false;
      isRegister = !isRegister;
      isLogin = !isLogin;
      notifyListeners();
    }
  }

  Future resendCode() async {
    sign(phoneNumberEntity!.phoneNumber);
  }

  Future confirmCode(String smsCode) async {
    catchLog(message: "ru-comfirm-code $smsCode");

    if (verificationID == null) {
      _dialogService.showDialog(
          title: "Errro", description: "Codigo de verificação invalido ");
    } else {
      await verifyPhoneNumberToSign(smsCode, verificationID!)
          .then((value) => statusCheck(
              status: returnData(data: value).status,
              onComplete: () {
                _dialogService.showDialog(
                    title: "OK",
                    description:
                        "Sucesss: data : ${returnData(data: value).data}");
              },
              onError: () {
                _dialogService.showDialog(
                    title: "Error",
                    description: "${returnData(data: value).message}");
              }));
    }
  }

  sign(int phoneNumber) async {

    catchLog(message: 'run sign method in viewmodel 🪱', name: "run-sign");
    isLoading = true;
    notifyListeners();
    await signWithPhoneNumberUsecase(PhoneNumberEntity(phoneNumber: phoneNumber)).then((value) {
      isLoading = false;
      notifyListeners();
      statusCheck(
          status: returnData(data: value).status,
          onComplete: () {
            verificationID = returnData(data: value).data;
          },
          onError: () {
            _dialogService.showDialog(
                title: "Erro", description: returnData(data: value).message);
          });
      isLoading = false;
      notifyListeners();
    });
  }

  void nextPage() {
    if (pageController.hasClients) {
      if (verificationID != null) {
        if (!isRegister) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );

          currentIndex++;
        } else {
          pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          currentIndex = 2;
        }
        notifyListeners();
      }
    }
  }

  void previousPage() {
    if (pageController.hasClients) {
      if (!isRegister) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        currentIndex--;
      } else {
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        currentIndex = 0;
      }
      notifyListeners();
    }
  }
}
