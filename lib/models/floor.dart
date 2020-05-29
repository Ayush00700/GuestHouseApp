class Floor {
  String name = '';
  int basePrice = 0;
  List<bool> selectedDates = new List()..add(false);
  int finalPrice = 0;
  bool isSelected;
  Floor(
      {this.name,
      this.basePrice,
      this.finalPrice,
      this.selectedDates,
      this.isSelected = false});
}
