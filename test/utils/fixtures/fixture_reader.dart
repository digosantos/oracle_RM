import 'dart:io';

String fixture({required String name}) =>
    File('test/utils/fixtures/$name').readAsStringSync();
