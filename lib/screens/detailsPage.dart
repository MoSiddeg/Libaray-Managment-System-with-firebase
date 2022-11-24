import 'dart:ui';
import 'package:loginsignup/widgets/custom_button.dart';
import 'package:loginsignup/widgets/custom_formfield.dart';
import 'package:readmore/readmore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/constants.dart';
import 'package:loginsignup/styles/app_colors.dart';
import 'package:loginsignup/widgets/custom_header.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({this.data});

  final QueryDocumentSnapshot<Object?>? data;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  CollectionReference loan = FirebaseFirestore.instance.collection('Loan');
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();

  String get time => _timeController.text.trim();

  String get name => _nameController.text.trim();
  late String nme = widget.data!.get('Name');

  Future<void> addbook() async {
    print('added');
    // Call the user's CollectionReference to add a new user

    return loan
        .add({'Name': name, 'Book Name': nme, 'Loan Period': time})
        .then((value) => print("Loan Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Info'),
          content: Text('All Infromation Required'),
          actions: [
            CustomFormField(
                headingText: "Name of Borrower",
                hintText: "Enter The Full Name of Borrower",
                obsecureText: false,
                suffixIcon: const SizedBox(),
                controller: _nameController,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
                onChanged: (String) {}),
            SizedBox(
              height: 20,
            ),
            CustomFormField(
                headingText: "loan Period",
                hintText: "loan Period",
                obsecureText: false,
                suffixIcon: const SizedBox(),
                controller: _timeController,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
                onChanged: (String) {}),
            SizedBox(
              height: 20,
            ),
            AuthButton(
              onTTap: () {},
              text: 'OK',
              onTap: () {
                addbook();
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 20,
            ),
            AuthButton(
              onTTap: () {},
              text: 'Cancel',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
      context: context,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          backgroundColor: AppColors.blue,
          child: const Text('Loan'),
          // Icon(Icons.book_rounded),
        ),
        body: Ink(
            color: Color(0xFF0FEEC0),
            child: ListView(padding: EdgeInsets.only(bottom: 20), children: [
              SafeArea(
                  child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height - 18,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.blue,
                ),
                CustomHeader(
                  text: 'Details.',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.08,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: AppColors.whiteshade,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.09,
                              right: MediaQuery.of(context).size.width * 0.09),
                          child: Image.network(widget.data!.get('Image'),
                              fit: BoxFit.cover),

                          //       Container(
                          //       height: 200,
                          //            width: MediaQuery.of(context).size.width ,
                          //          child: Image.network(
                          //            widget.data!.get('Image'),
                          //          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                            child: Row(children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text('Name : ', style: kLargeTitleStyle),
                          Text(widget.data!.get('Name'),
                              style: kTitle1Style.apply(
                                  color: AppColors.lightblue)),
                        ])),
                        Center(
                            child: Row(children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text('Author :  ', style: kLargeTitleStyle),
                          Text(widget.data!.get('Author'),
                              style: kTitle1Style.apply(
                                  color: AppColors.lightblue)),
                        ])),
                        Center(
                            child: Row(children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text('Year :  ', style: kLargeTitleStyle),
                          Text(widget.data!.get('Year'),
                              style: kTitle1Style.apply(
                                  color: AppColors.lightblue)),
                        ])),
                        Center(
                            child: Row(children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text('Category :  ', style: kLargeTitleStyle),
                          Text(widget.data!.get('Category'),
                              style: kTitle1Style.apply(
                                  color: AppColors.lightblue)),
                        ])),
                      ]),

                      // Container(
                      //  child: Image.network(
                      //  widget.data!.get('Image'),
                      //  )
                      //);,
                    )),
              ])),
              Row(children: [
                SizedBox(
                  width: 40,
                ),
                Text('Description :  ', style: kLargeTitleStyle),
              ]),
              Center(
                  child: Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                height: 5000,
                child: ReadMoreText(
                  widget.data!.get('Description'),
                  style: kTitle1Style.apply(color: AppColors.lightblue),
                  trimLines: 3,
                  textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: 'Show less',
                  lessStyle: kSubtitleStyle.apply(color: Colors.black12),
                  moreStyle: kSubtitleStyle.apply(color: Colors.black12),
                ),
              ))
            ])));
  }
}
