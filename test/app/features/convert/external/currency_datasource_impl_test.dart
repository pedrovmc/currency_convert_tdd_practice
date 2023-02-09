import 'package:currency_convert_tdd_practice/app/core/consts.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_exception.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_response.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/external/currency_datasource_impl.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_params_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/currency_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RestClientMock extends Mock implements RestClient {}

void main() {
  late CurrencyDatasourceImpl sut;
  late RestClient restClient;
  setUp(() {
    restClient = RestClientMock();
    sut = CurrencyDatasourceImpl(restClient: restClient);
  });

  group("Currency datasource", () {
    group("getCurrencies method", () {
      test("Should call rest client get method with the correct url", () async {
        //arrange
        when(() => restClient.get("$baseUrl/codes")).thenAnswer((_) async =>
            RestClientResponse(
                data: mockedGetCurrenciesResponse, statusCode: 200));
        //act
        await sut.getCurrencies();

        //assert
        verify(() => restClient.get("$baseUrl/codes")).called(1);
      });

      test("Should throw a restclient exception if request fails", () async {
        //arrange
        when(() => restClient.get("$baseUrl/codes"))
            .thenThrow(RestClientException(error: ""));

        //act
        final result = sut.getCurrencies();

        //assert
        expect(result, throwsA(isA<RestClientException>()));
      });
      test("Should return a list of currency model if request is successful",
          () async {
        //arrange
        when(() => restClient.get("$baseUrl/codes")).thenAnswer((_) async =>
            RestClientResponse(
                data: mockedGetCurrenciesResponse, statusCode: 200));

        //act
        final result = await sut.getCurrencies();

        //assert
        expect(result, isA<List<CurrencyModel>>());
        expect(result.first.code, "AED");
        expect(result.first.name, "UAE Dirham");
        expect(result.last.code, "BBD");
        expect(result.last.name, "Barbados Dollar");
      });
    });
  });

  group("convert method", () {
    test("Should call rest client get method with the correct url", () async {
      final fakerFrom = faker.randomGenerator.string(3, min: 3);
      final fakerTo = faker.randomGenerator.string(3, min: 3);
      final fakeAmount = faker.randomGenerator.decimal(scale: 10);

      final url = "$baseUrl/pair/$fakerFrom/$fakerTo/$fakeAmount";

      when(() => restClient.get(url)).thenAnswer((_) async =>
          RestClientResponse(data: mockedConversionResponse, statusCode: 200));

      await sut.convert(ConversionParamsModel(
          from: fakerFrom, to: fakerTo, amount: fakeAmount));

      verify(() => restClient.get(url)).called(1);
    });
  });

  test("When the request fails, should throw a restclient exception", () async {
    //arrange
    when(() => restClient.get(any())).thenThrow(RestClientException(error: ""));

    //act
    final result = sut.convert(ConversionParamsModel(
        from: faker.randomGenerator.string(3, min: 3),
        to: faker.randomGenerator.string(3, min: 3),
        amount: faker.randomGenerator.decimal(scale: 10)));

    //assert
    expect(result, throwsA(isA<RestClientException>()));
  });

  test("When restclient returns success, should return a ConversionEntity",
      () async {
    //arrange
    when(() => restClient.get(any())).thenAnswer((_) async =>
        RestClientResponse(data: mockedConversionResponse, statusCode: 200));

    //act
    final result = await sut.convert(ConversionParamsModel(
        from: faker.randomGenerator.string(3, min: 3),
        to: faker.randomGenerator.string(3, min: 3),
        amount: faker.randomGenerator.decimal(scale: 10)));

    //assert
    expect(result, ConversionModel(result: 5.8884, rate: 0.8412));
  });
}

final Map<String, dynamic> mockedConversionResponse = {
  "result": "success",
  "documentation": "https://www.exchangerate-api.com/docs",
  "terms_of_use": "https://www.exchangerate-api.com/terms",
  "time_last_update_unix": 1585267200,
  "time_last_update_utc": "Fri, 27 Mar 2020 00:00:00 +0000",
  "time_next_update_unix": 1585270800,
  "time_next_update_utc": "Sat, 28 Mar 2020 01:00:00 +0000",
  "base_code": "EUR",
  "target_code": "GBP",
  "conversion_rate": 0.8412,
  "conversion_result": 5.8884
};

final Map<String, dynamic> mockedGetCurrenciesResponse = {
  "result": "success",
  "documentation": "https://www.exchangerate-api.com/docs",
  "terms_of_use": "https://www.exchangerate-api.com/terms",
  "supported_codes": [
    ["AED", "UAE Dirham"],
    ["AFN", "Afghan Afghani"],
    ["ALL", "Albanian Lek"],
    ["AMD", "Armenian Dram"],
    ["ANG", "Netherlands Antillian Guilder"],
    ["AOA", "Angolan Kwanza"],
    ["ARS", "Argentine Peso"],
    ["AUD", "Australian Dollar"],
    ["AWG", "Aruban Florin"],
    ["AZN", "Azerbaijani Manat"],
    ["BAM", "Bosnia and Herzegovina Convertible Mark"],
    ["BBD", "Barbados Dollar"]
  ]
};
