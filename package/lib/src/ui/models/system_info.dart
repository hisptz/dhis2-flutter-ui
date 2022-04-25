class SystemInfo {
  String? contextPath;
  String? systemId;
  String? systemName;
  String? userAgent;
  String? calendar;
  String? dateFormat;
  String? lastAnalyticsTableSuccess;
  String? lastAnalyticsTableRuntime;
  String? version;
  String? revision;
  String? jasperReportsVersion;
  String? environmentVariable;
  String? fileStoreProvider;
  String? readOnlyMode;
  String? javaVersion;
  String? osName;
  String? osArchitecture;
  String? osVersion;
  String? memoryInfo;
  String? cpuCores;

  SystemInfo({
    this.contextPath,
    this.systemId,
    this.systemName,
    this.userAgent,
    this.calendar,
    this.dateFormat,
    this.lastAnalyticsTableSuccess,
    this.lastAnalyticsTableRuntime,
    this.version,
    this.revision,
    this.jasperReportsVersion,
    this.environmentVariable,
    this.fileStoreProvider,
    this.readOnlyMode,
    this.javaVersion,
    this.osName,
    this.osArchitecture,
    this.osVersion,
    this.memoryInfo,
    this.cpuCores,
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};

    data['contextPath'] = contextPath;
    data['systemId'] = systemId;
    data['systemName'] = systemName;
    data['userAgent'] = userAgent;
    data['calendar'] = calendar;
    data['dateFormat'] = dateFormat;
    data['lastAnalyticsTableSuccess'] = lastAnalyticsTableSuccess;
    data['lastAnalyticsTableRuntime'] = lastAnalyticsTableRuntime;
    data['version'] = version;
    data['revision'] = revision;
    data['jasperReportsVersion'] = jasperReportsVersion;
    data['environmentVariable'] = environmentVariable;
    data['fileStoreProvider'] = fileStoreProvider;
    data['readOnlyMode'] = readOnlyMode;
    data['javaVersion'] = javaVersion;
    data['osName'] = osName;
    data['osArchitecture'] = osArchitecture;
    data['osVersion'] = osVersion;
    data['memoryInfo'] = memoryInfo;
    data['cpuCores'] = cpuCores;

    return data;
  }

  SystemInfo.fromMap(Map<String, dynamic> map) {
    contextPath = map['contextPath'];
    systemId = map['systemId'];
    systemName = map['systemName'];
    userAgent = map['userAgent'];
    calendar = map['calendar'];
    dateFormat = map['dateFormat'];
    lastAnalyticsTableSuccess = map['lastAnalyticsTableSuccess'];
    lastAnalyticsTableRuntime = map['lastAnalyticsTableRuntime'];
    version = map['version'];
    revision = map['revision'];
    jasperReportsVersion = map['jasperReportsVersion'];
    environmentVariable = map['environmentVariable'];
    fileStoreProvider = map['fileStoreProvider'];
    readOnlyMode = map['readOnlyMode'];
    javaVersion = map['javaVersion'];
    osName = map['osName'];
    osArchitecture = map['osArchitecture'];
    osVersion = map['osVersion'];
    memoryInfo = map['memoryInfo'];
    cpuCores = map['cpuCores'];
  }

  factory SystemInfo.fromJson(dynamic json) {
    return SystemInfo(
      contextPath: json['contextPath'] ?? '',
      systemId: json['systemId'] ?? '',
      systemName: json['systemName'] ?? '',
      userAgent: json['userAgent'] ?? '',
      calendar: json['calendar'] ?? '',
      dateFormat: json['dateFormat'] ?? '',
      lastAnalyticsTableSuccess: json['lastAnalyticsTableSuccess'] ?? '',
      lastAnalyticsTableRuntime: json['lastAnalyticsTableRuntime'] ?? '',
      version: json['version'] ?? '',
      revision: json['revision'] ?? '',
      jasperReportsVersion: json['jasperReportsVersion'] ?? '',
      environmentVariable: json['environmentVariable'] ?? '',
      fileStoreProvider: json['fileStoreProvider'] ?? '',
      readOnlyMode: json['readOnlyMode'] ?? '',
      javaVersion: json['javaVersion'] ?? '',
      osName: json['osName'] ?? '',
      osArchitecture: json['osArchitecture'] ?? '',
      osVersion: json['osVersion'] ?? '',
      memoryInfo: json['memoryInfo'] ?? '',
      cpuCores: "${json['cpuCores'] ?? ''}",
    );
  }

  @override
  String toString() {
    return '<$systemId $systemName>';
  }
}
