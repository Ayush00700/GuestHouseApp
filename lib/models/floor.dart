class Floor {
  String name;
  int basePrice;
  List<bool> selectedDates;
  int finalPrice;
  bool isSelected;
  Floor(
      {this.name,
      this.basePrice,
      this.finalPrice,
      this.selectedDates,
      this.isSelected = false});
}
