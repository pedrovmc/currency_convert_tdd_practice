import 'package:currency_convert_tdd_practice/app/features/select_currencies/presenter/select_currencies_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/presenter/states/get_currencies_states.dart';
import 'package:flutter/material.dart';

class SelectCurrenciesPage extends StatefulWidget {
  final SelectCurrenciesController selectCurrenciesController;
  const SelectCurrenciesPage(
      {Key? key, required this.selectCurrenciesController})
      : super(key: key);

  @override
  State<SelectCurrenciesPage> createState() => _SelectCurrenciesPageState();
}

class _SelectCurrenciesPageState extends State<SelectCurrenciesPage> {
  @override
  void initState() {
    super.initState();
    widget.selectCurrenciesController.getSupportedCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Select the desired currencies to convert",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder(
            valueListenable: widget.selectCurrenciesController.state,
            builder: (context, state, child) {
              if (state is GetCurrenciesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetCurrenciesErrorState) {
                return Center(
                  child: Text(state.error.message ?? 'Error'),
                );
              } else if (state is GetCurrenciesSuccessState) {
                final currencies = state.currencies
                    .map((e) =>
                        DropdownMenuItem(value: e.code, child: Text(e.code)))
                    .toList();
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ValueListenableBuilder(
                        valueListenable:
                            widget.selectCurrenciesController.dropDown1Value,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              const Text("From:"),
                              Container(
                                color: Colors.white,
                                child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  focusColor: Colors.white,
                                  items: currencies,
                                  onChanged: (value) {
                                    widget
                                        .selectCurrenciesController
                                        .dropDown1Value
                                        .value = value.toString();
                                  },
                                  value: value,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable:
                            widget.selectCurrenciesController.dropDown2Value,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              const Text("To:"),
                              Container(
                                color: Colors.white,
                                child: DropdownButton(
                                  items: currencies,
                                  onChanged: (value) {
                                    widget
                                        .selectCurrenciesController
                                        .dropDown2Value
                                        .value = value.toString();
                                  },
                                  value: value,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Convert"))
        ],
      ),
    );
  }
}
