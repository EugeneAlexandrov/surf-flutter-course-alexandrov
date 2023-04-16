class PlaceType {
  String title;
  String requestTitle;
  bool isActive;
  String iconName;

  PlaceType({
    required this.title,
    required this.requestTitle,
    required this.isActive,
    required this.iconName,
  });

  @override
  String toString() {
    return requestTitle;
  }
}
