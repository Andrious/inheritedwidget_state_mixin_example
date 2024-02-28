//
import '/src/controller.dart';

import '/src/view.dart';

///
class DogController extends InheritController {
  ///
  factory DogController([State? state]) => _this ??= DogController._(state);
  DogController._([State? state]) : super(state);
  static DogController? _this;
}
