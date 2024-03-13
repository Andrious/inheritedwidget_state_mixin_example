// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.
//
//  This widget works with the free Cat API.
//

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomCat extends StatefulWidget {
  ///
  const RandomCat({super.key});
  @override
  State<StatefulWidget> createState() => _RandomCatState();
}

class _RandomCatState extends ImageAPIState<RandomCat> {
  _RandomCatState()
      : super(
          // uri: Uri(
          //   scheme: 'https',
          //   host: 'aws.random.cat',
          //   path: 'meow',
          // ),
          uri: Uri(
            scheme: 'https',
            host: 'shibe.online',
            path: 'api/cats',
          ),
          message: 'file',
        ) {
    add(CatController());
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
          '>>>>>>>>>>>>>>>>>>>>>>>>>   _RandomCatState didChangeDependencies() called.');
    }
  }
}
