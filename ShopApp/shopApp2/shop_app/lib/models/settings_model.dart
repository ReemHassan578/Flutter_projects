class SettingsModel {
  final bool status;
  final String? msg;
  final SettingsData data;
  SettingsModel.fromJson(Map<String, dynamic> settings)
      : status = settings['status'],
        msg = settings['message'],
        data = SettingsData.fromJson(settings['data']);
}

class SettingsData {
  final String about;
  final String terms;
  SettingsData.fromJson(Map<String, dynamic> data)
      : about = data['about'],
        terms = data['terms'];
}
