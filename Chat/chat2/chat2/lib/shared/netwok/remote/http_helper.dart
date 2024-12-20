import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

import 'end_points.dart';

class HttpHelper {
  static http.Client? client;

  static Future<void> initClient(serviceAccountJson, scopes) async {
    client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
  }

  static Future<http.Response> post(
      Map<String, dynamic> body, String googleAccessToken) {
    return client!.post(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $googleAccessToken'
        },
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
        body: body);
  }
}
