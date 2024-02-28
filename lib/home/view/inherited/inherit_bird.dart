//
import '/src/controller.dart';

import '/src/view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritBird extends StatefulWidget {
  ///
  const InheritBird({
    super.key,
    required this.child,
  });

  ///
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _InheritBirdState();
}

class _InheritBirdState extends State<InheritBird>
    with InheritedWidgetStateMixin {
  //
  _InheritBirdState() {
    BirdController(this);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  @override
  Widget buildIn(context) => widget.child!;
}
