import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    final scaffold = ScaffoldMessenger.of(context);
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () async {
              try {
                await product.toggleFavourite(authData.token, authData.userId);
                scaffold.hideCurrentSnackBar();
                scaffold.showSnackBar(SnackBar(
                    content: product.isFavourite
                        ? Text(
                            "Item Favourited!",
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "Item Unfavourited!",
                            textAlign: TextAlign.center,
                          )));
              } catch (error) {
                scaffold.hideCurrentSnackBar();
                scaffold.showSnackBar(SnackBar(
                    content: product.isFavourite
                        ? Text(
                            "Couldn't unfavourite the item!",
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "Couldn't favourite the item!",
                            textAlign: TextAlign.center,
                          )));
              }
            },
            icon: Icon(
              product.isFavourite ? Icons.favorite : Icons.favorite_outline,
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to the cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
