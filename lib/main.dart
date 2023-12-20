import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/route_controller/routes.dart';
import 'package:guitar_songs/screens/screens.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBiZYH3jD52SsZinfQ2oTOq4JDLoIasAKw",
      authDomain: "wygs-app.firebaseapp.com",
      projectId: "wygs-app",
      storageBucket: "wygs-app.appspot.com",
      messagingSenderId: "166719206090",
      appId: "1:166719206090:web:8e843e866afbd13cd17a33",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ScreenTransitionProvider>(
            create: (context) => ScreenTransitionProvider(),
          ),
          ChangeNotifierProvider<ProgressCheckProvider>(
            create: (context) => ProgressCheckProvider(),
          ),
          ChangeNotifierProvider<CommunityCheckProvider>(
            create: (context) => CommunityCheckProvider(),
          ),
          ChangeNotifierProvider<GuestCheckProvider>(
            create: (context) => GuestCheckProvider(),
          ),
          ChangeNotifierProvider<BillingCheckProvider>(
            create: (context) => BillingCheckProvider(),
          ),
        ],
        child: const MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            home: SignInScreen()));
  }
}
