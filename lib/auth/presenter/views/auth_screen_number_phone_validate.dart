import 'package:authphone_firebase/features/auth/presenter/code_pins_view/code_pin_view.dart';
import 'package:authphone_firebase/features/auth/presenter/views/auth_phone_view_model.dart';
import 'package:authphone_firebase/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../theme/custom_widget_utils.dart';

class AuthScreenNumberPhoneValidate extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneNumber = TextEditingController();

  AuthScreenNumberPhoneValidate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ViewModelBuilder.reactive(
        viewModelBuilder: () => AuthPhoneViewModel(),
        onViewModelReady: (viewModel) {},
        builder: (context, viewModel, child) => Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/backgroud.jpg"),
                  fit: BoxFit.cover)),
          width: screenWidth(context),
          height: screenHeigth(context),
          child: ListView(
            children: [
              viewModel.currentIndex != 0
                  ? SafeArea(
                      child: TextButton(
                          onPressed: () async {
                            viewModel.previousPage();
                          },
                          child: const Row(children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            Text(
                              "Voltar",
                              style: TextStyle(color: Colors.white),
                            )
                          ])),
                    )
                  : const SizedBox(
                      height: 40,
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 30,
                  top: 20,
                ),
                child: SizedBox(
                  width: screenWidth(context),
                  height: screenHeigth(context) - 200,
                  child: PageView(
                    controller: viewModel.pageController,
                    children: <Widget>[
                      Column(
                        children: [..._numberPhoneField(viewModel)],
                      ),
                      CodePinsView(
                        isPasswordReset: false,
                        verificationID: viewModel.verificationID,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth(context),
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const Spacer(),
                    neonButton(
                      onTap: () async {
                        
                        await viewModel.sign(int.parse(_phoneNumber.text));
                        viewModel.nextPage();
                        if (_formKey.currentState!.validate()) {}
                      },
                      widget: Center(
                        child: viewModel.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _numberPhoneField(AuthPhoneViewModel viewModel) {
    return [Text(
              "Garantido a tua sua\nsegurança\ncom\ntecnologias muito\neficientes.",
              style: generalFontConfig.copyWith(fontSize: 46),
              textAlign: TextAlign.start,
            ),
      const SizedBox(
        height: 40,
      ),
      Text("Insire o numero de telefone para continuar ",
          style: generalFontConfig.copyWith(
              fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        
        controller: _phoneNumber,
        validator: (value) {
          // Expressão regular para validar números de telefone angolanos.
          // Aceita números no formato: +2449XXXXXXXX ou 9XXXXXXXX (sem o prefixo +244).
          RegExp regex = RegExp(r'^(\+244)?[9]\d{8}$');

          if (value == null || value.isEmpty) {
            return 'Por favor, insira um número de telefone';
          }

          if (!regex.hasMatch(value)) {
            return 'Por favor, insira um número de telefone angolano válido.';
          }
          return null;
        },
        onSaved: (value) {
          _phoneNumber.text = value!;
        },
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          
          labelStyle: const TextStyle(color: Colors.white), 
            hintText: "Numero de telefone",
            hintStyle: generalFontConfig.copyWith(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
      ),
    ];
  }
}