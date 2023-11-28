import 'package:flutter/material.dart';
import 'package:shop_shoes_app/global_variables.dart';
import 'package:shop_shoes_app/widgets/product_card.dart';
import 'package:shop_shoes_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All' , 'Adidas' , 'Nike' , 'Bata'];
  late String selectedFilter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Shoes\nCollection' ,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child:TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context , index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0 ,
                        vertical: 18.0 ,
                      ),
                      label: Text(filter),
                      labelStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(235, 237, 239, 1),
                      side: const BorderSide(
                        color: Color.fromRGBO(235, 237, 239, 1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              } ,
            ),
          ),
          Expanded(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  if(constraints.maxWidth > 1080) {
                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.75,
                      ),
                      itemBuilder: (context , index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetailsPage(product: product);
                                  }
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product['title'] as String,
                            price: product['price'] as double,
                            image: product['imageUrl'] as String,
                            backgroundColor: index.isEven
                                ? const Color.fromRGBO(216, 240, 253, 1)
                                : const Color.fromRGBO(245, 247, 249, 1) ,
                          ),
                        );
                      },
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetailsPage(product: product);
                                  }
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product['title'] as String,
                            price: product['price'] as double,
                            image: product['imageUrl'] as String,
                            backgroundColor: index.isEven
                                ? const Color.fromRGBO(216, 240, 253, 1)
                                : const Color.fromRGBO(245, 247, 249, 1) ,
                          ),
                        );
                      },
                    );
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}
