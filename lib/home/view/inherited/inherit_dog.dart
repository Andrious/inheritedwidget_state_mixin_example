//
import '/src/controller.dart';

import '/src/view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritDog extends StatefulWidget {
  ///
  const InheritDog({Key? key, required this.child}) : super(key: key);

  ///
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _InheritDogState();
}

class _InheritDogState extends State<InheritDog>
    with InheritedWidgetStateMixin {
  //
  _InheritDogState() {
    DogController(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print(
          '>>>>>>>>>>>>>>>>>>>>>>>>>   $this.runtimeType didChangeDependencies() called.');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  @override
  Widget buildIn(context) => widget.child!;
}
