import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments.toString();
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findProductById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('${loadedProduct.title}'),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                  width: double.infinity * 7,
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.black54,
                  child: Text('${loadedProduct.title}')),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '\$${loadedProduct.price}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    '${loadedProduct.description}',
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 1010.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
