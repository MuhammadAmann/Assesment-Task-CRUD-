import 'package:assesment_task/db_services/db_helper.dart';
import 'package:assesment_task/db_services/listModel.dart';
import 'package:flutter/material.dart';

class List_Screen extends StatefulWidget {
  const List_Screen({super.key});

  @override
  State<List_Screen> createState() => _List_ScreenState();
}

class _List_ScreenState extends State<List_Screen> {
  final title = TextEditingController();
  final subtitle = TextEditingController();

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  Db_helper? db_helper;
  late Future<List<listModel>> listdata;
  @override
  void initState() {
    super.initState();
    db_helper = Db_helper();
    loadData();
  }

  loadData() async {
    listdata = db_helper!.getListdata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("CRUD assesment task"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: listdata,
              builder: (context, AsyncSnapshot<List<listModel>> snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return Card(
                        child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  title.text = snapshot.data![index].title;
                                  subtitle.text =
                                      snapshot.data![index].subtitle;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    db_helper!
                                                        .update(listModel(
                                                            id: snapshot
                                                                .data![index]
                                                                .id,
                                                            title: title.text,
                                                            subtitle:
                                                                subtitle.text))
                                                        .whenComplete(() {
                                                      setState(() {
                                                        listdata = db_helper!
                                                            .getListdata();
                                                        Navigator.pop(context);
                                                      });
                                                    });
                                                  },
                                                  child: const Text(
                                                    "Update",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Cencel",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                            ],
                                          )
                                        ],
                                        title: const Text("Update List"),
                                        content: Form(
                                          key: _formkey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: title,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter title";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "title"),
                                              ),
                                              const SizedBox(height: 10),
                                              TextFormField(
                                                controller: subtitle,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter title";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "title"),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                            title: Text("${snapshot.data![index].title}"),
                            subtitle:
                                Text(snapshot.data![index].subtitle.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    db_helper!
                                        .delete(snapshot.data![index].id!)
                                        .whenComplete(() {
                                      listdata = db_helper!.getListdata();
                                      snapshot.data!
                                          .remove(snapshot.data![index].id!);
                                    });
                                  });
                                },
                                icon: const Icon(Icons.delete))),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.text = "";
          subtitleController.text = "";
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            db_helper!
                                .insertdata(listModel(
                              title: titleController.text,
                              subtitle: subtitleController.text,
                            ))
                                .then((value) {
                              print("Data added");
                              setState(() {
                                listdata = db_helper!.getListdata();
                                if (_formkey.currentState!.validate()) {
                                  Navigator.pop(context);
                                } else {
                                  return null;
                                }
                              });
                            }).onError((error, stackTrace) {
                              print(error.toString());
                            });
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.blue),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cencel",
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  )
                ],
                title: const Text("Add Item"),
                content: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter title";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(hintText: "title"),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: subtitleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter subtitle";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(hintText: "subtitle"),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // void updatebox() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         actions: [
  //           Row(
  //             children: [
  //               TextButton(
  //                   onPressed: () {
  //                     db_helper!
  //                         .update(listModel(
  //                             title: title.text, subtitle: subtitle.text))
  //                         .whenComplete(() {});
  //                   },
  //                   child: Text(
  //                     "Update",
  //                     style: TextStyle(color: Colors.blue),
  //                   )),
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text(
  //                     "Cencel",
  //                     style: TextStyle(color: Colors.black),
  //                   )),
  //             ],
  //           )
  //         ],
  //         title: Text("Update List"),
  //         content: Form(
  //           key: _formkey,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextFormField(
  //                 controller: title,
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return "Please enter title";
  //                   } else {
  //                     return null;
  //                   }
  //                 },
  //                 decoration: InputDecoration(hintText: "title"),
  //               ),
  //               SizedBox(height: 10),
  //               TextFormField(
  //                 controller: subtitle,
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return "Please enter title";
  //                   } else {
  //                     return null;
  //                   }
  //                 },
  //                 decoration: InputDecoration(hintText: "title"),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
