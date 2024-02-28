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
}
