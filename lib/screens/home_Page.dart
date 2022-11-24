import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsignup/screens/detailsPage.dart';
import 'package:loginsignup/styles/app_colors.dart';
import 'package:loginsignup/widgets/custom_button.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  static const snackBar = SnackBar(
    content: Text('The Book Information has been Deleted ',style: TextStyle(color: Colors.white),),
    backgroundColor: AppColors.blue,

  );
  String selectedValue = 'Computer Science';
  List<String> items = [
    'Computer Science',
    'Mathematics',
    'Engineering',
    'Medical',
    'Languages'
  ];
  final _searchController = TextEditingController();

  String get query => _searchController.text.trim();
  CollectionReference book = FirebaseFirestore.instance.collection('Books');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: book.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
              return ListView(
                padding: EdgeInsets.only(bottom: 60, top: 10),
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: AppColors.lightblue,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Category',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightblue,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.lightblue,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: AppColors.lightblue,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 50,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: AppColors.whiteshade,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.whiteshade,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> elenent) =>
                          elenent["Category"]
                              .toString()
                              .toLowerCase()
                              .contains(selectedValue.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String name = data.get("Name");
                    final String image = data["Image"];
                    final String author = data["Author"];
                    final String year = data["Year"];
                    final String id = data.id;

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
                              child: Image.network(image, fit: BoxFit.cover),
                            )),
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
                ],
              );
            }
          }
        );
  }
}
//Text("${snapshot.data.docs[i].data()["Name"]}",style: kCardTitleStyle,),
