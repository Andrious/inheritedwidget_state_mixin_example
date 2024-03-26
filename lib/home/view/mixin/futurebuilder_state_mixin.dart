import 'package:flutter/cupertino.dart'
    show
        CupertinoActivityIndicator,
        CupertinoLocalizations,
        CupertinoUserInterfaceLevel,
        DefaultCupertinoLocalizations;

import 'package:flutter/foundation.dart'
    show
        ErrorDescription,
        FlutterError,
        FlutterErrorDetails,
        ValueKey,
        kDebugMode;

import 'package:flutter/material.dart';

import 'package:universal_platform/universal_platform.dart'
    show UniversalPlatform;

///
/// Supply a FutureBuilder to a State object.
///
mixin FutureBuilderStateMixin<T extends StatefulWidget> on State<T> {
  /// Implement this function instead of the build() function
  /// to utilize a built-in FutureBuilder Widget.
  Widget buildF(BuildContext context) => const SizedBox();

  /// Supply a 'splash screen' while the FutureBuilder is processing.
  Widget? onSplashScreen(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    // A little trick to determine if the user has overridden this function.
    _buildOverridden = false;
    // Don't run runAsync() function if _ranAsync is true.
    if (!_ranAsync || _future == null) {
      _future = runAsync();
    }
    return FutureBuilder<bool>(
      key: ValueKey<State>(this),
      future: _future,
      initialData: false,
      builder: _futureBuilder,
    );
  }

  /// A flag noting if the build() function was overridden or not.
  bool get buildOverridden => _buildOverridden;
  bool _buildOverridden = true;

  /// Clean up
  @override
  void dispose() {
    _future = null;
    super.dispose();
  }

  /// Don't call runAsync() and initAsync() ever again once this is true.
  bool _ranAsync = false;

  /// IMPORTANT
  /// The _future must be created first. If the _future is created at the same
  /// time as the FutureBuilder, then every time the FutureBuilder's parent is
  /// rebuilt, the asynchronous task will be performed again.
  Future<bool>? _future;

  /// Run the StateX object's initAsync() function
  /// Override this function to repeatedly run the asynchronous operation
  Future<bool> runAsync() {
    // Once true, initAsync() function is never run again
    // unless the runAsync() function is overridden.
    _ranAsync = true;
    return initAsync();
  }

  /// You're to override this function and initialize any asynchronous operations
  Future<bool> initAsync() async => true;

  /// Supply the AsyncSnapshot
  AsyncSnapshot<bool>? get snapshot => _snapshot;
  AsyncSnapshot<bool>? _snapshot;

  /// Returns the appropriate widget when the Future is completed.
  Widget _futureBuilder(BuildContext context, AsyncSnapshot<bool> snapshot) {
    //
    _snapshot = snapshot;

    Widget? widget;
    FlutterErrorDetails? errorDetails;

    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        //
        /// IMPORTANT: Must supply the State object's context: this.context
        widget = buildF(this.context);
        //
      } else if (snapshot.hasError) {
        //
        errorDetails = FlutterErrorDetails(
          exception: snapshot.error!,
          stack: snapshot.stackTrace,
          library: 'state_extended.dart',
          context: ErrorDescription('Error in _futureBuilder'),
        );

        // Possibly recover resources and close services before continuing to exit in error.
        onAsyncError(errorDetails);
        //
      } else {
        // Since commented out '// && snapshot.data!) {' this bit of code should never run.
        errorDetails = FlutterErrorDetails(
          exception: Exception('App failed to initialize'),
          library: 'state_extended.dart',
          context: ErrorDescription('Please, notify Admin.'),
        );
      }
    }

    // A Widget must be supplied.
    if (widget == null) {
      // Keep trying until there's an error.
      if (errorDetails == null) {
        //
        try {
          // Display the splash screen
          // IMPORTANT: Supply the State object's context: this.context
          widget = onSplashScreen(this.context);
        } catch (e) {
          // Throw in DebugMode.
          if (kDebugMode) {
            rethrow;
          } else {
            //
            errorDetails = FlutterErrorDetails(
              exception: e,
              stack: e is Error ? e.stackTrace : null,
              library: 'state_extended.dart',
              context: ErrorDescription('Error in Splash Screen'),
            );

            // Resets the count of errors to show a complete error message not an abbreviated one.
            FlutterError.resetErrorCount();

            // Log errors
            FlutterError.presentError(errorDetails);
          }
        }

        // Still no widget
        widget ??= UniversalPlatform.isIOS
            ? const Center(child: CupertinoActivityIndicator())
            : const Center(child: CircularProgressIndicator());

        // There was an error instead.
      } else {
        // Resets the count of errors to show a complete error message not an abbreviated one.
        FlutterError.resetErrorCount();

        // Log the error
        FlutterError.presentError(errorDetails);

        try {
          widget = ErrorWidget.builder(errorDetails);
        } catch (e) {
          // Must provide something. Blank then
          widget = const SizedBox();

          // Throw in DebugMode.
          if (kDebugMode) {
            rethrow;
          } else {
            //
            errorDetails = FlutterErrorDetails(
              exception: e,
              stack: e is Error ? e.stackTrace : null,
              library: 'state_extended.dart',
              context: ErrorDescription('Error in FutureBuilder error routine'),
            );

            // Resets the count of errors to show a complete error message not an abbreviated one.
            FlutterError.resetErrorCount();

            // Log errors
            FlutterError.presentError(errorDetails);
          }
        }
      }
      // Likely needs Localization
      widget = _localizeWidget(this.context, widget);
    }
    return widget;
  }

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding runAsync() or initAsync() routine.
  void onAsyncError(FlutterErrorDetails details) {}

  /// Is the CupertinoApp being used?
  bool get usingCupertino =>
      context.getElementForInheritedWidgetOfExactType<
          CupertinoUserInterfaceLevel>() !=
      null;

  /// Supply Localizations before displaying the widget
  Widget _localizeWidget(BuildContext context, Widget child) {
    Widget widget;
    Object? material, cupertino;
    material =
        Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    cupertino = Localizations.of<CupertinoLocalizations>(
        context, CupertinoLocalizations);
    if (material != null || cupertino != null) {
      widget = child;
    } else {
      widget = Localizations(
        locale: const Locale('en', 'US'),
        delegates: const <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        child: child,
      );
    }
    return widget;
  }
}
