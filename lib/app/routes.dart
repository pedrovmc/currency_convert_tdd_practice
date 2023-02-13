enum Routes {
  selectCurrencies(
    name: "select-currencies",
    path: "/",
  ),
  convert(name: "convert", path: "/convert");

  final String name;
  final String path;

  const Routes({required this.name, required this.path});
}
