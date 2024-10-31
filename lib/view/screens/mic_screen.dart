import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:khata_store/Routes/routes_name.dart';
import 'package:khata_store/viewModel/controllers/micController.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../models/customerModel.dart';
import '../../viewModel/Boxes/box.dart';

class MicScreen extends StatefulWidget {
  final String userId;
  const MicScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<MicScreen> createState() => _MicScreenState();
}

class _MicScreenState extends State<MicScreen> {
  final MicController controller = Get.put(MicController());
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';
  String? _customerName;
  String? _customerPhone;
  bool customerAdded = false;

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
      customerAdded = false;
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Status: $status');
          if (status == 'done') {
            _stopListening();
          }
        },
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
          listenFor: Duration(seconds: 50),
          pauseFor: Duration(seconds: 5),
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

    if (_customerPhone != null && _customerPhone!.length == 11 && RegExp(r'^[0-9]+$').hasMatch(_customerPhone!)) {
      _addCustomerAutomatically();
    } else {
      Get.snackbar("Missing number", 'Phone number is too short or invalid');
    }
  }

  void _extractCustomerDetails() {
    List<String> parts = _recognizedText.split(' ');

    if (parts.length >= 2 && !customerAdded) {
      _customerName = parts[0];
      _customerPhone = parts.sublist(1).join().trim();
      print('Raw extracted phone: $_customerPhone');
      print('Extracted Name: $_customerName, Phone: $_customerPhone');
    } else if (!customerAdded) {
      print('Incomplete details. Please say both name and phone number.');
    }

    String command = _recognizedText.toLowerCase().trim();
    if (command.contains('dashboard screen')) {
      Get.toNamed(RoutesName.homescreen);
      _resetFields();
    } else if (command.contains('setting screen')) {
      Get.toNamed(RoutesName.settingscreen);
      _resetFields();
    }
    else if (command.contains('profile screen')) {
      Get.off(RoutesName.profilescreen);
      _resetFields();
    }
  }

  void _addCustomerAutomatically() {
    if (_customerName != null && _customerPhone != null && !customerAdded) {
      final newCustomer = CustomerModel(
        userId: widget.userId,
        name: _customerName!,
        phoneNumber: _customerPhone!,
        openingBalance: 0,
        closingBalance: 0,
      );

      Boxes.getData().add(newCustomer);
      customerAdded = true;
      print('Customer added: $_customerName - $_customerPhone');
      Get.snackbar('Success', 'Customer added successfully!', snackPosition: SnackPosition.BOTTOM);
      _resetFields();
    }
  }

  void _resetFields() {
    setState(() {
      _recognizedText = '';
      _customerName = null;
      _customerPhone = null;
      customerAdded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Speak'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Hold Mic And Speak',
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
            const Spacer(),
            Center(
              child: GestureDetector(
                onLongPressStart: (_) => _startListening(),
                onLongPressEnd: (_) => _stopListening(),
                child: AvatarGlow(
                  glowColor: Colors.blue,
                  duration: const Duration(milliseconds: 2000),
                  repeat: true,
                  animate: _isListening,
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
