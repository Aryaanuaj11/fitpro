import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/calculator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double _bmi = 0;
  late double _targetCalorie = 0;
  bool _showCalc = false;

  @override
  void initState() {
    super.initState();
    _loadTarget();
  }

  Future<void> _loadTarget() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _targetCalorie = prefs.getDouble("target") ?? 0;
      _bmi = prefs.getDouble("bmi") ?? 0;
    });
  }

  void _onTapRecalc() {
    setState(() {
      _showCalc ? _showCalc = false : _showCalc = true;
    });
  }

  Future<void> _changeBmi(double bmi, double amr) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showCalc = false;
      _bmi = double.parse(bmi.toStringAsFixed(2));
      _targetCalorie = double.parse(amr.toStringAsFixed(0));

      prefs.setDouble("bmi", _bmi);
      prefs.setDouble("target", _targetCalorie);
    });
  }

  String categorizeBMI() {
    if (_bmi < 18.5) {
      return "Underweight";
    } else if (_bmi < 25) {
      return "Normal";
    } else if (_bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text("Your current BMI"),
                      Text(
                        _bmi.toString(),
                        style: const TextStyle(fontSize: 42),
                      ),
                      Text(
                        categorizeBMI(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Target Calories"),
                      Text(
                        _targetCalorie.toString(),
                        style: const TextStyle(fontSize: 42),
                      ),
                      const Text(
                        "kcal/day",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: _onTapRecalc,
                      child: const Text("Show calculator"))
                ],
              ),
            ),
          ),
          if (_showCalc) ...[Calculator(bmiCallback: _changeBmi)]
        ],
      ),
    );
  }
}
