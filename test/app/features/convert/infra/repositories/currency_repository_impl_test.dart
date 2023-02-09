import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_exception.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/currency_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/datasources/currency_datasource.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/currency_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/repositories/currency_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CurrencyDatasourceMock extends Mock implements CurrencyDatasource {}

void main() {
  group("Currency repository", () {
    late CurrencyRepositoryImpl sut;
    late CurrencyDatasource currencyDatasource;

    setUp(() {
      currencyDatasource = CurrencyDatasourceMock();
      sut = CurrencyRepositoryImpl(currencyDatasource: currencyDatasource);
    });

    test("Should call getCurrencies from datasource", () {
      // arrange
      when(() => currencyDatasource.getCurrencies())
          .thenAnswer((_) async => [CurrencyModel(name: "Real", code: "BRL")]);
      // act
      sut.getCurrencies();
      // assert
      verify(() => currencyDatasource.getCurrencies()).called(1);
    });

    test(
        "Should return Left with a connection error if datasource throw a restclient exception",
        () async {
      // arrange
      when(() => currencyDatasource.getCurrencies())
          .thenThrow(RestClientException(error: ""));

      // act
      final result = await sut.getCurrencies();
      final foldedResult = result.fold((l) => l, (r) => r);

      // assert
      expect(foldedResult, isA<ConnectionFailure>());
    });

    test(
        "Should return a Left with a empty list error if datasource return empty list",
        () async {
      // arrange
      when(() => currencyDatasource.getCurrencies())
          .thenAnswer((_) async => []);
      // act
      final result = await sut.getCurrencies();
      final foldedResult = result.fold((l) => l, (r) => r);
      // assert
      expect(foldedResult, isA<EmptyCurrenciesFailure>());
    });

    test(
        "Should return a Right with a currency list if the datasource return a currency list",
        () async {
      // arrange
      when(() => currencyDatasource.getCurrencies())
          .thenAnswer((_) async => [CurrencyModel(name: "Real", code: "BRL")]);
      // act
      final result = await sut.getCurrencies();
      final foldedResult = result.fold((l) => l, (r) => r);
      // assert
      expect(foldedResult, isA<List<CurrencyEntity>>());
    });
  });
}
