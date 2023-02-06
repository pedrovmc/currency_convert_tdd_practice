import 'package:currency_convert_tdd_practice/app/features/select_currencies/infra/models/currency_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Currency Model", () {
    test("Should receive a list and return a currency model", () {
      //arrange
      final list = ["AED", "UAE Dirham"];
      //act
      final result = CurrencyModel.fromMap(list);
      //assert
      expect(result.code, "AED");
      expect(result.name, "UAE Dirham");
    });
  });
}
