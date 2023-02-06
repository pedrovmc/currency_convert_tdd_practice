import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/currency_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetCurrenciesUseCase {
  Future<Either<Failure, List<CurrencyEntity>>> call();
}
