import 'dart:math';

import 'package:flutter_application_test/catalog_model/catalog_item_model.dart';

class FetchingCatalogApi {
  static Future<List<CatalogItemModel>> getItemList({
    required int offset,
    required int limit,
  }) async {
    final endPosition = min(offset + limit, itemList.length);
    return Future.delayed(Duration(seconds: 2)).then((value) {
      return itemList.sublist(offset, endPosition);
    });
  }

  static List<CatalogItemModel> itemList = List.generate(31, (index) {
    return CatalogItemModel(
        name: 'name $index', description: 'description $index', id: index);
  }).toList();
}
