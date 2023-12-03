import 'package:flutter/material.dart';
import 'package:trendhub/Models/Product.dart';
import 'package:trendhub/utils/companyName.dart';

class ProductScreen extends StatefulWidget {
  final Products? product;

  ProductScreen({required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          currentIndex = 0;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: CompanyName(),
          centerTitle: true,
          elevation: 20,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag))
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: Colors.white, style: BorderStyle.solid)),
              padding: EdgeInsets.all(20),
              child: Card(
                child: Image.network('${widget.product!.images![currentIndex]}',
                    fit: BoxFit.fill),
              ),
              width: double.infinity,
              height: 300.0,
            ),
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        color: Colors.white, style: BorderStyle.solid)),
                padding: EdgeInsets.all(20),
                width: 600,
                height: 100.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: 300,
                        child: Text(
                          '${widget.product!.title}',
                          softWrap: true,
                          style: TextStyle(fontSize: 20.0, letterSpacing: 4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text('\$${widget.product!.price}',
                        softWrap: true,
                        style:
                            const TextStyle(fontSize: 20.0, letterSpacing: 5)),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange,
                        ),
                        width: 70,
                        height: 30,
                        child: IconButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                          icon: const Text(
                            'BUY',
                            style: TextStyle(fontSize: 15),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: Text('${widget.product!.description}')),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              width: double.infinity,
              height: 70.0,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            '\$${widget.product!.price}',
                            style: TextStyle(fontSize: 30, letterSpacing: 5),
                          ))),
                  Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 247, 125, 3)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.shopping_cart),
                            SizedBox(
                              width: 30,
                            ),
                            Text("Cart",
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 5)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    //     if (currentIndex < widget.product!.images!.length - 1) {
    //       setState(() {
    //         currentIndex++;
    //       });
    //     } else {
    //       setState(() {
    //         currentIndex = 0;
    //       });
    //     }
    //     _startTimer();
    //   },
    // );
  }
}
