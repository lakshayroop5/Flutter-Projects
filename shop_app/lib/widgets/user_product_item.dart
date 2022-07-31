import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          EditProductScreen.routeName,
                          arguments: id);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text('Delete!'),
                                content: Text(
                                    'Are you sure to remove the item permanently?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () async {
                                        try {
                                          await Provider.of<Products>(context,
                                                  listen: false)
                                              .deleteProduct(id);
                                          Navigator.of(ctx).pop();
                                        } catch (error) {
                                          Navigator.of(ctx).pop();
                                          scaffold.showSnackBar(SnackBar(
                                            content: Text(
                                              'Deletion Failed',
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        }
                                      },
                                      child: Text('Yes')),
                                ],
                              ));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    )),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
