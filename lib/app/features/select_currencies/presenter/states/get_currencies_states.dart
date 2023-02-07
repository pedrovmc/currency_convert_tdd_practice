import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/entity/currency_entity.dart';

abstract class GetCurrenciesState {}

class GetCurrenciesInitialState implements GetCurrenciesState {
  const GetCurrenciesInitialState();
}

class GetCurrenciesLoadingState implements GetCurrenciesState {
  const GetCurrenciesLoadingState();
}

class GetCurrenciesErrorState implements GetCurrenciesState {
  final Failure error;
  GetCurrenciesErrorState(this.error);
}

class GetCurrenciesSuccessState implements GetCurrenciesState {
  final List<CurrencyEntity> currencies;
  GetCurrenciesSuccessState(this.currencies);
}
