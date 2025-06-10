import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;

  Product(
      {required this.image,
        required this.title,
        required this.description,
        required this.price,
        required this.size,
        required this.id,
        required this.color});
}

List<Product> products = [
  Product(
      id: 1,
      title: "Ikan Kerapu size xl ditangkap pagi ini masih fress ",
      price: 10000,
      size: 12,
      description: dummyText,
      image: "assets/images/fish_1.jpeg",
      color: const Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Ikan Kerapu size M ditangkap pagi ini masih fress ",
      price: 234,
      size: 8,
      description: dummyText,
      image: "assets/images/fish_2.jpeg",
      color: const Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "Ikan Kerapu size xl ditangkap pagi ini masih fress",
      price: 234,
      size: 10,
      description: dummyText,
      image: "assets/images/fish_3.jpg",
      color: const Color(0xFF989493)),
  Product(
      id: 4,
      title: "Ikan Lele size xl ditangkap pagi ini masih frozen",
      price: 234,
      size: 11,
      description: dummyText,
      image: "assets/images/fish_4.jpeg",
      color: const Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "Ikan paus size xl ditangkap pagi ini masih frozen",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/fish_5.jpeg",
      color: const Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "Ikan Nila size xl ditangkap pagi ini masih frozen",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/fish_6.jpg",
    color: const Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
