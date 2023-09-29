import 'package:stacked/stacked_annotations.dart';
import '../features/auth/presenter/code_pins_view/code_pin_view.dart';
import '../features/home/home_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CodePinsView)
  ]
)
class AppSetup{

}