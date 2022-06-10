import 'package:bigcart_ecommerce_app/Models/CartModel.dart';
import 'package:flutter/cupertino.dart';
import '../Utility/shared_preference.dart';

class Cart_Provider extends ChangeNotifier{

  List<CartModel> _cartProductList=[];
  List<CartModel> get cartProductList => _cartProductList;

  int getItemIndex(int id)
  {
    int index = _cartProductList.indexWhere((element) => element.productId == id);
    return index;
  }

  void addProductToCart (CartModel cartModel)
  {
    int index = getItemIndex(cartModel.productId);
    if(index==-1)
      {
        _cartProductList.add(cartModel);
        User_Perference().saveCartItems(_cartProductList);
        notifyListeners();
      }
    else{
      User_Perference().removeCartItems();
      _cartProductList[index].qty++;
      User_Perference().saveCartItems(_cartProductList);
      notifyListeners();
    }
  }

  void getCartListLoaded(){
    User_Perference().getCartItems().then((value) =>
    _cartProductList =value
    );
  }

  void incrementProductQyt(int id){
   int index = getItemIndex(id);
   if (index>=0 && _cartProductList[index].productId==id) {
       if (_cartProductList[index].stock != _cartProductList[index].qty) {
         User_Perference().removeCartItems();
         _cartProductList[index].qty++;
         User_Perference().saveCartItems(_cartProductList);
         notifyListeners();
       }
   }
  }

  void decrementProductQyt(int id) {
    int index = getItemIndex(id);
    if (index >= 0 && _cartProductList[index].productId == id) {
      if (_cartProductList[index].qty >= 1) {
        User_Perference().removeCartItems();
        _cartProductList[index].qty--;
        User_Perference().saveCartItems(_cartProductList);
        notifyListeners();
      }
      if(_cartProductList[index].qty <= 0 && _cartProductList[index].productFavorite == false) {
        User_Perference().removeCartItems();
        _cartProductList.removeAt(index);
        User_Perference().saveCartItems(_cartProductList);
        notifyListeners();
      }
    }
  }

  void addToFavorite({required CartModel cartModel, required int id}){
   int index = getItemIndex(id);
   if (index>=0) {
     if(_cartProductList[index].productId==id)
       {
         User_Perference().removeCartItems();
         _cartProductList[index].productFavorite=true;
         User_Perference().saveCartItems(_cartProductList);
         notifyListeners();
       }
   }
   else{
     User_Perference().removeCartItems();
     addProductToCart(cartModel);
     User_Perference().saveCartItems(_cartProductList);
   }
  }

  void removeFromFavorite(int id) {
    int index = getItemIndex(id);
    if (index >= 0 && _cartProductList[index].productId == id) {
      if (getProductQyt(id) != 0) {
        User_Perference().removeCartItems();
        _cartProductList[index].productFavorite=false;
        User_Perference().saveCartItems(_cartProductList);
        notifyListeners();
      }
      else{
        User_Perference().removeCartItems();
        _cartProductList.removeAt(index);
        User_Perference().saveCartItems(_cartProductList);
        notifyListeners();
      }
    }
  }

  bool isProductFavorite(int id){
    int index = getItemIndex(id);
    if (index>=0) {
      if(_cartProductList[index].productId==id)
      {
        return _cartProductList[index].productFavorite;
      }
    }
    return false;
  }

  void removeProduct(int id)
  {
    int index = getItemIndex(id);
    if (index >= 0) {
      if (_cartProductList[index].productId == id) {
        User_Perference().removeCartItems();
        _cartProductList.removeAt(index);
        User_Perference().saveCartItems(_cartProductList);
        notifyListeners();
      }
    }
  }

  int getProductQyt(int id){
    if (_cartProductList.isNotEmpty) {
      int index = getItemIndex(id);
      if(index >= 0){
        return _cartProductList[index].qty;
      }
    }
    return 0;
  }

  bool isProductAdded(int id)
  {
    int index = getItemIndex(id);
    if(index>=0)
      {
       if(getProductQyt(id)>=1)
         {
           return true;
         }
      }
        return false;
  }

  double getProductsPrice()
  {
    double price=0;
        for (var element in _cartProductList) {
         price += element.qty*element.price;
        }
    return price;
  }
}