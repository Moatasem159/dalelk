import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalilk/constant/custom_appbar.dart';
import 'package:dalilk/cubit/category_cubit.dart';
import 'package:dalilk/cubit/category_state.dart';
import 'package:dalilk/screens/edit_item_screen.dart';
import 'package:dalilk/screens/web_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemScreen extends StatelessWidget {
  final int index;
  const ItemScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryCubit cubit=CategoryCubit.get(context);
    return BlocBuilder<CategoryCubit, CategoryStates>(
  builder: (context, state) {
    return SafeArea(child: Scaffold(
      appBar: CustomAppBar(title: cubit.items![index].itemName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Center(child: CachedNetworkImage(
              imageUrl: cubit.items![index].image,
              width: 250,height: 250,
              placeholder: (context, url) {
                return Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey[500],
                );
              },
            )),
            const SizedBox(height: 10,),
            Text(cubit.items![index].itemName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(cubit.items![index].description,style: const TextStyle(fontSize: 18),textAlign: TextAlign.center),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebScreen(link: cubit.items![index].link),));
              },
              child: Text(cubit.items![index].link,style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                decoration: TextDecoration.underline
              ),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditItemScreen(item:cubit.items![index], index: index,),));
        },
        child: const Icon(Icons.edit),
      ),
    ));
  },
);
  }
}
