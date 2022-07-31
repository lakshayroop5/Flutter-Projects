import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jkl/providers/texts.dart';
import 'package:jkl/screens/text_upload_screen.dart';
import 'package:provider/provider.dart';
import '../providers/text.dart' as txt;

class TextGridTile extends StatelessWidget {
  final txt.Text text;
  // ignore: use_key_in_widget_constructors
  const TextGridTile(this.text);

  @override
  Widget build(BuildContext context) {
    // final text = Provider.of<txt.Text>(context);
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, style: BorderStyle.solid, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(TextUploadScreen.routeName, arguments: text.id);
        },
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<Texts>(context, listen: false).deleteText(text.id!);
          },
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Are you sure ?'),
                content:
                    const Text('The memory will be permanentaly deleted !'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: const Text('Confirm'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            );
          },
          background: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(text.title!, style: const TextStyle(fontSize: 18)),
              subtitle: Text(
                DateFormat.yMMMd().format(text.dateTime!),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text.body!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
