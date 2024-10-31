import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../models/customerModel.dart';
import '../Boxes/box.dart';

class MicController extends GetxController {
  late stt.SpeechToText _speech;
  var isListening = false.obs; // Using Rx for reactive variable
  var recognizedText = ''.obs;
  String? customerName;
  String? customerPhone;

  @override
  void onInit() {
    super.onInit();
    _initializeSpeech();
  }

  /// Initialize Speech-to-Text with logs
  void _initializeSpeech() async {
    _speech = stt.SpeechToText();
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech Status: $status'),
      onError: (error) => print('Speech Error: $error'),
    );

    if (!available) {
      print('Speech recognition not available');
      Get.snackbar('Error', 'Speech recognition is not available');
    } else {
      print('Speech recognition initialized successfully');
    }
  }

  /// Start listening with debug logs
  void startListening() async {
    if (!isListening.value) {
      print('Starting to listen...');
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );

      if (available) {
        isListening.value = true; // Update reactive variable
        _speech.listen(
          onResult: (result) {
            recognizedText.value = result.recognizedWords; // Update recognized text
            print('Recognized: ${recognizedText.value}');
            _extractCustomerDetails();
          },
        );
      } else {
        print('Microphone not available');
        Get.snackbar('Error', 'Speech recognition is not available');
      }
    }
  }

  /// Stop listening
  void stopListening() {
    isListening.value = false; // Update reactive variable
    _speech.stop();
    print('Stopped listening');
  }

  /// Extract customer details from the speech input
  void _extractCustomerDetails() {
    List<String> parts = recognizedText.value.split(' ');
    if (parts.length >= 2) {
      customerName = parts[0];
      customerPhone = parts[1];
      print('Extracted Name: $customerName, Phone: $customerPhone');
      _addCustomerAutomatically();
    } else {
      print('Incomplete details. Please say both name and phone number.');
      Get.snackbar('Error', 'Please say both name and phone number.');
    }
  }

  /// Add the recognized customer to Hive
  void _addCustomerAutomatically() {
    if (customerName != null && customerPhone != null) {
      final newCustomer = CustomerModel(
        userId: 'userId', // Replace with actual user ID
        name: customerName!,
        phoneNumber: customerPhone!,
        openingBalance: 0,
        closingBalance: 0,
      );

      Boxes.getData().add(newCustomer);
      print('Customer added: $customerName - $customerPhone');
      Get.snackbar('Success', 'Customer added successfully!',
          snackPosition: SnackPosition.BOTTOM);
      _resetFields();
    }
  }

  /// Reset fields after adding the customer
  void _resetFields() {
    recognizedText.value = '';
    customerName = null;
    customerPhone = null;
    stopListening(); // Call stopListening
  }
}
