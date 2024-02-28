//

import '/src/controller.dart';

import '/src/view.dart';

/// This SOC is associated with the Bird images and works with
/// InheritBird StatefulWidget and the InheritedWidget, _BirdInherited
class BirdController extends InheritController {
  ///
  factory BirdController([State? state]) => _this ??= BirdController._(state);
  BirdController._([State? state]) : super(state);
  static BirdController? _this;
}
