import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalilk/constant/custom_appbar.dart';
import 'package:dalilk/cubit/category_cubit.dart';
import 'package:dalilk/cubit/category_state.dart';
import 'package:dalilk/models/item_model.dart';
import 'package:dalilk/screens/add_item_screen.dart';
import 'package:dalilk/screens/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final String title;
  final String categoryId;

  const CategoryScreen(
      {Key? key, required this.title, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CategoryCubit.get(context).items!.clear();
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: title,
            onTap: () {
              CategoryCubit.get(context).items!.clear();
              Navigator.pop(context);
            },
          ),
          body: BlocConsumer<CategoryCubit, CategoryStates>(
            listener: (context, state) {
              if(state is DeleteItemSuccessState)
                {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item deleted successfully')));
                }
            },
            builder: (context, state) {
              CategoryCubit cubit = CategoryCubit.get(context);
              if (cubit.items != null && cubit.items!.isNotEmpty) {
                return ListView.builder(
                  itemCount: cubit.items!.length,
                  itemBuilder: (context, index) {
                    return ItemWidget(item: cubit.items![index],index: index,);
                  },
                );
              }
              if (state is GetCatItemsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetCatItemsSuccessState || cubit.items!.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "This category is empty try add some items!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddItemScreen(
                      categoryId: categoryId,
                    ))),
            child: const Icon(
              Icons.add,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final ItemModel item;
  final int index;
  const ItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemScreen(index: index),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: item.image,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider)),
                );
              },
              placeholder: (context, url) {
                return Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(item.itemName),
            const Spacer(),
            IconButton(
              onPressed: () {
                CategoryCubit.get(context).deleteItem(
                   image: item.image,
                    itemID: item.itemId, catId: item.catId);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
