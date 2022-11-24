
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsignup/screens/detailsPage.dart';
import 'package:loginsignup/styles/app_colors.dart';
import 'package:loginsignup/widgets/custom_button.dart';

class SearchAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: SearchPage());

              // final results = await
              //     showSearch(context: context, delegate: CitySearch());

              // print('Result: $results');
            },
          )
        ],
        backgroundColor: AppColors.lightblue,
      ),
      body: Container(
        color: AppColors.whiteshade,
        child: const Center(
          child: Text(
            'Search for Books',
            style: TextStyle(
              color: AppColors.lightblue,
              fontWeight: FontWeight.bold,
              fontSize: 64,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class SearchPage extends SearchDelegate {
  CollectionReference book = FirebaseFirestore.instance.collection('Books');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(onPressed: () {
        query = "";
      },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: book.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!
                .docs
                .where(
                    (QueryDocumentSnapshot<Object?> elenent) =>
                    elenent["Name"]
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No Book Found"),
              );
            }
            else {
              return ListView(
                children: [
                  ...snapshot.data!.docs.where(
                          (QueryDocumentSnapshot<Object?> elenent) =>
                          elenent["Name"]
                          .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase())).map((
                      QueryDocumentSnapshot<Object?> data) {
                    final String name = data.get("Name");
                    final String image = data["Image"];
                    final String author = data["Author"];
                    final String year = data["Year"];
                    final String id = data.id;
                    const snackBar = SnackBar(
                      content: Text('The Book Information has been Deleted ',style: TextStyle(color: Colors.white),),
                      backgroundColor: AppColors.blue,

                    );
                    void deletebook() {
                      book.doc(id).delete();
                    }
                    void _showDialog(BuildContext context) {
                      showDialog(
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text('Info'),
                            content: Text('A New Book Has Been Added'),
                            actions: [
                              AuthButton(
                                onTTap: () {},
                                text: 'OK',
                                onTap: () {
                                  deletebook();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ),
                            ],
                          );
                        },
                        context: context,
                        barrierDismissible: false,
                      );
                    }
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  data: data,
                                )));
                      },
                      title: Text(name),
                      leading: Container(
                        height: 150,
                        width: 80,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(image,fit:BoxFit.cover),
                                )
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(year),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: () {
                          _showDialog(context);
                        },
                      ),
                      isThreeLine: true,
                    );
                  })

                ],);
            }
          }
        }

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: book.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs.where(
                          (QueryDocumentSnapshot<Object?> elenent) =>
                          elenent["Name"]
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase())).map((
                      QueryDocumentSnapshot<Object?> data) {
                    final String name = data.get("Name");
                    final String image = data["Image"];
                    final String author = data["Author"];
                    final String year = data["Year"];
                    final String id = data.id;
                    const snackBar = SnackBar(
                      content: Text('The Book Information has been Deleted ',style: TextStyle(color: Colors.white),),
                      backgroundColor: AppColors.blue,

                    );
                    void deletebook() {
                      book.doc(id).delete();
                    }
                    void _showDialog(BuildContext context) {
                      showDialog(
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text('Info'),
                            content: Text('Are You Sure to Delete This Book'),
                            actions: [
                              AuthButton(
                                onTTap: () {},
                                text: 'OK',
                                onTap: () {
                                  deletebook();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ),

                              SizedBox(
                                height: 20.0,
                              ),
                              AuthButton(
                                onTTap: () {},
                                text: 'Cancel',
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                        context: context,
                        barrierDismissible: false,
                      );
                    }
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  data: data,
                                )));
                      },
                      title: Text(name),
                      leading: Container(
                        height: 150,
                        width: 80,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(image,fit:BoxFit.cover),
                                )
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(year),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: () {
                          _showDialog(context);
                        },
                      ),
                      isThreeLine: true,
                    );
                  })

                ],);
            }
          }


    );
  }

}