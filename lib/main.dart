import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/bottom_navigation_bar.dart';
import 'package:xafe/common_widgets/error.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/authentication/controllers/auth_controller.dart';
import 'package:xafe/features/splash/screens/splash_screen.dart';
import 'package:xafe/firebase_options.dart';
import 'package:xafe/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const SplashScreen();
              }
              return const CustomizedBottomNavigationBar();
            },
            error: (err, trace) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => const Loader()));
  }
}

class ConsumerStatelessWidget {}
