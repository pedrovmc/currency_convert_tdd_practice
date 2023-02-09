import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ConversionModel sut;

  test("When converting with correct map, should return a conversion model",
      () {
    final conversionResult = faker.randomGenerator.decimal(scale: 10);
    final conversionRate = faker.randomGenerator.decimal(scale: 10);

    final map = {
      "conversion_result": conversionResult,
      "conversion_rate": conversionRate,
    };

    sut = ConversionModel.fromMap(map);

    expect(sut, isA<ConversionModel>());
    expect(sut.rate, conversionRate);
    expect(sut.result, conversionResult);
  });
}
