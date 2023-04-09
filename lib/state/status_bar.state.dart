import 'package:flutter/material.dart';

import '../app/streamed_value.dart';

class StatusBarState {
  static StreamedValue<Map<String, Widget>> lItems =
      StreamedValue<Map<String, Widget>>(initialValue: {});

  static StreamedValue<Map<String, Widget>> rItems =
      StreamedValue<Map<String, Widget>>(initialValue: {});

  static void addrItem(String key, Widget value) =>
      rItems.update(rItems.value..putIfAbsent(key, () => value));

  static void removerItem(String key) =>
      rItems.update(rItems.value..remove(key));

  static void addlItem(String key, Widget value) =>
      lItems.update(lItems.value..putIfAbsent(key, () => value));

  static void removelItem(String key) =>
      lItems.update(lItems.value..remove(key));

  static void updatel(String key, Widget value) {
    lItems.update(lItems.value
      ..update(
        key,
        (_) => value,
        ifAbsent: () => value,
      ));
  }

  static void updater(String key, Widget value) {
    rItems.update(rItems.value
      ..update(
        key,
        (_) => value,
        ifAbsent: () => value,
      ));
  }

  static void clear() {
    lItems.update(lItems.value..clear());
    rItems.update(rItems.value..clear());
  }
}
