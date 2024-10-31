import 'package:get/get.dart';

class SearchController extends GetxController{
  var isSearching=false.obs;
  void toggleSearch(){
    isSearching.value=!isSearching.value;

  }
  void clearSearch(){
    isSearching.value=false;
  }
}