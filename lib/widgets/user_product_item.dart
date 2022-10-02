import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/edit_products_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            '$title',
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, EditProductScreen.routeName,
                        arguments: id);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                  onPressed: () async {
                    try {
                      await Provider.of<Products>(context,
                              listen: false)
                          .deleteProduct(id);
                    } catch (_) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.black,
                          content: Text(
                            'Delete failed',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
