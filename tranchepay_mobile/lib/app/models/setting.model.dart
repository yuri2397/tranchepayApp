
class Setting{
  String? appName;
  String? appVersion;
  String? appDescription;
  String? appIcon;
  String? appLogo;
  String? appApiUrl;
  String? appEnv;

  Setting({
    this.appName,
    this.appVersion,
    this.appDescription,
    this.appIcon,
    this.appLogo,
    this.appApiUrl,
    this.appEnv,
  });

  Setting.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appVersion = json['app_version'];
    appDescription = json['app_description'];
    appIcon = json['app_icon'];
    appLogo = json['app_logo'];
    appApiUrl = json['app_api_url'];
    appEnv = json['app_env'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['app_version'] = appVersion;
    data['app_description'] = appDescription;
    data['app_icon'] = appIcon;
    data['app_logo'] = appLogo;
    data['app_api_url'] = appApiUrl;
    data['app_env'] = appEnv;
    return data;
  }
}