import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/styles/app_colors.dart';
import 'package:loginsignup/widgets/custom_button.dart';
class LoanAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan History"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: loanSearch());

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
            'Loan History',
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
class loanSearch extends SearchDelegate{
  CollectionReference book = FirebaseFirestore.instance.collection('Loan');
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
                child: Text("No Loan Found"),
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
                    final String bname = data["Book Name"];
                    final String time = data["Loan Period"];
                    final String id = data.id;
                    const snackBar = SnackBar(
                      content: Text('The Loan Information has been Deleted ',style: TextStyle(color: Colors.white),),
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
                            content: Text('Are You Sure '),
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
                      },
                      title: Text(name),
                      leading:Text(bname) ,
                      subtitle: Text(time),
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
    // TODO: implement buildSuggestions
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
                child: Text("No Loan Found"),
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
                    final String bname = data["Book Name"];
                    final String time = data["Loan Period"];
                    final String id = data.id;
                    const snackBar = SnackBar(
                      content: Text('The Loan Information has been Deleted ',style: TextStyle(color: Colors.white),),
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
                      },
                      title: Text(name),
                      leading:Text(bname) ,
                      subtitle: Text(time),
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

}