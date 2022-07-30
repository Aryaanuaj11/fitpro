import 'package:flutter/material.dart';
import 'package:fitpro/api_service.dart';

import '../components/result_box.dart';

class DietPage extends StatefulWidget {
  const DietPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  late Map results = {};
  bool displayResult = false;
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void getResults() async {
    results = (await ApiService().getFoodEntry(_searchController.text));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          displayResult = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchBox(
                searchController: _searchController,
                formKey: _formKey,
                searchCallback: getResults),
            if (displayResult) SizedBox(child: ResultBox(results: results)),
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Daily Calorie",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Text("Total Calorie"),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final Function() searchCallback;

  const SearchBox(
      {Key? key,
      required TextEditingController searchController,
      required GlobalKey<FormState> formKey,
      required this.searchCallback})
      : _formKey = formKey,
        _searchController = searchController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Search for food items",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(hintText: 'Samosas'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a query';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    searchCallback();
                  }
                },
                icon: const Icon(Icons.search),
                label: const Text("Search"),
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
