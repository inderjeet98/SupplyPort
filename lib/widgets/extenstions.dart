extension CapTitleExtension on String {
  // ignore: unnecessary_this
  // String get titleCase => this
  //     .split(" ")
  //     .map((str) => str[0].toUpperCase() + word.substring(1))
  //     .join(" ");

  // get word => null;
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
