import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/entity/currency_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/repositories/currency_repository.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/usecases/get_currencies_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/infra/models/currency_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CurrencyRepositoryMock extends Mock implements CurrencyRepository {}

void main() {
  late GetCurrenciesUseCase sut;
  late CurrencyRepository repository;

  setUp(() {
    repository = CurrencyRepositoryMock();
    sut = GetCurrenciesUsecaseImpl(repository: repository);
  });

  group("Get currencies usecase", () {
    test("Should call repository getCurrencies method", () async {
      // arrange
      when(() => repository.getCurrencies())
          .thenAnswer((_) async => const Right([]));

      // act
      await sut();

      // assert
      verify(() => repository.getCurrencies()).called(1);
    });

    test(
        "Shoud return a Left with a connection error if can't reach the server",
        () async {
      // arrange
      when(() => repository.getCurrencies()).thenAnswer(
          (_) async => Left(ConnectionFailure("Can't reach the server")));

      // act
      final result = await sut();
      final foldedResult = result.fold((l) => l, (r) => r);

      // assert
      expect(foldedResult, isA<ConnectionFailure>());
    });

    test(
        "Shoud return a Left with a empty currencies error if api returns empty list",
        () async {
      // arrange
      when(() => repository.getCurrencies()).thenAnswer(
          (_) async => Left(EmptyCurrenciesFailure("Empty currencies")));

      // act
      final result = await sut();
      final foldedResult = result.fold((l) => l, (r) => r);

      // assert
      expect(foldedResult, isA<EmptyCurrenciesFailure>());
    });

    test("Shoud return a Right with a list of currencies", () async {
      // arrange
      when(() => repository.getCurrencies()).thenAnswer((_) async =>
          Right([CurrencyModel(code: "USD", name: "United States Dollar")]));

      // act
      final result = await sut();
      final foldedResult = result.fold((l) => l, (r) => r);

      // assert
      expect(foldedResult, isA<List<CurrencyEntity>>());
    });
  });
}
