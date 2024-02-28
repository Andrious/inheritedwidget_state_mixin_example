//
//  Any State object 'with' this mixin has then a built-in InheritedWidget
//
//

import 'package:flutter/material.dart';

/// Supplies an InheritedWidget to a State class
///
mixin InheritedWidgetStateMixin<T extends StatefulWidget> on State<T> {
  ///
  /// Don't override the State's build() function.
  /// Override this function to supply the interface instead.
  Widget buildIn(BuildContext context) => const SizedBox();

  /// Determine if the dependencies should be updated.
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  @override
  void initState() {
    super.initState();
    _key = ValueKey<State>(this);
  }

  /// This replaces the State class build() function
  /// Unless, of course, the developer has explicitly overridden the function
  @override
  Widget build(BuildContext context) {
    _overrideBuild = false;
    return _StateXInheritedWidget(
      key: _key,
      state: this,
      child: _child ??= buildIn(context),
    );
  }

  // Indicate the developer has instead overridden the build() function
  bool get overrideBuild => _overrideBuild;
  bool _overrideBuild = true;

  // Supply an identifier to the InheritedWidget
  Key? _key;

  // Widget passed to the InheritedWidget.
  Widget? _child;

  // Collect any 'widgets' depending on this State's InheritedWidget.
  final Set<BuildContext> _dependencies = {};

  /// The InheritedWidget's element object assigning Widget dependencies
  InheritedElement? _inheritedElement;

  ///
  ///  Set the specified widget (through its context) as a dependent of the InheritedWidget
  ///
  ///  Return false if not configured to use the InheritedWidget
  bool dependOnInheritedWidget(BuildContext? context) {
    final depend = context != null && !_overrideBuild;
    if (depend) {
      if (_inheritedElement == null) {
        _dependencies.add(context);
      } else {
        context.dependOnInheritedElement(_inheritedElement!);
      }
    }
    return depend;
  }

  /// In harmony with Flutter's own API there's also a notifyClients() function
  /// Rebuild the InheritedWidget of the 'closes' InheritedStateX object if any.
  void notifyClients() => setState(() {});

  /// When the State's InheritedWidget is called again,
  /// this 'widget function' will be called again.
  Widget stateSet(WidgetBuilder? widgetFunc) {
    widgetFunc ??= (_) => const SizedBox();
    return _DependencyWidget(state: this, widgetFunc: widgetFunc);
  }

  @override
  void dispose() {
    _key = null;
    _child = null;
    _inheritedElement = null;
    _dependencies.clear();
    super.dispose();
  }
}

/// The built-in InheritedWidget
class _StateXInheritedWidget extends InheritedWidget {
  const _StateXInheritedWidget({
    super.key,
    required this.state,
    required super.child,
  });

  final InheritedWidgetStateMixin state;

  @override
  InheritedElement createElement() {
    //
    final element = InheritedElement(this);
    state._inheritedElement = element;
    // Associate any dependencies widgets to this InheritedWidget
    // toList(growable: false) prevent concurrent error
    for (final context in state._dependencies.toList(growable: false)) {
      context.dependOnInheritedElement(element);
      state._dependencies.remove(context);
    }
    return element;
  }

  /// Use the StateX's updateShouldNotify() function
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      state.updateShouldNotify(oldWidget);
}

/// Called by the stateSet()
/// Supply a widget to depend upon the built-in InheritedWidget
class _DependencyWidget extends StatelessWidget {
  const _DependencyWidget({
    required this.state,
    required this.widgetFunc,
  });
  final InheritedWidgetStateMixin state;
  final WidgetBuilder widgetFunc;
  @override
  Widget build(BuildContext context) {
    state.dependOnInheritedWidget(context);
    return widgetFunc(context);
  }
}
