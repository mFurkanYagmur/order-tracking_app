import '../data/firebase_client.dart';
import '../data/preferences_helper.dart';

class AuthRepository {

  AuthRepository._();

  static AuthRepository? _instance;

  static AuthRepository get instance {
    _instance ??= AuthRepository._();
    return _instance!;
  }




  final firebaseClient = FirebaseClient.instance;
  final preferencesHelper = PreferencesHelper.instance;

  Future<bool> login(String email, String password) async {
    try {
      await firebaseClient.login(email, password);
      await preferencesHelper.setEmail(email);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isLogged() async {
    try{
      return await preferencesHelper.getEmail() != null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try{
      await firebaseClient.signOut();
      await preferencesHelper.signOut();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
