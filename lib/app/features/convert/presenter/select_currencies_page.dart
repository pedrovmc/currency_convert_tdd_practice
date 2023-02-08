import 'package:currency_convert_tdd_practice/app/features/convert/presenter/select_currencies_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/states/get_currencies_states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                            ValueListenableBuilder(
                              valueListenable:
                                  widget.selectCurrenciesController.state,
                              builder: (context, state, child) {
                                if (state is GetCurrenciesSuccessState) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "From:",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Container(
                                              color: Colors.grey.shade100,
                                              child: DropdownButton<String>(
                                                value: widget
                                                    .selectCurrenciesController
                                                    .dropDown1Value
                                                    .value,
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                onChanged: (String? newValue) {
                                                  widget
                                                      .selectCurrenciesController
                                                      .dropDown1Value
                                                      .value = newValue!;
                                                },
                                                items: state.currencies
                                                    .map(
                                                      (e) => DropdownMenuItem<
                                                          String>(
                                                        value: e.code,
                                                        child: Text(
                                                          e.code,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "TO:",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Container(
                                              color: Colors.grey.shade100,
                                              child: DropdownButton<String>(
                                                value: widget
                                                    .selectCurrenciesController
                                                    .dropDown1Value
                                                    .value,
                                                underline: const SizedBox(),
                                                isExpanded: true,
                                                onChanged: (String? newValue) {
                                                  widget
                                                      .selectCurrenciesController
                                                      .dropDown1Value
                                                      .value = newValue!;
                                                },
                                                items: state.currencies
                                                    .map(
                                                      (e) => DropdownMenuItem<
                                                          String>(
                                                        value: e.code,
                                                        child: Text(
                                                          e.code,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Text("Loading...");
                                }
                              },
                            ),
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
