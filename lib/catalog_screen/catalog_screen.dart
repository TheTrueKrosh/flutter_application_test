import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_test/catalog_model/catalog_api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../catalog_model/catalog_item_model.dart';

class CatalogScreenWidget extends StatelessWidget {
  const CatalogScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: GroupList(),
        child: Column(
          children: const [
            CatalogTitle(),
            Divider(),
            GroupList(),
          ],
        ),
      ),
    );
  }
}

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  static const _pageSize = 20;
  final PagingController<int, CatalogItemModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await FetchingCatalogApi.getItemList(
          offset: pageKey, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PagedListView<int, CatalogItemModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CatalogItemModel>(
          noMoreItemsIndicatorBuilder: (context) {
            return Text('12345');
          },
          itemBuilder: ((context, item, index) => GroupItem(
                model: item,
              )),
        ),
      ),
    );
    // return Expanded(
    //   child: ListView(children: const [
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //     GroupItem(),
    //   ]),
    // );
  }
}

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.model});
  final CatalogItemModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Material(
        shadowColor: Colors.black,
        elevation: 3,
        child: MaterialButton(
          onPressed: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.handyman,
                  size: 60,
                ),
                const SizedBox(
                  width: 10,
                ),
                GroupNameWidget(
                  id: model.id,
                  name: model.name,
                  description: model.description,
                ),
                const Icon(
                  Icons.arrow_right_outlined,
                  size: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupNameWidget extends StatelessWidget {
  const GroupNameWidget({
    super.key,
    required this.name,
    required this.description,
    required this.id,
  });

  final String name;
  final String description;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        'id: $id, name: $name - $description',
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}

class CatalogTitle extends StatelessWidget {
  const CatalogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: const Text(
            'Каталог',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
