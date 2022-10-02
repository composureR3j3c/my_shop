import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/edit_products_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_products';
  const UserProductScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(context) async {
    await Provider.of<Products>(context, listen: false).fetchProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Products'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async =>
                          await Provider.of<Products>(context, listen: false)
                              .fetchProduct(true),
                      child: Consumer<Products>(
                        builder: (context, productData, _) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: productData.items.length,
                            itemBuilder: (_, i) => UserProductItem(
                                productData.items[i].id,
                                productData.items[i].title,
                                productData.items[i].imageUrl),
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
