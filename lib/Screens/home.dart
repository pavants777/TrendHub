import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Models/Product.dart';
import 'package:trendhub/Models/UserModels.dart';
import 'package:trendhub/Routes/routes.dart';
import 'package:trendhub/Screens/ChatScreen.dart';
import 'package:trendhub/Screens/product_details.dart';
import 'package:trendhub/utils/DrawerForApp.dart';
import 'package:trendhub/utils/companyName.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Products>? products;
  GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _initializeUser();
    fetchAll();
  }

  Future<void> _initializeUser() async {
    user = UserModel();
    await getuser();
  }

  Future<void> getuser() async {
    if (user != null) {
      user!.userEmail = FirebaseAuth.instance.currentUser?.email;
      print(user!.userEmail);

      try {
        var docRef = await FirebaseFirestore.instance
            .collection('Accounts')
            .doc(user!.userEmail)
            .get();

        print('Document data: ${docRef.data()}');

        if (docRef.exists) {
          user!.userName = docRef.data()?['userName']?.toString();
          print('User Name: ${user!.userName}');
        } else {
          print('Document does not exist');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('user not founded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.menu),
          onTap: () {
            print('Ontap');
            _scaffoldstate.currentState!.openDrawer();
          },
        ),
        title: CompanyName(),
        backgroundColor: Colors.black,
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.profilescreen);
              },
              icon: Icon(Icons.person_outline)),
        ],
      ),
      drawer: DrawerForApp(
        user: user,
      ),
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () async {
          setState(() {
            products!.shuffle();
          });
        },
        child: products == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0),
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreen(product: products![index])));
                      },
                      title: Stack(
                        children: [
                          _itemarange(index),
                          _titleView(index),
                        ],
                      ));
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
          height: 70,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.shopping_cart),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        },
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.add)),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void fetchAll() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> product = json['products'];

        setState(() {
          products = product.map((e) => Products.fromJson(e)).toList();
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _itemarange(int index) {
    return Card(
      elevation: 2,
      child: Container(
        height: 90,
        width: 70,
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Image.network('${products![index].thumbnail}',
            width: 200, height: 100, fit: BoxFit.fill),
      ),
    );
  }

  Widget _titleView(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.75)),
          child: Column(
            children: [
              Text(
                '${products![index].title}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              SafeArea(
                child: Text(
                  '\$${products![index].price}',
                  softWrap: true,
                  style: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 20,
                      color: Color.fromARGB(255, 246, 243, 243)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
