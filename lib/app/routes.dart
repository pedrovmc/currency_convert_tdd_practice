enum Routes {
  selectCurrencies(
    name: "select-currencies",
    path: "/",
  );

  final String name;
  final String path;

  const Routes({required this.name, required this.path});
}
