import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/usecases/get_currencies_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/currency_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/select_currencies_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/states/get_currencies_states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:value_listenable_test/value_listenable_test.dart';

class GetCurrenciesUseCaseMock extends Mock implements GetCurrenciesUseCase {}

void main() {
  late GetCurrenciesUseCase usecase;
  late SelectCurrenciesController sut;
  setUp(() {
    usecase = GetCurrenciesUseCaseMock();
    sut = SelectCurrenciesController(usecase: usecase);
  });

  test("Should call usecase, load and success", () async {
    when(() => usecase.call())
        .thenAnswer((_) async => Right([CurrencyModel(code: "", name: "")]));
    expect(
        sut.state,
        emitValues([
          isA<GetCurrenciesLoadingState>(),
          isA<GetCurrenciesSuccessState>()
        ]));

    await sut.getSupportedCurrencies();
    verify(() => usecase.call()).called(1);
  });
  test("Should call usecase, load and error", () async {
    when(() => usecase.call())
        .thenAnswer((_) async => Left(EmptyCurrenciesFailure("")));
    expect(
        sut.state,
        emitValues([
          isA<GetCurrenciesLoadingState>(),
          isA<GetCurrenciesErrorState>()
        ]));

    await sut.getSupportedCurrencies();
    verify(() => usecase.call()).called(1);
  });
}
