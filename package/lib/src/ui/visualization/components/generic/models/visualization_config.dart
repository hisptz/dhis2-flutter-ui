class VisualizationConfig {
  String? id;
  String? type;
  Map<String, dynamic>? chart;
  Map<String, dynamic>? reportTable;
  Map<String, dynamic>? pdf;
  Map<String, dynamic>? zip;
  Map<String, dynamic>? doc;

  VisualizationConfig(
      {required this.id,
      required this.type,
      this.chart = const {},
      this.reportTable = const {},
      this.pdf,
      this.zip,
      this.doc});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'chart': chart,
      'reportTable': reportTable,
      'pdf': pdf,
      'zip': zip,
      'doc': doc
    };
  }

  factory VisualizationConfig.fromJson(dynamic json) {
    return VisualizationConfig(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      chart: json['chart'] ?? const {},
      reportTable: json['reportTable'] ?? const {},
      pdf: json['pdf'],
      zip: json['zip'],
      doc: json['doc'],
    );
  }

  @override
  String toString() {
    return '<$id $type>';
  }
}
