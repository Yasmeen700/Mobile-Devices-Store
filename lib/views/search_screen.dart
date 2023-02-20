import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta_gate_test/presenters/presenter.dart';

import '../constants/app_colors.dart';
import '../widgets/request_retry.dart';
import 'devices.dart';

class SearchScreen extends StatefulWidget {

  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DevicesController devicesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child:  Center(
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  border: InputBorder.none),
              onChanged: (value) async{
                setState(() {
                  devicesController.searchForProduct(value);
                });

              },
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: devicesController.searchFuture.value,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
                  () => devicesController.productsSearchResult.isNotEmpty
                  ? Obx(
                    () => ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: devicesController.productsSearchResult.length,
                  itemBuilder: (context, index) {
                    return DeviceCard(
                      product: devicesController.productsSearchResult[index],
                    );
                  },
                ),
              )
                  : const Center(
                child: Text('Devices list is empty'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(snapshot.error);
            return Center(
              child: RequestRetry(
                retryCallback: devicesController.getAllProducts,
                message: 'ConnectionField',
              ),
            );
          }
        },
      ),
    );
  }
}
