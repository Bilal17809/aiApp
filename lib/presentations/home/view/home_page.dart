
import 'package:ai_app/presentations/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController>{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Obx((){
          return Text("Number: ${controller.number}");
        }),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        controller.increment();
      }),
    );
  }
}
