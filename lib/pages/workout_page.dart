import 'package:flutter/material.dart';
import 'package:fitpro/api_service.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  bool _filter = true;
  late List<DropdownMenuItem<dynamic>> _options = [];
  String _selected = "selected";

  late List<dynamic> results;
  bool _showResults = false;

  void _changeFilter(bool val) async {
    _options = [];
    List<dynamic> textOptions;
    if (val == true) {
      textOptions = ApiService.bodyPartList;
    } else {
      textOptions = ApiService.equipmentList;
    }
    List<DropdownMenuItem<dynamic>> tempOptions = [];
    for (var e in textOptions) {
      var newItem = DropdownMenuItem(
        value: (e),
        child: Text(e),
      );
      tempOptions.add(newItem);
    }
    _options = tempOptions;

    setState(() {
      _selected = textOptions[0];
      _filter = val;
    });
  }

  void search() async {
    if (_filter == true) {
      results = await ApiService().getByBodyParts(_selected);
    } else {
      results = await ApiService().getByEquipment(_selected);
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _showResults = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Card(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Search for workouts",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DropdownButtonFormField(
                              onChanged: ((dynamic value) {}),
                              items: [
                                const DropdownMenuItem(
                                  enabled: false,
                                  value: "selected",
                                  child: Text("Select"),
                                ),
                                ..._options
                              ],
                              validator: ((dynamic value) {
                                if (value == "selected") {
                                  return "Please select filter and target";
                                }
                                return null;
                              }),
                              value: _selected,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("By Equipment"),
                                Switch(
                                    value: _filter,
                                    onChanged: (bool val) {
                                      _changeFilter(val);
                                    }),
                                const Text("By Body Part"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      search();
                                    }
                                  },
                                  icon: const Icon(Icons.search),
                                  label: const Text("Search"),
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(20))),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                )),
          ),
          if (_showResults)
            Results(
              results: results,
            )
        ],
      ),
    );
  }
}

class Results extends StatelessWidget {
  final List<dynamic> results;
  const Results({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Results",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length > 4 ? 4 : results.length,
                      itemBuilder: (BuildContext build, int index) {
                        return Container(
                          child: Row(children: [
                            SizedBox(
                                height: 130,
                                width: 130,
                                child: Image.network(
                                  results[index]["gifUrl"],
                                  height: 120,
                                )),
                            Text(results[index]["name"].toString()),
                          ]),
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
