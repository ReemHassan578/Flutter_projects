import 'package:chat2/shared/netwok/remote/http_helper.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

import 'end_points.dart';

class FcmHelper {
  static getGoogleAccessToken() async {
    var serviceAccountJson = googleAccountJson;

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    await HttpHelper.initClient(serviceAccountJson, scopes);

    var cred = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        HttpHelper.client!);

    HttpHelper.client!.close();
    print(cred.accessToken.data);
    return cred.accessToken.data;
  }

  sendNotification(String deviceToken, String title, String body) async {
    try {
      String googleAccesToken = await getGoogleAccessToken();

      http.Response response = await HttpHelper.post({
        'message': {
          'token': deviceToken,
          'notification': {"title": title, "body": body},
          "data": {
            "route": "serviceScreen",
          }
        }
      }, googleAccesToken);
      if (response.statusCode == 200) {
        print('notification is sent Successfully');
      } else {
        print('notification is not sent');
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
