class Filter {
  int id;
  String title;
  bool isActive;
  String iconName;

  Filter(
      {required this.iconName,
      required this.id,
      required this.title,
      required this.isActive});
}
