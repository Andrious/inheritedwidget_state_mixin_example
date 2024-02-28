//
import '/src/controller.dart';

import '/src/view.dart';

///
class CatController extends InheritController {
  ///
  factory CatController([State? state]) => _this ??= CatController._(state);
  CatController._([State? state]) : super(state);
  static CatController? _this;
}
