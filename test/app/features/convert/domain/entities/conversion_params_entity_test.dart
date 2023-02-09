import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

class TestableConversionParamsEntity extends ConversionParamsEntity {
  TestableConversionParamsEntity({
    required super.from,
    required super.to,
    required super.amount,
  });
}

void main() {
  late ConversionParamsEntity sut;

  test(
      "When from dont have 3 caracters length, should throw a InvalidCurrencyCodeException",
      () {
    sut = TestableConversionParamsEntity(from: "US", to: "BRL", amount: 1.0);
    expect(() => sut.validate(), throwsA(isA<InvalidCurrencyCodeException>()));
  });

  test(
      "When to dont have 3 caracters length, should throw a InvalidCurrencyCodeException",
      () {
    sut = TestableConversionParamsEntity(from: "USD", to: "BR", amount: 1.0);
    expect(() => sut.validate(), throwsA(isA<InvalidCurrencyCodeException>()));
  });

  test("When amount is 0, should throw a ZeroConversionAmountException", () {
    sut = TestableConversionParamsEntity(from: "USD", to: "BRL", amount: 0);
    expect(() => sut.validate(), throwsA(isA<ZeroConversionAmountException>()));
  });
}
