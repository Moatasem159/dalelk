class ItemModel{
  final String catId;
  String itemId;
  final String itemName;
  final String image;
  final String description;
  final String link;

  ItemModel(
      {required this.itemName,
        required this.itemId,
        required this.catId,
        required this.image,
      required this.description,
      required this.link});

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    itemName: json["name"],
    catId: json["catId"],
    itemId: json["itemId"],
    image: json["image"],
    description: json["description"],
    link: json["link"],
  );
  static Map<String, dynamic> toMap(ItemModel categoryModel) => {
    "name": categoryModel.itemName,
    "catId": categoryModel.catId,
    "itemId": categoryModel.itemId,
    "image": categoryModel.image,
    "description": categoryModel.description,
    "link": categoryModel.link,
  };
}
