import 'package:authphone_firebase/app/app.router.router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/auto_injector.dart';
import 'features/auth/presenter/views/auth_screen_number_phone_validate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 
  //FirebaseDatabase.instance.setPersistenceEnabled(true);
  autoInjectorInit();

  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "MyFont",
        primarySwatch: Colors.blue,
       textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blue), // Cor do rótulo
          hintStyle: TextStyle(color: Colors.red),   // Cor do texto de dica
        ),
      ),
      home:  AuthScreenNumberPhoneValidate(),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    ); 
  }
}
