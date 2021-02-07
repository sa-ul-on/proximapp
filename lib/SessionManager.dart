import 'package:shared_preferences/shared_preferences.dart';

import 'LoginData.dart';

class SessionManager {
  SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool isUserLogged() {
    return prefs.containsKey('sessUserId');
  }

  Future<LoginData> getLoggedUser() async {
    return LoginData(prefs.getInt('sessUserId'), prefs.getInt('sessCompanyId'),
        prefs.getString('sessEmail'), prefs.getStringList('sessRoles'));
  }

  void setLoggedUser(LoginData loginData) async {
    await prefs.setInt('sessUserId', loginData.userId);
    await prefs.setInt('sessCompanyId', loginData.companyId);
    await prefs.setString('sessEmail', loginData.email);
    await prefs.setStringList('sessRoles', loginData.roles);
  }

  void removeLoggedUser() async {
    await prefs.remove('sessUserId');
    await prefs.remove('sessCompanyId');
    await prefs.remove('sessEmail');
    await prefs.remove('sessRoles');
  }
}
