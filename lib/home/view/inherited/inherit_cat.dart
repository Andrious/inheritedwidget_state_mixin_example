//

import '/src/controller.dart';

import '/src/view.dart';

/// This StatefulWidget stores an InheritedWidget
class InheritCat extends StatefulWidget {
  ///
  const InheritCat({Key? key, required this.child}) : super(key: key);

  ///
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _InheritCatState();
}

class _InheritCatState extends State<InheritCat>
    with InheritedWidgetStateMixin {
  //
  @override
  void initState() {
    super.initState();
    CatController(this);
  }

  @override
  bool updateShouldNotify(oldWidget) => true;

  @override
  Widget buildIn(context) => widget.child!;
}
