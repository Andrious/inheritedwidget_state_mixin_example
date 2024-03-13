//
import '/src/view.dart';

///
class HomePage extends StatefulWidget {
  ///
  const HomePage({super.key});

  @override
  State createState() => HomePageState();
}

///
class HomePageState extends State<HomePage> with InheritedWidgetStateMixin {
  ///
  @override
  void initState() {
    super.initState();
    counter = 0;
  }

  ///
  late int counter;

  @override
  Widget buildIn(BuildContext context) =>
      const FirstPage(title: 'InheritedWidget Demo');

  /// The InheritedWidgetStateMixin updateShouldNotify() function
  /// Place a breakpoint here and step through the code now to watch the magic.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
