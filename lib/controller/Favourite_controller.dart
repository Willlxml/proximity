import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FavouriteController extends GetxController {
  RxList _favorite = [].obs;
  RxList get favorite => _favorite;

  void toggleFavorite(dynamic favorite, BuildContext context) {
    final isExist = _favorite.contains(favorite);
    if (isExist) {
      _favorite.remove(favorite);
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(Icons.info, color: Colors.white,),
            SizedBox(width: 10,),
            Text("Removed from Favorites", style: TextStyle(fontWeight: FontWeight.w600),),
          ],
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    } else {
      _favorite.add(favorite);
      final snackBar = SnackBar(
        duration: 3.seconds,
        elevation: 0,
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(Icons.info, color: Colors.white,),
            SizedBox(width: 10,),
            Text("Added to Favorites", style: TextStyle(fontWeight: FontWeight.w600),),
          ],
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
    }
    update();
  }

  bool isExist(dynamic favorite) {
    final isExist = _favorite.contains(favorite);
    return isExist;
  }

  void clearFavorite() {
    _favorite = [].obs;
    update();
  }
}
