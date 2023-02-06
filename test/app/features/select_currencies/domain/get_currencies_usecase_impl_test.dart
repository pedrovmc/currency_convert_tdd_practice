import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/currency_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/get_currencies_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetCurrenciesUsecaseImpl extends GetCurrenciesUseCase {
  final CurrencyRepository repository;

  GetCurrenciesUsecaseImpl({required this.repository});
  @override
  Future<Either<Failure, List<CurrencyEntity>>> call() async {
    final result = await repository.getCurrencies();
    return result;
  }
}

abstract class CurrencyRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies();
}

class CurrencyRepositoryMock extends Mock implements CurrencyRepository {}

void main() {
  test("Should call repository getCurrencies method", () async {
    // arrange
    final repository = CurrencyRepositoryMock();
    when(() => repository.getCurrencies())
        .thenAnswer((_) async => const Right([]));
    final sut = GetCurrenciesUsecaseImpl(repository: repository);
    // act
    await sut();

    // assert
    verify(() => repository.getCurrencies()).called(1);
  });
}
