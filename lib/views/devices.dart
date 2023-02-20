import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta_gate_test/constants/app_colors.dart';
import 'package:meta_gate_test/models/products_model.dart';
import 'package:meta_gate_test/presenters/presenter.dart';
import 'package:meta_gate_test/views/search_screen.dart';

import '../widgets/request_retry.dart';
import 'device_details.dart';

class DevicesScreen extends StatelessWidget {
  final DevicesController devicesController = Get.put(DevicesController());

  DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text('Devices'),
          actions: [
            IconButton(onPressed: () {
              Get.to(() => SearchScreen());
            }, icon: const Icon(Icons.search))
          ],
        ),
        body: FutureBuilder(
          future: devicesController.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(
                () => devicesController.products.isNotEmpty
                    ? Obx(
                        () => ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: devicesController.products.length,
                          itemBuilder: (context, index) {
                            return DeviceCard(
                              product: devicesController.products[index],
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
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final Product product;

  const DeviceCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.primaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  product.thumbnail ?? '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      product.brand ?? '',
                    ),
                  ],
                ),
              )
            ],
          )),
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: () {
              Get.to(() => DevicesDetails(), arguments: product);
            },
            icon: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
