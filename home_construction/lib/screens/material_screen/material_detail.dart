import 'package:flutter/material.dart';
import 'package:home_construction/models/material.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/material_screen/add_record.dart';
import 'package:home_construction/widgets/material_screen/record_tile.dart';
import 'package:provider/provider.dart';

class MaterialDetail extends StatefulWidget {
  static const routeName = '/material-detail';

  const MaterialDetail({super.key});

  @override
  State<MaterialDetail> createState() => MaterialDetailState();
}

class MaterialDetailState extends State<MaterialDetail> {
  late MaterialItem material;
  late String project;

  @override
  void didChangeDependencies() {
    var temp = ModalRoute.of(context)!.settings.arguments as List;
    material = temp[0] as MaterialItem;
    project = temp[1] as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Record> list = material.records;
    return Scaffold(
      appBar: AppBar(
        title: Text(material.name),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Text(
                          'Total Amount:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<Projects>(
                          builder: (context, value, child) => Text(
                            '\u{20B9}${material.total.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Text(
                          'Total Quantity:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<Projects>(
                          builder: (context, value, child) => Text(
                            material.quantity.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Transactions: ${material.records.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Consumer<Projects>(
                builder: (_, projects, child) => Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, i) =>
                        RecordTile(list[i], material.id, project),
                    itemCount: list.length,
                    shrinkWrap: true,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            right: 40,
            child: SizedBox(
              height: 65,
              width: 65,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AddRecord.routeName,
                    arguments: [
                      Record(
                        id: '',
                        quantity: 0,
                        pricePerUnit: 0,
                        date: DateTime.now(),
                      ),
                      material.id,
                      project,
                    ],
                  ).then((value) => setState(() {}));
                },
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
