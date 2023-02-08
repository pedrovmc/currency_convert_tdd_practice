import 'package:currency_convert_tdd_practice/app/features/convert/presenter/select_currencies_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/widgets/currencies_form_widget.dart';
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
    widget.selectCurrenciesController.getSupportedCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8663F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.currency_exchange_rounded,
                    color: Colors.white, size: 40),
                Text(
                  'Converter',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            const Text(
                              "Select the pair of currencies to start",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CurrenciesFormWidget(
                                selectCurrenciesController:
                                    widget.selectCurrenciesController),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xFFF50057),
                                      ),
                                    ),
                                    child: const Text(
                                      "GO TO CONVERT ->",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/icon_page_1.png",
                      height: 250,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
