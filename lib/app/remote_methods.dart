import 'notifications_manager.dart';

class RemoteMethods {
  static Future receiveInvite(Map<String, dynamic>? args) async {
    //TODO: Implement Receive Invite
  }

  static void init() {
    NotificationsManager.registerRemoteMethod("receiveInvite", receiveInvite);
  }
}
