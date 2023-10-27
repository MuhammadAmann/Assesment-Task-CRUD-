import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class List_Screen2 extends StatefulWidget {
  const List_Screen2({super.key});

  @override
  State<List_Screen2> createState() => _List_Screen2();
}

// ignore: camel_case_types
class _List_Screen2 extends State<List_Screen2> {
  final titlecontroller = TextEditingController();
  final subtitlecontroller = TextEditingController();
  var _contr = TextEditingController();

  //Create a empty list(array) to take input from user and store/add in new section

  List title = [];
  List sub = [];

  int selectedindex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("CRUD assesment task")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //Upper container in which i create a search bar and "Add button" in
          SizedBox(height: 10),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _contr,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search any List title here",
                    suffixIcon: IconButton(
                        onPressed: () {
                          _contr.clear();
                        },
                        icon: Icon(
                          Icons.search,
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(37),
                      borderSide: const BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(37),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          // Start second container in this container make a the lists
          // and this container backword of the upper container so that all the list when
          // scroll-up then the lists will scroll behind the upper container

          Expanded(
            flex: 15,
            child: Container(
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 192, 125, 125),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),

              //Functionality  <<<---------|||

              // All the functionality perform here, this list is created
              //with hard-code, perform the whole functionality by using "List(Arrays)"

              child: ListView.builder(
                itemCount: title.length,
                itemBuilder: (BuildContext Context, index) {
                  if (title.isEmpty) {
                    return Container(
                      child: Center(
                        child: Text("No data"),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 20.0,
                          shadowColor: Colors.blueGrey,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: Color.fromARGB(255, 250, 250, 250),
                            leading: const Icon(
                              Icons.person,
                            ),
                            trailing: SizedBox(
                              width: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        titlecontroller.text = title[index];
                                        subtitlecontroller.text = sub[index];
                                        setState(() {
                                          selectedindex = index;
                                          update();
                                        });
                                      },
                                      child:
                                          Icon(Icons.edit, color: Colors.grey)),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        title.removeAt(index);
                                        sub.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            title: (Text(title[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500))),
                            subtitle: Text(sub[index],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 34, 34, 33))),
                            onTap: () {},
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          additem();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void update() {
    showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              //Add border outline to the dialog box
              // side: BorderSide(color:hfcolor),

              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 250,
                child: Column(
                  children: [
                    SizedBox(height: 6),
                    Center(
                        child: Text(
                      "Add list here",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: titlecontroller,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          ),
                          hintText: "Add title",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          )),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      child: TextField(
                        controller: subtitlecontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          ),
                          hintText: "Add subtitle",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),

                    //An ADD elevated button here
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              String titleee = titlecontroller.text;
                              String subtitleee = subtitlecontroller.text;

                              if (title.isNotEmpty && sub.isNotEmpty) {
                                setState(() {
                                  titlecontroller.text = '';
                                  subtitlecontroller.text = '';

                                  title[selectedindex] = titleee;
                                  sub[selectedindex] = subtitleee;
                                  selectedindex = -1;
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Update")),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 236, 236),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cencel",
                              style: TextStyle(),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }

  void additem() {
    showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              //Add border outline to the dialog box
              // side: BorderSide(color:hfcolor),

              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 250,
                child: Column(
                  children: [
                    SizedBox(height: 6),
                    Center(
                        child: Text(
                      "Add list here",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: titlecontroller,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          ),
                          hintText: "Add title",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          )),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      child: TextField(
                        controller: subtitlecontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          ),
                          hintText: "Add subtitle",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),

                    //An ADD elevated button here
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              String titlee = titlecontroller.text;
                              String subtitlee = subtitlecontroller.text;

                              // print(
                              //     'Title = ${titlee}, Subtitle = ${subtitlee}');

                              //Performing whole funtionality to Update
                              //the List that I can take input from user

                              //Use 'Setstate((){})' to update he List on screen output on screen
                              if (title.isNotEmpty && sub.isNotEmpty) {
                                setState(() {
                                  titlecontroller.text = '';
                                  subtitlecontroller.text = '';

                                  title.add(titlee.toString());
                                  sub.add(subtitlee.toString());
                                });
                                Navigator.pop(context);
                              }
                              ;
                            },
                            child: const Text("Add")),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 236, 236),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cencel",
                              style: TextStyle(),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
