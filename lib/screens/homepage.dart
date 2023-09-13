import 'package:flutter/material.dart';
import 'package:gpa_calculator_1/widgets/kTextField.dart';
import '../model/modul_info_model.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {

  TextEditingController moduleTitleController=TextEditingController();
  TextEditingController moduleCreditUnitController=TextEditingController();
  TextEditingController gradeAtainedController=TextEditingController();

  List<ModuleInfo> moduleList=[];
  List<String> gradesAttained=[
    'A','B','C','D','E','F'
  ];
  List<String> creditsAttained=[
    '1','2','3','4'
  ];
  double gpa=0;
  bool visibleGPA=false;
  String selected= 'A';
  String selectedCredit='1';

  calculateCGPA(){
    if(moduleList.length==1){
      gpa = double.parse(moduleList[0].moduleGradeAttained.toString());
      setState(() {

      });

    }else if(moduleList.length>1){
      double sumCredits=0;
      double gradePointsEarned=0;
      for(int i=0; i<moduleList.length;i++){
        sumCredits = sumCredits+double.parse(moduleList[i].moduleCredits.toString());
        print(sumCredits);
        gradePointsEarned = gradePointsEarned + (double.parse(moduleList[i].moduleCredits.toString())*double.parse(moduleList[i].moduleGradeAttained.toString()));
        print(gradePointsEarned);
      }
      gpa = gradePointsEarned/sumCredits;
      setState(() {

      });
    }

  }

  bool splashOccured=true;
  splash()async{
    Future.delayed(const Duration(seconds: 3),(){
      splashOccured=false;
      setState(() {

      });
    });
  }
  @override
  void initState() {
    moduleCreditUnitController.text='1';
    gradeAtainedController.text='A';
    splash();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return splashOccured?
        Scaffold(
          backgroundColor: const Color(0xffffffff),
          body: Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/splash.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        )
        :Scaffold(
      appBar: AppBar(
        elevation: 1000,
        backgroundColor: Colors.white,
        title: const Center(child: Text("GPA Calculator",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 30),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [


              kTextField(
                  controller: moduleTitleController,
                  label: 'Module Title',
                  hintText: 'Enter Module Title',
                  ),

              const SizedBox(height: 15,),
              TextField(
                readOnly: true,
                controller: gradeAtainedController,
                // keyboardType: keyBoardType,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.school),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 50,right: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        dropdownColor: const Color(0xFFD6D6D6),
                        icon: const Icon(Icons.arrow_drop_down_circle,),
                        isExpanded: true,
                        onTap: ()async{
                          // print(context.watch<InventoryProvider>().selected);


                        },
                        borderRadius: BorderRadius.circular(20),
                        hint: Text(gradeAtainedController.text),
                        items: gradesAttained.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        //
                        // value: selected,
                        onChanged: (String? newValue) async {
                          gradeAtainedController.text=newValue!;
                          setState(() {

                          });
                        },


                      ),
                    ),
                  ),
                  label: const Text("Module Grade"),
                  // hintText: hintText,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                readOnly: true,
                controller: moduleCreditUnitController,
                // keyboardType: keyBoardType,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.scale),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 50,right: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        dropdownColor: const Color(0xFFD6D6D6),
                        icon: const Icon(Icons.arrow_drop_down_circle,),
                        isExpanded: true,
                        onTap: ()async{
                          // print(context.watch<InventoryProvider>().selected);


                        },
                        borderRadius: BorderRadius.circular(20),
                        hint: Text(moduleCreditUnitController.text),
                        items: creditsAttained.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        //
                        // value: selected,
                        onChanged: (String? newValue) async {
                          moduleCreditUnitController.text=newValue!;
                          setState(() {

                          });
                        },


                      ),
                    ),
                  ),
                  label: const Text("Module Credits"),
                  // hintText: hintText,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              const SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  if(
                  moduleTitleController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Title is Required")));
                  }else{


                    ModuleInfo module=ModuleInfo(
                        moduleTitle: moduleTitleController.text,
                        moduleCredits: double.parse(moduleCreditUnitController.text),
                        moduleGradeAttained:
                        gradeAtainedController.text=='A'?4:
                        gradeAtainedController.text=='B'?3:
                        gradeAtainedController.text=='C'?2:
                        gradeAtainedController.text=='D'?1:
                        gradeAtainedController.text=='E'?1:
                        gradeAtainedController.text=='F'?0:
                        0
                    );

                    moduleList.add(module);
                    moduleTitleController.clear();
                    moduleCreditUnitController.text='1';
                    gradeAtainedController.text='A';
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added successfully")));
                    setState(() {

                    });
                  }

                },
                child: Container(

                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*.5,
                    // height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          blurRadius: 5,
                          spreadRadius: 1
                        )
                      ]
                    ),
                    child: const Text("Add Module",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
              ),
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                height: MediaQuery.of(context).size.height*.3,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                ),
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(4),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1.5),
                      4: FlexColumnWidth(1.2),
                      5: FlexColumnWidth(1.5),
                    },
                    children: [
                      const TableRow(
                          children: [
                            TableCell(
                                child: Center(child: Text("S No:",style: TextStyle(fontSize: 10),))),
                            TableCell(
                                child: Center(child: Text("Title",style: TextStyle(fontSize: 10)))),
                            TableCell(
                                child: Center(child: Text("Credit",style: TextStyle(fontSize: 10)))),
                            TableCell(
                                child: Center(child: Text("Attained Grades",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,))),
                            TableCell(
                                child: Center(child: Text("Grade Scale",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,))),
                            TableCell(
                                child: Center(child: Text("Actions",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,))),

                          ]
                      ),
                      for(int i=0;i<moduleList.length;i++)...[
                        TableRow(
                            children: [
                              TableCell(
                                  child: Center(child: Text("${i+1}",style: const TextStyle(fontSize: 10)))),
                              TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(moduleList[i].moduleTitle,style: const TextStyle(fontSize: 10)),
                                  )),
                              TableCell(
                                  child: Center(child: Text("${moduleList[i].moduleCredits.toInt()}",style: const TextStyle(fontSize: 10)))),
                              TableCell(
                                  child: Center(child:
                                  moduleList[i].moduleGradeAttained==4?const Text("A",style: TextStyle(fontSize: 10)):
                                  moduleList[i].moduleGradeAttained<4&&moduleList[i].moduleGradeAttained>=3?const Text("B",style: TextStyle(fontSize: 10)):
                                  moduleList[i].moduleGradeAttained<3&&moduleList[i].moduleGradeAttained>=2?const Text("C",style: TextStyle(fontSize: 10)):
                                  moduleList[i].moduleGradeAttained<2&&moduleList[i].moduleGradeAttained>=1?const Text("D/E",style: TextStyle(fontSize: 10)):
                                  moduleList[i].moduleGradeAttained==0?const Text("F",style: TextStyle(fontSize: 10)):
                                  const Text("A",style: TextStyle(fontSize: 10))
                                  )),
                              TableCell(
                                  child: Center(child: Text("${moduleList[i].moduleGradeAttained.toInt()}",style: const TextStyle(fontSize: 10)))),

                              TableCell(
                                  child: InkWell(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return AlertDialog(
                                                content: const Text("Are you sure to remove module"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: (){
                                                        moduleList.removeAt(i);
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Removed successfully")));

                                                        setState(() {

                                                        });
                                                      },
                                                      child: const Text("Remove")),
                                                  TextButton(
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Cancel")),

                                                ],
                                              );
                                            });

                                      },
                                      child: const Icon(Icons.delete_forever,size: 20,))),

                            ]
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade300,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: 5,
                              spreadRadius: 1
                          )
                        ]
                    ),
                    width: MediaQuery.of(context).size.width*.45,
                    height: 40,
                    child: Center(child: Text("GPA = ${gpa.toStringAsFixed(3)}",style: TextStyle(
                        backgroundColor: Colors.yellow.shade300,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),)),
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){
                        if(moduleList.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Module found in list")));

                        }else{
                          calculateCGPA();

                          setState(() {

                          });
                        }

                      },
                      child: Container(

                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*.35,
                          // height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black87,
                                    blurRadius: 5,
                                    spreadRadius: 1
                                )
                              ]
                          ),
                          child: const Text("Calculate GPA",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  visibleGPA=false;
                  moduleList.clear();
                  moduleTitleController.clear();
                  moduleCreditUnitController.text='1';
                  gradeAtainedController.text='A';
                  gpa=0.000;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reset Successful")));

                  setState(() {

                  });


                },
                child: Container(

                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width*.5,
                    // height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: 5,
                              spreadRadius: 1
                          )
                        ]
                    ),
                    child: const Text("Reset",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
              ),

              // ElevatedButton(
              //     onPressed: (){
              //   if(
              //   moduleTitleController.text.isEmpty){
              //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Title is Required")));
              //   }else{
              //
              //
              //       ModuleInfo module=ModuleInfo(
              //           moduleTitle: moduleTitleController.text,
              //           moduleCredits: double.parse(moduleCreditUnitController.text),
              //           moduleGradeAttained:
              //           gradeAtainedController.text=='A'?4:
              //           gradeAtainedController.text=='B'?3:
              //           gradeAtainedController.text=='C'?2:
              //           gradeAtainedController.text=='D'?1:
              //           gradeAtainedController.text=='E'?1:
              //           gradeAtainedController.text=='F'?0:
              //               0
              //       );
              //
              //       moduleList.add(module);
              //       moduleTitleController.clear();
              //       moduleCreditUnitController.text='1';
              //       gradeAtainedController.text='A';
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added successfully")));
              //       setState(() {
              //
              //       });
              //     }
              //
              // },
              //     child: const Text("Add Module")),
              // ElevatedButton(onPressed: (){
              //   if(moduleList.isEmpty){
              //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Module found in list")));
              //
              //   }else{
              //     calculateCGPA();
              //     visibleGPA=true;
              //     setState(() {
              //
              //     });
              //   }
              //
              // },
              //     child: const Text("Calculate GPA")),
              // ElevatedButton(onPressed: (){
              //   visibleGPA=false;
              //   moduleList.clear();
              //   moduleTitleController.clear();
              //   moduleCreditUnitController.text='1';
              //   gradeAtainedController.text='A';
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reset Successful")));
              //
              //   setState(() {
              //
              //     });
              //
              //
              // },
              //     child: const Text("Reset"))

            ],
          ),
        ),
      ),
    );
  }
}
