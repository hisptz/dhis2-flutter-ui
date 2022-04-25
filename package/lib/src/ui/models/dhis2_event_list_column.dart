class Dhis2EventListColumn {
  String? id;
  String? name;
  bool? isSelected;
  bool? isDefault;

  Dhis2EventListColumn({
    required this.id,
    required this.name,
    this.isSelected = false,
    this.isDefault = false,
  });

  @override
  String toString() {
    return '<$id $name $isSelected>';
  }
}
