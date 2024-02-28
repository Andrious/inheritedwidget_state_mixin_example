//
import '/src/view.dart';

void main() => runApp(const MyApp(key: Key('MyApp')));

///
class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'InheritedWidget Demo'),
      );
}
