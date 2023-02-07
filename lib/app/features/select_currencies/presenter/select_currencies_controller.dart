import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/usecases/get_currencies_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/presenter/states/get_currencies_states.dart';
import 'package:flutter/material.dart';

class SelectCurrenciesController {
  final GetCurrenciesUseCase usecase;
  SelectCurrenciesController({required this.usecase});

  final dropDown1Value = ValueNotifier<String>('USD');
  final dropDown2Value = ValueNotifier<String>('USD');

  final state =
      ValueNotifier<GetCurrenciesState>(const GetCurrenciesInitialState());
  Future<void> getSupportedCurrencies() async {
    state.value = const GetCurrenciesLoadingState();
    final result = await usecase();
    result.fold(
      (l) => state.value = GetCurrenciesErrorState(l),
      (r) => state.value = GetCurrenciesSuccessState(r),
    );
  }
}
