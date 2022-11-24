import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsignup/controllers/firebase_api.dart';
import 'package:loginsignup/screens/signin.dart';
import 'package:loginsignup/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginsignup/widgets/custom_button.dart';
import 'package:loginsignup/widgets/custom_formfield.dart';
import 'package:loginsignup/widgets/custom_header.dart';
import 'package:path/path.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class uploadPage extends StatefulWidget {
  @override
  _uploadPageState createState() => _uploadPageState();
}

class _uploadPageState extends State<uploadPage> {
  final _firestore = FirebaseFirestore.instance;
  static const snackBar = SnackBar(
    content: Text('New Book Has been Added',style: TextStyle(color: Colors.white),),
    backgroundColor: AppColors.blue,

  );
  CollectionReference book = FirebaseFirestore.instance.collection('Books');

  String? url;

  Future<void> addbook() async {
    selectedVal ??= "unknown";
    selectedValue ??= "unknown";
    print('added');
    // Call the user's CollectionReference to add a new user
    if (url == null) return;
    return book
        .add({
          'Name': name,
          'Category': selectedValue,
          'Year': selectedVal,
          'Author': aoth,
          'Description': desc,
          'Image': url
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }
  void _showDialog(BuildContext context){
    showDialog(builder: (BuildContext context) {

      return  AlertDialog(

        backgroundColor: Colors.white,
        title: Text('Info'),
        content: Text('A New Book Has Been Added'),
        actions: [
          AuthButton(onTTap: () {  }, text: 'OK', onTap: (){
          addbook();
          Navigator.of(context).pop();},),
        ],
      );
    }, context: context,
      barrierDismissible:false,

    );
  }

  UploadTask? task;
  File? file;
  final _nameController = TextEditingController();
  final _aothController = TextEditingController();
  final _descController = TextEditingController();

  String get name => _nameController.text.trim();

  String get aoth => _aothController.text.trim();

  String get desc => _descController.text.trim();
  String? selectedValue;
  String? selectedVal;
  List<String> items = [
    'Computer Science',
    'Mathematics',
    'Engineering',
    'Medical',
    'Languages'
  ];
  List<String> item = [
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
  ];

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height - 18,
          width: MediaQuery.of(context).size.width,
          color: AppColors.blue,
        ),
        CustomHeader(
          text: 'Add Book.',
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Signin()));
          },
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
          child: Container(
            height: MediaQuery.of(context).size.height + 20 ,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Color(0xFF0FEEC0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.09),
                child: Image.asset("assets/images/login.png"),
              ),
              const SizedBox(
                height: 24,
              ),
              AuthButton(
                text: 'Select Image',
                onTap: selectFile, onTTap: () {  },
              ),
              SizedBox(height: 8),
             Center(child: Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),),
              SizedBox(height: 20),
              CustomFormField(
                headingText: "Name",
                hintText: "Name",
                obsecureText: false,
                suffixIcon: const SizedBox(),
                controller: _nameController,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
                onChanged: (String) {},
              ),
              CustomFormField(
                  headingText: "Author",
                  hintText: "Author",
                  obsecureText: false,
                  suffixIcon: const SizedBox(),
                  controller: _aothController,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                  onChanged: (String) {}),
              CustomFormField(
                  headingText: "Description",
                  hintText: "Description",
                  obsecureText: false,
                  suffixIcon: const SizedBox(),
                  controller: _descController,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                  onChanged: (String) {}),
              SizedBox(
                height: 20.0,
              ),
              DropdownButtonHideUnderline(
                child: Row(children: [
                  SizedBox(width: 30,),
                  DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.white,
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
                              color: Colors.white,
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
                                  color: Colors.white,
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
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: AppColors.blue,
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: 200,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.blue,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: AppColors.whiteshade,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Year',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteshade,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: item
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedVal,
                    onChanged: (value) {
                      setState(() {
                        selectedVal = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: AppColors.whiteshade,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: AppColors.blue,
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: 200,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.blue,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                ]),
              ),
              SizedBox(height: 10,),
              AuthButton(
                text: 'Upload',
                onTap: () {
                  uploadFile(); _showDialog(context);
                  }, onTTap: () {  },
              ),
              SizedBox(height: 10),
              task != null ? buildUploadStatus(task!) : Container(),
            ]),
          ),
        ),
      ])),
    ));

  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download-Link: $urlDownload');
    url = urlDownload;
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Center( child :Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ));
          } else {
            return Container();
          }
        },
      );
}
