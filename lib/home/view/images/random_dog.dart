// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.
//
//  This widget works with the free Dog API.
//

import '/src/controller.dart';

import '/src/view.dart';

///
class RandomDog extends StatefulWidget {
  ///
  const RandomDog({super.key});
  @override
  State<StatefulWidget> createState() => _RandomDogState();
}

class _RandomDogState extends ImageAPIState<RandomDog> {
  _RandomDogState()
      : super(
          uri: Uri(
            scheme: 'https',
            host: 'dog.ceo',
            path: 'api/breeds/image/random/1',
          ),
          message: 'message',
        ) {
    add(DogController());
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
          '>>>>>>>>>>>>>>>>>>>>>>>>>   _RandomDogState didChangeDependencies() called.');
    }
  }
}
