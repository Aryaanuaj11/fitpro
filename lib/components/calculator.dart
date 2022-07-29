import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  final Function(double, double) bmiCallback;

  const Calculator({Key? key, required this.bmiCallback}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _gender = 'male';
  String _activity = 'activity';
  String _targetWeight = 'target';

  void _calculateBmiAmr() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);
    int age = int.parse(_ageController.text);

    double bmi = weight / (height * height);
    double bmr;
    if (_gender == 'male') {
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    } else {
      bmr = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
    }
    double amr = 0;
    switch (_activity) {
      case 'sedentary':
        amr = bmr * 1.2;
        break;
      case 'light':
        amr = bmr * 1.375;
        break;
      case 'moderate':
        amr = bmr * 1.55;
        break;
      case 'active':
        amr = bmr * 1.725;
        break;
      case 'veryActive':
        amr = bmr * 1.9;
    }
    if (_targetWeight == 'gain') {
      amr = amr * 1.15;
    } else if (_targetWeight == 'loss') {
      amr = amr * .85;
    }
    widget.bmiCallback(bmi, amr);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        hintText: 'Age',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                      child: DropdownButtonFormField(
                    value: _gender,
                    items: const [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text("Female"),
                      ),
                    ],
                    onChanged: (dynamic item) {
                      setState(() {
                        _gender = item;
                      });
                    },
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        hintText: 'Height',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter height';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Text("cm"),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        hintText: 'Weight',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter weight';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Text("kg"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == "activity") {
                        return "Please select an activity level";
                      } else {
                        return null;
                      }
                    },
                    value: _activity,
                    hint: const Text("Activity Level"),
                    items: const [
                      DropdownMenuItem(
                        value: 'activity',
                        enabled: false,
                        child: Text("Activity Level"),
                      ),
                      DropdownMenuItem(
                        value: 'sedentary',
                        child: Text("Sedentary"),
                      ),
                      DropdownMenuItem(
                        value: 'light',
                        child: Text("Light 1-2 Days"),
                      ),
                      DropdownMenuItem(
                        value: 'moderate',
                        child: Text("Moderate 3-4 Days"),
                      ),
                      DropdownMenuItem(
                        value: 'active',
                        child: Text("Active 4-5 days"),
                      ),
                      DropdownMenuItem(
                        value: 'veryActive',
                        child: Text("Very Active"),
                      ),
                    ],
                    onChanged: (dynamic item) {
                      setState(() {
                        _activity = item;
                      });
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == "activity") {
                        return "Please select a weight target";
                      } else {
                        return null;
                      }
                    },
                    value: _targetWeight,
                    hint: const Text("Activity Level"),
                    items: const [
                      DropdownMenuItem(
                        value: 'target',
                        enabled: false,
                        child: Text("Weight Target"),
                      ),
                      DropdownMenuItem(
                        value: 'loss',
                        child: Text("Weight Loss"),
                      ),
                      DropdownMenuItem(
                        value: 'maintain',
                        child: Text("Maintain Weight"),
                      ),
                      DropdownMenuItem(
                        value: 'gain',
                        child: Text("Weight Gain"),
                      ),
                    ],
                    onChanged: (dynamic item) {
                      setState(() {
                        _targetWeight = item;
                      });
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculateBmiAmr();
                    }
                  },
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20))),
                  child: const Text("Recalculate"),
                ),
              ),
            ])),
      ),
    );
  }
}
