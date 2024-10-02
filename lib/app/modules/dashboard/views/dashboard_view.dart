import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.token = Get.arguments;
    controller.getToken();
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  "To-Do With NodeJs and MongoDB",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "5 Task",
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.items?.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                print('${controller.items![index]['_id']}');
                                controller.deleteItem(
                                    '${controller.items![index]['_id']}');
                              },
                              icon: Icons.delete,
                              label: "Delete",
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                            )
                          ],
                        ),
                        child: Card(
                          borderOnForeground: false,
                          child: ListTile(
                            leading: const Icon(Icons.task),
                            title: Text('${controller.items![index]['title']}'),
                            subtitle:
                                Text('${controller.items![index]['desc']}'),
                            trailing: const Icon(Icons.arrow_back),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Add To-Do",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: controller.toDoTitle,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      controller: controller.toDoDesc,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Description",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.addToDoData();
                        Get.back();
                      },
                      child: const Text("Add"),
                    )
                  ],
                ),
              );
            }),
        tooltip: "Add-ToDo",
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Future<void> displayTextInputDialog(BuildContext context,title,desc) async {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Add To-Do",style: TextStyle(fontWeight: FontWeight.w500),),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: title,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: "Title",
//                     hintStyle: TextStyle(
//                       color: Colors.grey
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)))),
//               ),
//               const SizedBox(height: 6,),
//               TextFormField(
//                 controller: desc,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: "Description",
//                     hintStyle: TextStyle(
//                       color: Colors.grey
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)))),
//               ),
//               const SizedBox(height: 3,),
//               ElevatedButton(onPressed: () {}, child: const Text("Add"),)
//             ],
//           ),
//         );
//       });
// }
