class HomeModel
{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status=json['status'];
    data=json['data'] != null ? new HomeDataModel.fromJson(json['data']) : null;
    //HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel>banners = [];
  List<ProductModel>products = [];
  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    if(json['banners'] != null) {
      json['banners'].forEach((element) {
        banners.add(BannerModel.fromJson(element));
      });
    }

    if(json['products'] != null) {
      json['products'].forEach((element) {
        products.add(ProductModel.fromJson(element));
      });
    }
  }

}
class BannerModel
{
  late final id;
  late String image;
  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];

  }

}

class ProductModel
{
  late int id;
  late final price;
  late final oldPrice;
  int? discount;
  late String image;
  late String name;
  String? description;
  List<String> images = [];
  late bool inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];

  }
}