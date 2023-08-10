
import 'dart:convert';

CAtegoryModel cAtegoryModelFromJson(String str) => CAtegoryModel.fromJson(json.decode(str));


class CAtegoryModel {
    List<Category> categories;

    CAtegoryModel({
        required this.categories,
    });

    factory CAtegoryModel.fromJson(Map<String, dynamic> json) => CAtegoryModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    
}

class Category {
    String name;
    List<String> subcategory;

    Category({
        required this.name,
        required this.subcategory,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
    );

    
}
