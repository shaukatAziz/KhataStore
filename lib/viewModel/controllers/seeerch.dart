
// Column(
// children: [
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: TextField(
// onChanged: (value) {
// searchController.filterSearchResults(value); // Filter results
// },
// decoration: InputDecoration(
// labelText: 'Search Customers',
// prefixIcon: const Icon(Icons.search),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(8.0),
// ),
// ),
// ),
// ),
// Expanded(
// child: Obx(() {
// if (searchController.filteredCustomers.isEmpty) {
// return const Center(child: Text('No customers found'));
// } else {
// return ListView.builder(
// itemCount: searchController.filteredCustomers.length,
// itemBuilder: (context, index) {
// final customer =
// searchController.filteredCustomers[index];
// return ListTile(
// title: Text(customer.name),
// subtitle: Text(customer.phone),
// );
// },
// );
// }
// }),
// ),
// ],
// ),
// );
// }
// }
//********************************************************************************************************************
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   bool _isSearching = false;
//   TextEditingController _searchController = TextEditingController();
//
//   void _toggleSearch() {
//     setState(() {
//       _isSearching = !_isSearching;
//       if (!_isSearching) {
//         _searchController.clear(); // Clear the search text when closing
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Example'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: _toggleSearch,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           if (_isSearching)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 50, // Example item count
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('Item $index'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// late stt.SpeechToText _speech;
// var isListening=false.obs;
// var regonisedText="".obs;
// void onInit(){
//   super.onInit();
//   _speech=stt.SpeechToText();
// }
//
// void listen()async{
//   if(!isListening.value){
//     bool listening=await _speech.initialize(
//       onStatus: (val)=>print('status $val'),
//       onError: (val)=>print('error $val')
//     );
//     if(listening){
//       isListening.value=true;
//       _speech.listen(onResult: (val){
//         regonisedText.value=val.recognizedWords;
//       });
//     }else{
//       isListening.value=false;
//       _speech.stop();
//     }
//   }
// }
// String extractDigits(String input){
//   return input.replaceAll(RegExp(r'\D'), '');
// }
//***********************************************
// import 'package:get/get.dart';
//
// class SearchController extends GetxController {
//   var isSearching = false.obs;
//
//   void toggleSearch() {
//     isSearching.value = !isSearching.value;
//   }
//
//   void clearSearch() {
//     isSearching.value = false;
//   }
// }
// ******************************************
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'search_controller.dart'; // Ensure to import your SearchController
//
// class SearchScreen extends StatelessWidget {
//   final SearchController searchController = Get.put(SearchController());
//   final TextEditingController _searchFieldController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Example'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: searchController.toggleSearch,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Obx(() {
//             if (searchController.isSearching.value) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _searchFieldController,
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSubmitted: (value) {
//                     // Handle search action here
//                   },
//                 ),
//               );
//             }
//             return SizedBox.shrink(); // No search bar if not searching
//           }),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 50, // Example item count
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('Item $index'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// *****************************************************
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'search_controller.dart'; // Import your controller file
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: SearchScreen(),
//     );
//   }
// }
//
// class SearchScreen extends StatelessWidget {
//   final SearchController searchController = Get.put(SearchController());
//   final TextEditingController _searchFieldController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Example'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: searchController.toggleSearch,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Obx(() {
//             if (searchController.isSearching.value) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _searchFieldController,
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSubmitted: (value) {
//                     // Handle search action here
//                   },
//                 ),
//               );
//             }
//             return SizedBox.shrink(); // No search bar if not searching
//           }),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 50, // Example item count
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('Item $index'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
