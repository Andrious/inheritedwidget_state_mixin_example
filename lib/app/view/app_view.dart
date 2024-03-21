//
import '/src/view.dart';

void main() => runApp(const MyApp(key: Key('MyApp')));

// /// The original without the Mixin, FutureBuilderStateMixin
// class MyApp extends StatelessWidget {
//   ///
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) => const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: HomePage(),
//       );
// }

///
class MyApp extends StatefulWidget {
  ///
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with FutureBuilderStateMixin {
  @override
  Future<bool> initAsync() async {
    // Simply wait for 10 seconds at startup.
    /// In production, this is where databases are opened,
    /// Web Service logins attempted, etc.
    return Future<bool>.delayed(const Duration(seconds: 10), () {
      return true;
    });
  }

  @override
  Widget? onSplashScreen(context) => const SplashScreen();

  @override
  Widget buildF(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
}
