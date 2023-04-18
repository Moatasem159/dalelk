import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalilk/constant/custom_appbar.dart';
import 'package:dalilk/constant/text_form_field.dart';
import 'package:dalilk/cubit/category_cubit.dart';
import 'package:dalilk/cubit/category_state.dart';
import 'package:dalilk/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditItemScreen extends StatelessWidget {
  final ItemModel item;
  final int index;
  const EditItemScreen({Key? key, required this.item, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameCon = TextEditingController();
    TextEditingController disCon = TextEditingController();
    TextEditingController linkCon = TextEditingController();
    nameCon.text=item.itemName;
    disCon.text=item.description;
    linkCon.text=item.link;

    var formKey = GlobalKey<FormState>();
    return BlocConsumer<CategoryCubit, CategoryStates>(
      listener: (context, state) {
        if (state is EditItemSuccessState) {
          nameCon.clear();
          disCon.clear();
          linkCon.clear();
          CategoryCubit.get(context).image = null;
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async{
            CategoryCubit.get(context).image=null;
            nameCon.clear();
            disCon.clear();
            linkCon.clear();
            Navigator.pop(context);
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              appBar:  CustomAppBar(title: "Edit item",onTap: () {
                CategoryCubit.get(context).image=null;
                nameCon.clear();
                disCon.clear();
                linkCon.clear();
                Navigator.pop(context);
              },),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (CategoryCubit.get(context).image == null)
                          CachedNetworkImage(
                            imageUrl: item.image,
                            height: 200,
                            width: 200,
                          ),
                          if (CategoryCubit.get(context).image != null)
                            Image(
                                image: FileImage(CategoryCubit.get(context).image!),
                                height: 200,
                                width: 200),
                        ],
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              CategoryCubit.get(context).getImage(false);
                            },
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 50)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10))),
                                padding:
                                MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor:
                                MaterialStateProperty.all(Colors.orange)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("pick image"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.image)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              CategoryCubit.get(context).getImage(true);
                            },
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 50)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10))),
                                padding:
                                MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor:
                                MaterialStateProperty.all(Colors.orange)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("pick image"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.camera)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          NoneBorderTextFormField(
                              size: 20, hintText: 'name', controller: nameCon),
                          const SizedBox(
                            height: 15,
                          ),
                          NoneBorderTextFormField(
                              size: 20,
                              hintText: 'description',
                              controller: disCon),
                          const SizedBox(
                            height: 15,
                          ),
                          NoneBorderTextFormField(
                              size: 20, hintText: 'link', controller: linkCon),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CategoryCubit, CategoryStates>(
                      builder: (context, state) {
                        if (state is EditItemLoadingState ) {
                          return const CircularProgressIndicator();
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if(state is !EditItemLoadingState)
                    {
                      if (formKey.currentState!.validate()) {
                        if (CategoryCubit.get(context).image != null) {
                          CategoryCubit.get(context).editItem(
                              catId: item.catId,
                              name: nameCon.text,
                              description: disCon.text,
                              link: linkCon.text,
                              image: item.image,
                              index: index,
                              newImage: true,
                              itemId:item.itemId
                          );
                        }
                        else {
                          CategoryCubit.get(context).editItem(
                              catId: item.catId,
                              name: nameCon.text,
                              description: disCon.text,
                              link: linkCon.text,
                              image: item.image,
                              index: index,
                              itemId:item.itemId
                          );
                        }
                      }
                    }
                },
                child: const Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
