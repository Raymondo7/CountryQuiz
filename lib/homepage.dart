import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/gridModel.dart';
import 'package:quiz/vue_pays_cap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _category = [
    'Tout',
    'Afrique',
    'Amerique',
    'Asie',
    'Europe',
    'Oceanie'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appName,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontFamily: police, fontSize: 30),
        ),
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        centerTitle: true,
        elevation: 8.0,
        toolbarHeight: 75,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          itemCount: _category.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GridModel(
              image: 'assets/images/${_category[index]}.png',
              title: _category[index],
              color: Colors.blue,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MyAlertDialog(category: '${_category[index]}',);
                    });
              },
            );
          },
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({super.key, required this.category});
  final String category;

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  bool switchValue = false;
  bool isButtonEnabled = false;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 8.0,
      title: const Text(
        'Nombre à atteindre',
        style: TextStyle(
            fontFamily: police, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: whiteColor,
          ),
          onPressed: isButtonEnabled
              ? () {
            Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_,__,___) => VuePaysCap(categorie: widget.category, nbreTotal: int.parse(_controller.text),))
                );
                }
              : null, // Disable the button when not enabled
          child: const Text('Valider',
            style: TextStyle(
                fontFamily: police,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
        ),
      ],
      content: IntrinsicHeight(
        child: SizedBox(
          //height: 175,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: whiteColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_,__,___) => VuePaysCap(categorie: widget.category, nbreTotal: 10,))
                        );
                      },
                      child: const Text(
                        '10',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: police,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: whiteColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_,__,___) => VuePaysCap(categorie: widget.category, nbreTotal: 25,))
                        );
                      },
                      child: const Text(
                        '25',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: police,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        foregroundColor: whiteColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_,__,___) => VuePaysCap(categorie: widget.category, nbreTotal: 50,))
                        );
                      },
                      child: const Text(
                        '50',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: police,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  FlutterSwitch(
                    width: 60.0,
                    height: 30.0,
                    valueFontSize: 12.0,
                    toggleSize: 20.0,
                    value: switchValue,
                    borderRadius: 30.0,
                    padding: 4.0,
                    showOnOff: true,
                    activeText: 'ON',
                    inactiveText: 'OFF',
                    activeColor: Colors.green,
                    inactiveColor: Colors.red,
                    onToggle: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                    width: 10,
                  ),
                  const Text(
                    'Clavier',
                    style: TextStyle(
                        fontFamily: police,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              switchValue
                  ? Form(
                      child: TextFormField(
                      controller: _controller,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // Set the button state based on validation
                        setState(() {
                          isButtonEnabled = _validate(value);
                        });
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
                        _NumberRangeTextInputFormatter(min: 1, max: 255),
                      ],
                      decoration: InputDecoration(
                          hintText: 'De 1...255',
                          hintStyle: const TextStyle(
                              fontFamily: police,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                width: 1,
                                color: primaryColor,
                              ))),
                    ))
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }

  bool _validate(String value) {
    try {
      final int parsedValue = int.parse(value);
      return parsedValue >= 1 && parsedValue <= 255;
    } catch (e) {
      return false;
    }
  }
}

class _NumberRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  _NumberRangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    try {
      final int value = int.parse(newValue.text);
      if (value >= min && value <= max) {
        return newValue;
      }
    } catch (e) {
      // Handle the case when the input is not a valid integer
    }

    // Allow clearing the content even if it doesn't satisfy the validation
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Return the old value if the input is not within the specified range
    return oldValue;
  }
}
