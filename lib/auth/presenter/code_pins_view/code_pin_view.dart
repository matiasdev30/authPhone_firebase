import 'dart:io';
import 'package:authphone_firebase/utils/const.dart';
import 'package:flutter/services.dart';
import 'package:authphone_firebase/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/pins_text_field.dart';
import 'code_pin_viewModel.dart';

class CodePinsView extends StatelessWidget {
  const CodePinsView({
    Key? key,
    required this.isPasswordReset,
    required this.verificationID,
    // required this.user,
  }) : super(key: key);

  final bool? isPasswordReset;
  final String? verificationID;

  // final UserCredentialsEntity user;

  @override
  Widget build(BuildContext context) {
    var code = TextEditingController();
    var codeFocus = FocusNode();

     return ViewModelBuilder<CodePinsViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.startTimer(),
      builder: (context, viewModel, child) {
        
        Widget loadingIndicator = viewModel.isBusy
            ? Container(
                color: Colors.purple.withOpacity(0.6),
                width: screenWidth(context),
                child: Center(
                    child: Platform.isIOS
                        ? const CupertinoActivityIndicator(
                            radius: 10,
                            color: Colors.white,
                          )
                        : const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )),
              )
            : const SizedBox();
        return Column(
                children: [
                  Column(
                      children: [
                        
                        Container(
                          height: screenHeigth(context) * .7,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Uma\nsolução\nminimalista de\ntrasporte",
                                style: generalFontConfig.copyWith(fontSize: 46),
                                textAlign: TextAlign.start,
                              ),
                             
                              const SizedBox(
                                height: 40,
                              ),
                              const Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Introduz o codigo de verificação enviado para esse numero",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),),
                                    TextSpan(
                                        text: " +244922831485",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: activeColor)),
                                  ],
                                ),
                                //textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (viewModel.start == 0) ...[
                                    TextButton(
                                        onPressed: () {
                                          viewModel.resendCode();
                                        },
                                        child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.refresh,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "Reenviar ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ]))
                                  ],
                                  if (viewModel.start > 0) ...[
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text.rich(
                                        TextSpan(
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text: "Confirma o codigo em  ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                            TextSpan(
                                                text: viewModel.start < 10
                                                    ? "00:0${viewModel.start}"
                                                    : "00:${viewModel.start}",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: activeColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ],
                              ),
                              Center(
                                child: viewModel.isLoading ? const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white, 
                                    ),
                                  ),
                                ) : PinsTextField(
                                  controller: code,
                                  focus: codeFocus,
                                  formater: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onFieldSubmitted: (value) {
                                    viewModel.verifySmsCode(value);
                                  },
                                ),
                              ),
                             
                               Align(
                    alignment: FractionalOffset.center,
                    child: loadingIndicator,
                  ),
                            ],
                          ),
                        )
                      ],
                    ),
                
                 
                ],
              );
           },
      viewModelBuilder: () => CodePinsViewModel(verificationID),
    );
  }
}
