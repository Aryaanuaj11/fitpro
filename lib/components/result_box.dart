import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  final Map? results;
  const ResultBox({
    Key? key,
    required Map this.results,
  }) : super(key: key);

  List<Widget> nutrientToTexts(Map nutrients) {
    return [
      Text('Energy : ${nutrients["ENERC_KCAL"].toStringAsFixed(2)}'),
      Text('Protien : ${nutrients["PROCNT"].toStringAsFixed(2)}'),
      Text('Fat : ${nutrients["FAT"].toStringAsFixed(2)}'),
      Text('Carbs : ${nutrients["CHOCDF"].toStringAsFixed(2)}'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                      itemCount: results!["hints"].length > 5
                          ? 5
                          : results!["hints"].length,
                      itemBuilder: (BuildContext context, int index) {
                        dynamic result = results!["hints"][index];
                        return ListTile(
                          leading: const Icon(Icons.list),
                          title: Text(result["food"]["label"].toString()),
                          trailing: IconButton(
                              onPressed: () {}, icon: Icon(Icons.add)),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  nutrientToTexts(result["food"]["nutrients"])),
                        );
                      }),
                  if (results!["hints"].length == 0)
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("No results found"),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
