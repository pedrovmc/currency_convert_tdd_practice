import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/entity/currency_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';

abstract class GetCurrenciesUseCase {
  Future<Either<Failure, List<CurrencyEntity>>> call();
}

class GetCurrenciesUsecaseImpl extends GetCurrenciesUseCase {
  final CurrencyRepository repository;

  GetCurrenciesUsecaseImpl({required this.repository});
  @override
  Future<Either<Failure, List<CurrencyEntity>>> call() async {
    final result = await repository.getCurrencies();
    return result;
  }
}
