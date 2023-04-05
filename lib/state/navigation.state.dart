import '../app/resumable_flow.dart';
import '../app/streamed_value.dart';
import '../src/home/home.flow.dart';

class NavigationState {
  static StreamedValue<ResumableFlow> state = StreamedValue<ResumableFlow>(
    initialValue: HomeFlow(),
  );
  static StreamedValue<List<ResumableFlow>> fowardStack =
      StreamedValue<List<ResumableFlow>>(initialValue: []);
  static StreamedValue<List<ResumableFlow>> backwardStack =
      StreamedValue<List<ResumableFlow>>(initialValue: []);
}
