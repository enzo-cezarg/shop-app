import 'package:flutter/material.dart';
import 'package:shop/components/product_grid_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid({required this.showFavoriteOnly, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductGridItem(),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
