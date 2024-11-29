class SettingsModel {
  final bool status;
  final SettingsData? data;
  final String? msg;
  SettingsModel.fromJson(Map<String, dynamic> settings)
      : status = settings['status'],
        msg = settings['message'],
        data = settings['data'] != null
            ? SettingsData.fromJson(settings['data'])
            : null;
}

class SettingsData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  SettingsData.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        phone = data['phone'],
        image = data['image'];
}
