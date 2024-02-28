//

import '/src/controller.dart';

import '/src/view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritFox extends StatefulWidget {
  ///
  const InheritFox({super.key, required this.child});

  ///
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _InheritFoxState();
}

class _InheritFoxState extends State<InheritFox>
    with InheritedWidgetStateMixin {
  //
  @override
  void initState() {
    super.initState();
    FoxController(this);
  }

  @override
  bool updateShouldNotify(oldWidget) => true;

  @override
  Widget buildIn(context) => widget.child!;
}
