import 'package:dhis2_flutter_ui/src/ui/utils/app_util.dart';

class MetadataSyncItem {
  String? id;
  String? name;
  String? progressPercentage;
  bool? isDefault;
  bool? isCompleted;
  List<MetadataSyncItem>? subItems;

  MetadataSyncItem({
    this.id,
    required this.name,
    this.progressPercentage = '0',
    this.isCompleted = false,
    this.isDefault = false,
    this.subItems = const [],
  }) {
    id = id ?? AppUtil.getUid();
  }

  setProgressPercentage(String percentage) {
    progressPercentage = percentage;
  }

  setCompletenesStatus(bool status) {
    isCompleted = status;
  }

  @override
  String toString() {
    return '<$id $name>';
  }
}
