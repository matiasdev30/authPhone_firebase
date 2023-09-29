
import 'package:auto_injector/auto_injector.dart';
import 'package:authphone_firebase/features/auth/domain/repository/auth_repository.dart';
import 'package:authphone_firebase/features/auth/domain/usecase/sign_with_phone_number_usecase.dart';
import 'package:authphone_firebase/features/auth/domain/usecase/verify_sms_code.dart';
import 'package:authphone_firebase/features/auth/presenter/views/auth_phone_view_model.dart';
import 'package:stacked_services/stacked_services.dart';
import '../features/auth/data/datasource/auth_service.dart';
import '../features/auth/data/datasource/auth_service_implementation.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';

AutoInjector autoInjector = AutoInjector();

void autoInjectorInit(){

    autoInjector.addLazySingleton(SnackbarService.new);
  autoInjector.addLazySingleton(NavigationService.new);
  autoInjector.addLazySingleton(DialogService.new);

  //Register auth
  autoInjector.addSingleton(SignWithPhoneNumberUsecase.new);
  autoInjector.addSingleton(VerifyPhoneNumberToSignUsecase.new);
  autoInjector.add<IAuthRepository>(AuthRepositoryImpl.new);
  autoInjector.add<IAuthService>(AuthServiceImpl.new);

  autoInjector.addLazySingleton(AuthPhoneViewModel.new);


  autoInjector.commit();
}