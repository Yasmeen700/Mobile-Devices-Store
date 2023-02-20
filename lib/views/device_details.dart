import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:meta_gate_test/models/products_model.dart';
import 'package:meta_gate_test/presenters/presenter.dart';

import '../constants/app_colors.dart';

class DevicesDetails extends StatelessWidget {
  final DevicesController devicesController = Get.find();

  DevicesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments;
    final List<Widget> imageSliders = product.images!
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'No. ${product.images!.indexOf(item) + 1} image',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    var newPrice = devicesController.calculateNewPrice(
        product.price, product.discountPercentage);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text('Devices Details'),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders),
              const SizedBox(
                height: 8,
              ),
              Text(
                product.title ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                product.brand ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              RatingStars(
                value: product.rating ?? 0,
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                ),
                starCount: 5,
                starSize: 20,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: const Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              ),
              const SizedBox(
                height: 8,
              ),
              product.discountPercentage != null &&
                      product.discountPercentage != 0
                  ? Row(
                      children: [
                        Text(
                          newPrice.toStringAsFixed(2) +' USD',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          product.price != null
                              ? product.price.toString() + ' USD'
                              : 0.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  : Text(
                      product.price != null
                          ? product.price.toString() +' USD'
                          : 0.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
              const SizedBox(
                height: 8,
              ),
              Text(
                product.description ?? '',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                product.stock != null ? product.stock.toString()+' In Stock' : 0.toString(),
                style: const TextStyle(fontSize: 14,color: Colors.green),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
