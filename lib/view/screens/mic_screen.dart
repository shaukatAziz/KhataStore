import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../models/customerModel.dart';
import '../../viewModel/Boxes/box.dart';
import '../../viewModel/controllers/dashbaord_controller.dart';

class MicScreen extends StatefulWidget {
  final String userId;
  const MicScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<MicScreen> createState() => _MicScreenState();
}

class _MicScreenState extends State<MicScreen> {
  final DashBoardController controller = Get.put(DashBoardController());
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';
  String? _customerName;
  String? _customerPhone;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

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

  void _startListening() async {
    if (!_isListening) {
      print('Starting to listen...');
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _recognizedText = result.recognizedWords;
              print('Recognized: $_recognizedText');
              _extractCustomerDetails();
            });
          },
        );
      } else {
        print('Microphone not available');
        Get.snackbar('Error', 'Speech recognition is not available');
      }
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
    print('Stopped listening');
  }

  void _extractCustomerDetails() {
    List<String> parts = _recognizedText.split(' ');
    if (parts.length >= 2) {
      _customerName = parts[0];
      _customerPhone = parts[1];
      print('Extracted Name: $_customerName, Phone: $_customerPhone');
      _addCustomerAutomatically();
    } else {
      print('Incomplete details. Please say both name and phone number.');
      Get.snackbar('Error', 'Please say both name and phone number.');
    }
  }

  void _addCustomerAutomatically() {
    if (_customerName != null && _customerPhone != null) {
      final newCustomer = CustomerModel(
        userId: widget.userId,
        name: _customerName!,
        phoneNumber: _customerPhone!,
        openingBalance: 0,
        closingBalance: 0,
      );

      Boxes.getData().add(newCustomer);
      print('Customer added: $_customerName - $_customerPhone');
      Get.snackbar('Success', 'Customer added successfully!',
          snackPosition: SnackPosition.BOTTOM);
      _resetFields();
    }
  }

  void _resetFields() {
    setState(() {
      _recognizedText = '';
      _customerName = null;
      _customerPhone = null;
      _stopListening();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer by Voice'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Press the mic and say the customer\'s name and phone number',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            Text(
              _recognizedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: AvatarGlow(
                glowColor: Colors.blue,


                duration: const Duration(milliseconds: 2000),
                repeat: true,
                animate: _isListening,
                child: GestureDetector(
                  onLongPress: _isListening ? _stopListening : _startListening,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: null,
                    child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
