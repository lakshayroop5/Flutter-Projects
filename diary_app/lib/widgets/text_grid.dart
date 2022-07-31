import 'package:flutter/material.dart';
import 'package:jkl/widgets/text_grid_tile.dart';
import 'package:provider/provider.dart';
import '../providers/texts.dart';

class TextGrid extends StatelessWidget {
  const TextGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadedText = Provider.of<Texts>(context).textList;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedText.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedText[i],
        child: TextGridTile(loadedText[i]),
      ),
    );
  }
}
