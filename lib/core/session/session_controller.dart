import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionController extends GetxController {
  SessionController(this._client);
  final SupabaseClient _client;

  final session = Rxn<Session>();
  bool get isLoggedIn => session.value != null;

  @override
  void onInit() {
    session.value = _client.auth.currentSession;

    _client.auth.onAuthStateChange.listen((data) {
      session.value = data.session;

      switch (data.event) {
        case AuthChangeEvent.signedIn:
          Get.offAllNamed('/communty');
          break;
        case AuthChangeEvent.signedOut:
          Get.offAllNamed('/start');
          break;
        default:
          break;
      }
    });

    super.onInit();
  }
}
