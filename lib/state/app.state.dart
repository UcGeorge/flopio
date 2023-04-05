import '../app/queue.dart';
import '../app/streamed_value.dart';
import '../data/models/app_data.dart';
import '../services/storage.service.dart';

class AppState {
  static StreamedValue<AppData> state = StreamedValue<AppData>(
    initialValue: AppData.empty(),
  );

  static Queue<AppData> updateQueue = Queue<AppData>();

  static Future<void> update(AppData Function(AppData data) onUpdate) async {
    state.update(onUpdate(state.value));
    updateQueue.enqueue(onUpdate(state.value));

    if (updateQueue.busy) return;

    updateQueue.reserve();
    AppData? queuedData = updateQueue.next;
    while (queuedData != null) {
      await StorageService.saveData(queuedData);
      queuedData = updateQueue.next;
    }
    updateQueue.release();
  }
}
