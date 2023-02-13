import 'package:currency_convert_tdd_practice/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/repositories/currency_repository.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/usecases/convert_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/usecases/get_currencies_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/external/currency_datasource_impl.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/datasources/currency_datasource.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/repositories/currency_repository_impl.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/select_currencies_controller.dart';
import 'package:get_it/get_it.dart';

import 'features/convert/presenter/convert_controller.dart';

class Injections {
  static void registerInjections() {
    GetIt.I.registerLazySingleton<RestClient>(() => DioRestClient());
    GetIt.I.registerLazySingleton<CurrencyDatasource>(
        () => CurrencyDatasourceImpl(restClient: GetIt.I.get()));
    GetIt.I.registerLazySingleton<CurrencyRepository>(
        () => CurrencyRepositoryImpl(currencyDatasource: GetIt.I.get()));
    GetIt.I.registerLazySingleton<GetCurrenciesUseCase>(
        () => GetCurrenciesUsecaseImpl(repository: GetIt.I.get()));
    GetIt.I.registerLazySingleton(
        () => SelectCurrenciesController(usecase: GetIt.I.get()));
    GetIt.I.registerLazySingleton<ConvertUsecase>(
        () => ConvertUsecaseImpl(currencyRepository: GetIt.I.get()));
    GetIt.I.registerLazySingleton<ConvertController>(() => ConvertController(
          convertUsecase: GetIt.I.get(),
        ));
  }
}
