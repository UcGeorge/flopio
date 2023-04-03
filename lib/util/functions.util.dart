import 'dart:async';

class FunctionsUtil {
  static Future<List<T>> asyncAggregate<T>(
    List<FutureOr<T>> functions, {
    Function(String)? onError,
  }) async {
    List<Completer<T>> completers =
        functions.map((_) => Completer<T>()).toList();
    List<StreamSubscription<T>> subscriptions = [];

    for (int i = 0; i < functions.length; i++) {
      Future.value(functions[i])
          .then((T trips) {
            completers[i].complete(trips);
          })
          .onError((error, stackTrace) {
            completers[i].completeError(error ?? "", stackTrace);
          })
          .asStream()
          .listen((_) {})
          .onDone(() {
            subscriptions[i].cancel();
          });
    }

    return await (Future.wait(completers.map((c) => c.future))
      ..onError((error, stackTrace) => onError?.call(error?.toString() ?? "")));
  }
}
