// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
//  This widget works with the free Bird API.
//

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomBird extends StatefulWidget {
  ///
  const RandomBird({super.key});
  @override
  State<StatefulWidget> createState() => _RandomBirdState();
}

class _RandomBirdState extends ImageAPIState<RandomBird> {
  _RandomBirdState()
      : super(
          // uri: Uri(
          //   scheme: 'https',
          //   host: 'shibe.online',
          //   path: 'api/birds',
          // ),
          uri: Uri(
            scheme: 'https',
            host: 'api.sefinek.net',
            path: 'api/v2/random/animal/bird',
          ),
          message: 'message',
        ) {
    add(BirdController());
  }

  /// Overridden for your benefit.
  /// Place a breakpoint here and note when its called.
  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  /// Overridden for your benefit.
  /// Place a breakpoint here and note when its called.
  /// Right after the initState() function when first created and
  /// whenever its to rebuild due its possible dependency to an InheritedWidget
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print(
          '>>>>>>>>>>>>>>>>>>>>>>>>>   _RandomBirdState didChangeDependencies() called.');
    }
  }
}
