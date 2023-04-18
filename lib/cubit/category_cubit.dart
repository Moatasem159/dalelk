import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalilk/cubit/category_state.dart';
import 'package:dalilk/models/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());
  static CategoryCubit get(context) => BlocProvider.of(context);
  var picker = ImagePicker();
  File? image;
  getImage(bool isCamera) async {
    var pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(PickImageSuccessState());
    } else {
      emit(PickImageErrorState());
    }
  }
 Future<String> uploadItemImage({required String catId}) async{
    String imageLink='';
   await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('$catId/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) async{
      await value.ref.getDownloadURL().then((value){
      imageLink=value;
      });
    });
    return imageLink;
  }

  Future <void> addItem(
      {required String itemName,
      required String description,
      required String catId,
      required String link,
      })async{
    emit(AddCategoryLoadingState());
    ItemModel model = ItemModel(
        itemName: itemName,
        link: link,
        description: description,
        image: await uploadItemImage(catId: catId),
        catId: catId,
        itemId: "");
    FirebaseFirestore.instance
        .collection(catId)
        .add(ItemModel.toMap(model))
        .then((value) {
      emit(AddCategorySuccessState());
    }).catchError((error) {
      emit(AddCategoryErrorState());
    });
  }
  List<ItemModel>? items;
  getCategoryItems(String catId)async{
    emit(GetCatItemsLoadingState());
    int index=0;
   await FirebaseFirestore.instance
        .collection(catId)
        .get()
        .then((catItems){
      items=[];
     for (var element in catItems.docs) {
       items!.add(ItemModel.fromJson(element.data()));
       items![index].itemId = element.id;
       index++;
      }
      emit(GetCatItemsSuccessState());
    });
  }




  deleteItem({required String itemID,required String catId,required String image})async{
    emit(DeleteItemLoadingState());
    items!.removeWhere((element) => element.itemId==itemID);
    await FirebaseFirestore.instance
        .collection(catId)
        .doc(itemID)
        .delete()
        .then((value){
          firebase_storage.FirebaseStorage.instance.refFromURL(image).delete().then((value){
            emit(DeleteItemSuccessState());
          });
    }).catchError((onError){
      emit(DeleteItemErrorState());
    });
  }

  editItem({
    required String itemId,
    required String catId,
    required String name,
    required String image,
    required String description,
    required String link,
    required int index,
    bool newImage=false,
  })async{
    String ?newLinkImage;
    emit(EditItemLoadingState());
    if(newImage)
      {
        await firebase_storage.FirebaseStorage.instance.refFromURL(image).delete();
        newLinkImage = await uploadItemImage(catId: catId);
      }
    ItemModel newItem=ItemModel(
        itemName: name,
        itemId: itemId,
        catId: catId,
        image: newLinkImage??image,
        description: description,
        link: link);
    await FirebaseFirestore.instance.collection(catId).doc(itemId).update(
     ItemModel.toMap(newItem)
    ).then((value){
      items!.removeWhere((element) => element.itemId==itemId);
      items!.insert(index, newItem);
      emit(EditItemSuccessState());
    });
  }
}
