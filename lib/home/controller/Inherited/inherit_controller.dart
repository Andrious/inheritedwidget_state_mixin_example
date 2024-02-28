// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.
//
//  The 'Animal' Controller to call the appropriate InheritedWidget.
//

import '/src/controller.dart';

import '/src/view.dart';

///
class InheritController extends Controller {
  ///
  InheritController([super.state]);

  ///
  bool dependOnInheritedWidget(BuildContext? context) {
    bool inherit;

    inherit = state is InheritedWidgetStateMixin && context != null;

    if (inherit) {
      inherit =
          (state as InheritedWidgetStateMixin).dependOnInheritedWidget(context);
    }
    return inherit;
  }

  /// Rebuild the InheritedWidget to also rebuild its dependencies.
  void newAnimals() => setState(() {});
}
