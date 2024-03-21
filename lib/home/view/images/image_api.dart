// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.
//
//  Manages the API request for specifically 'image' public API's
//

import '/src/controller.dart';

import '/src/view.dart';

///
class ImageAPIState<T extends StatefulWidget> extends State<T>
    with FutureBuilderStateMixin
    implements ImageUriAPI {
  ///
  ImageAPIState({
    required this.uri,
    this.message,
  }) {
    //
    _con = ImageAPIController(this);
  }

  /// Take in a Controller.
  void add(InheritController? controller) => this.controller ??= controller;

  ///
  InheritController? controller;

  ///
  @override
  final Uri? uri;

  ///
  @override
  final String? message;

  late ImageAPIController _con;

  /// IMPORTANT: Usually you want only the Future routine to run once
  /// and so you'd override the initAsync() function (like you would the initState() function)
  /// However, if you want the Future routine to run every time,
  /// override instead the runAsync() function.
  @override
  Future<bool> runAsync() => _con.initAsync();

  /// Comment the line above to find the Future then execute only once.
  @override
  Future<bool> initAsync() => _con.initAsync();

  /// Called after the FutureBuilder now in the build() function
  @override
  Widget buildF(BuildContext context) {
    controller?.dependOnInheritedWidget(context);
    return GestureDetector(
      onTap: () => setState(() {}), // Refresh just this image
      onDoubleTap: controller?.newAnimals, // Refresh three images
      child: Card(
        child: _con.image ?? const SizedBox(),
      ),
    );
  }

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  @override
  bool onAsyncError(FlutterErrorDetails details) => false;
}

///
abstract class ImageUriAPI {
  ///
  ImageUriAPI({required this.uri, required this.message});

  ///
  final Uri? uri;

  ///
  final String? message;
}
